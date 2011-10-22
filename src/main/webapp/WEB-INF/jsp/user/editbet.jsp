<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="bet" value="${edit.facetContext.targetObject}"/>
<w:facet facetName="layout" targetObject="${bet}"/>
<c:choose>
    <c:when test="${bet!=null}">
        <c:set var="title" value="Edit - ${bet.title}"/>
    </c:when>
    <c:otherwise>
        <c:set var="title" value="New bet"/>
    </c:otherwise>
</c:choose>
<s:layout-render name="${layout.layoutPath}" layout="${layout}" bodyClass="claro" pageTitle="${title}">

    <s:layout-component name="customJs">
        <script type="text/javascript">
            dojo.require("dijit.form.TextBox");
            dojo.require("dijit.form.Button");
            dojo.require("dijit.Editor");
            dojo.require("dijit.layout.TabContainer");
            dojo.require("dijit.layout.ContentPane");
            dojo.require("dijit.Tooltip");

            var idCounter = 0;

            var formControls = [];

            var genId = function() {
                var res = "gen_" + idCounter;
                idCounter++;
                return res;
            };

            var countRows = function() {
                var i = 0;
                dojo.query('tr', dojo.byId('choices_body')).forEach(function(node) {
                    i++
                });
                return i;
            };

            var updateButtons = function() {
                var enableFirst = countRows() > 1;
                dojo.query('tr', dojo.byId('choices_body')).forEach(function(node, index) {
                    var theId = node.getAttribute('id');
                    var enabled = enableFirst || index > 0;
                    dijit.byId('btnMinus' + theId).setAttribute('disabled', !enabled);
                });
            };

            var createCells = function(theTr, theLabel) {
                var theId = genId();
                dojo.attr(theTr, 'id', theId);
                var titleTd = document.createElement("td");
                theTr.appendChild(titleTd);
                var textBox = new dijit.form.TextBox({
                    id: "choiceTb" + theId,
                    style: {
                        width: "300px"
                    }
                });
                formControls.push(textBox);
                dojo.connect(textBox, 'onKeyUp', function() {
                    dijit.byId('save').setAttribute('disabled', false);
                });
                titleTd.appendChild(textBox.domNode);
                textBox.startup();
                if (theLabel) {
                    textBox.setValue(theLabel);
                }
                var btnsTd = document.createElement("td");
                theTr.appendChild(btnsTd);
                var btnPlus = new dijit.form.Button({
                    id:'btnPlus' + theId,
                    label:"+",
                    onClick: function() {
                        addChoiceAfter(theTr);
                        updateButtons();
                    }
                });
                formControls.push(btnPlus);
                btnsTd.appendChild(btnPlus.domNode);
                btnPlus.startup();
                var btnMinus = new dijit.form.Button({
                    disabled: true,
                    id:'btnMinus' + theId,
                    label:"-",
                    onClick: function() {
                        removeRow(theTr);
                        updateButtons();
                    }
                });
                formControls.push(btnMinus);
                btnsTd.appendChild(btnMinus.domNode);
                btnMinus.startup();
            };

            var createRow = function(theLabel) {
                // add a new row
                var newTr = document.createElement("tr");
                createCells(newTr, theLabel);
                return newTr;
            };

            var addChoiceAfter = function(theTr, theLabel) {
                var tBody = dojo.byId('choices_body');
                if (theTr) {
                    // compute the index of selected tr
                    var i = 0, curTr = theTr.previousSibling;
                    while (curTr) {
                        if (curTr.tagName && curTr.tagName.toLowerCase()==='tr') {
                            i++;
                        }
                        curTr = curTr.previousSibling;
                    }
                    var newRow = tBody.insertRow(i+1);
                    createCells(newRow, theLabel);
                } else {
                    // append at end
                    tBody.appendChild(createRow(theLabel));
                }
            };

            var removeRow = function(theTr) {
                // destroy widgets
                var theId = theTr.getAttribute('id');
                dojo.forEach([
                    "choiceTb" + theId,
                    "btnPlus" + theId,
                    "btnMinus" + theId],
                    function(o) {
                        dijit.byId(o).destroy();
                    }
                );
                // remove row from dom
                var parentNode = theTr.parentNode;
                parentNode.removeChild(theTr);

            };

            var createBet = function() {
                // grab all data from dijit widgets
                var title = dijit.byId('title').attr('value');
                var description = dijit.byId('description').attr('value');
                var choices = [];
                dojo.query('tr', dojo.byId('choices_body')).forEach(function(node) {
                    var theId = dojo.attr(node,'id');
                    var theWidget = dijit.byId('choiceTb' + theId);
                    var val = theWidget.getValue();
                    if (val) {
                        choices.push(val);
                    }
                });
                var content = {
                    isRpc: true
                };
                dojo.forEach(choices, function(choice, indx) {
                    content["facet.choices[" + indx + "]"] = choice;
                });
                // send a xhr to create or update the bet
                <c:choose>
                    <c:when test="${bet!=null}">
                        dojo.xhrPost({
                            url: "${pageContext.request.contextPath}/save/Bet/${bet.id}",
                            handleAs: "json",
                            content: dojo.mixin(content, {
                                "object.title": dijit.byId('title').getValue(),
                                "object.description": dijit.byId('description').getValue()
                            }),
                            load: function(resp) {
                                if (!resp.id) {
                                    alert('could not save your bet');
                                } else {
                                    var betId = resp.id;
                                    if (betId===null || betId===undefined) {
                                        alert('could not get the bet id in response');
                                    } else {
                                        // bet has been saved
                                        window.location="${pageContext.request.contextPath}/edit/Bet/" + betId ;
                                    }
                                }
                            },
                            error: function(resp) {
                                alert('An error occured');
                            }
                        });
                    </c:when>
                    <c:otherwise>
                        dojo.xhrPost({
                            url: "${pageContext.request.contextPath}/createBet",
                            handleAs: "json",
                            content: dojo.mixin(content, {
                                  "facet.title": title,
                                  "facet.description": description
                                }),
                            load: function(resp) {
                                if (!resp.betId) {
                                    alert('could not save your bet');
                                } else {
                                    var betId = resp.betId;
                                    if (betId===null || betId===undefined) {
                                        alert('could not get the bet id in response');
                                    } else {
                                        // bet has been saved
                                        window.location="${pageContext.request.contextPath}/edit/Bet/" + betId ;
                                    }
                                }
                            },
                            error: function(resp) {
                                alert('An error occured');
                            }
                        });
                    </c:otherwise>
                </c:choose>
            };

            <c:if test="${bet!=null && !bet.published}">
                var publish = function() {
                    var betId = ${bet.id};
                    dojo.xhrPost({
                        url: "${pageContext.request.contextPath}/publish/Bet/" + betId + "?isRpc=true",
                        handleAs: "json",
                        load: function(resp) {
                            if (!resp.success) {
                                alert('could not save your bet');
                            } else {
                                window.location="${pageContext.request.contextPath}/edit/Bet/" + betId ;
                            }
                        },
                        error: function(resp) {
                            alert('An error occured');
                        }
                    });
                };
            </c:if>

            dojo.addOnLoad(function() {
                // disable buttons
                dijit.byId("save").setAttribute("disabled", true);
                dijit.byId("publish").setAttribute("disabled", true);
                dijit.byId("close").setAttribute("disabled", true);

                // restore data if bet is not null, otherwise create an empty form
                <c:choose>
                    <c:when test="${bet!=null}">
                        var title = dojo.byId("dataTitle").innerHTML;
                        var description = dojo.byId("dataDescription").innerHTML;
                        dijit.byId("title").setValue(title);
                        dijit.byId("description").setValue(description);
                        <c:choose>
                            <c:when test="${fn:length(bet.choices)==0}">
                                addChoiceAfter();
                            </c:when>
                            <c:otherwise>
                                dojo.query('div.dataChoice', dojo.byId("dataChoices")).forEach(function(node) {
                                    addChoiceAfter(null, node.innerHTML);
                                });
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        addChoiceAfter();
                    </c:otherwise>
                </c:choose>
                updateButtons();

                <c:if test="${bet!=null && bet.published==false && fn:length(bet.choices)>1}">
                    dijit.byId('publish').setAttribute('disabled', false);
                </c:if>

                <c:if test="${bet!=null && bet.published}">
                    // disable all fields
                    formControls.push(dijit.byId('title'));
                    formControls.push(dijit.byId('description'));
                    dojo.forEach(formControls, function(fc) {
                        fc.setAttribute('disabled', true);
                    });
                    // enable the close button
                    dijit.byId('close').setAttribute('disabled', false);
                </c:if>

            });

        </script>
        <style type="text/css">
            #widget_title {
                width: 400px;
            }

            .helpTrigger {
                background-image: url("${pageContext.request.contextPath}/style/images/icon_help.gif");
                background-repeat: no-repeat;
                background-position: right;
                padding-right: 24px;
            }

        </style>
    </s:layout-component>

    <s:layout-component name="body">

        <div style="display: none;" id="betdata">
            <div id="dataTitle">${bet.title}</div>
            <div id="dataDescription">${bet.description}</div>
            <div id="dataChoices">
                <c:forEach var="choice" items="${bet.choices}" varStatus="it">
                    <div class="dataChoice" id="dataChoice_${it.index}">${choice.title}</div>
                </c:forEach>
            </div>
        </div>


        <div class="wokoObject">
            <ul class="wokoObjectLinks">
                    <li><a class="close" href="${pageContext.request.contextPath}/view/Bet/${bet.id}">Cancel edit</a></li>
            </ul>
            <c:choose>
                <c:when test="${bet==null}">
                    <h1 class="wokoObjectTitle">Create bet...</h1>
                    <p>
                        You are creating a new bet. Please fill in the details, and save.
                    </p>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${bet.published}">
                            <h1>Bet published</h1>
                            <p>
                                This bet has already been published. You can only close it now !
                            </p>
                        </c:when>
                        <c:otherwise>
                            <h1>Edit bet</h1>
                            <p>
                                Editing the bet. You can save as many times as you want. Then, once your bet
                                is ok, you can publish it so that others can join it, and bet on it.
                                <br/>
                                <br/>
                                <b>IMPORTANT</b> : you won't be able to change your bet once it's published. Make
                                sure everything is ok before you publish.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>

            <button id="save" data-dojo-type="dijit.form.Button" type="button">
                Save
                <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                    this.setAttribute('disabled', true);
                    createBet();
                </script>
            </button>
            <div data-dojo-type="dijit.Tooltip" data-dojo-props="connectId:'save',position:['above']">
                <c:choose>
                    <c:when test="${bet==null}">
                        You are creating a new bet. Once you're finished specifying the bet informations,
                        click the <b>save</b> button.<br/>You can get back to the bet and modify it until you
                        <b>publish</b> it.
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${bet.published}">
                                You cannot save the bet, it's already been published.
                            </c:when>
                            <c:otherwise>
                                Click to update your bet. You can get back to the bet and modify it until you
                                <b>publish</b> it.
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </div>
            >
            <button id="publish" data-dojo-type="dijit.form.Button" type="button">
                Publish
                <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                    publish();
                </script>
            </button>
            <div data-dojo-type="dijit.Tooltip" data-dojo-props="connectId:'publish',position:['above']">
                <c:choose>
                    <c:when test="${bet==null}">
                        Creating a new bet : please fill in the bet informations
                        and save before you publish.
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${bet.published}">
                                This bet has already been published.
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${fn:length(bet.choices)<=1}">
                                        You need at least two choices !
                                    </c:when>
                                    <c:otherwise>
                                        Click this button to <b>publish</b> your bet. It will
                                        then be open for others to join and bet.
                                        <br/>
                                        <br/>
                                        <b>IMPORTANT</b> : you won't be able to modify the bet once you publish it ! Be sure
                                        you're ready...
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </div>
            >
            <button id="close" data-dojo-type="dijit.form.Button" type="button">
                Close
                <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                    close();
                </script>
            </button>
            <div data-dojo-type="dijit.Tooltip" data-dojo-props="connectId:'close',position:['above']">
                <c:choose>
                    <c:when test="${bet==null}">
                        You need to save your bet and publish it before you can close it.
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${!bet.published}">
                                You need to publish the bet before you close it.
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${bet.closed}">
                                        This bet is already closed.
                                    </c:when>
                                    <c:otherwise>
                                        Click this button to <b>close</b> your bet by providing the
                                        good answer. Once closed, people can't bet any more
                                        and the results of the bet (for each person involved) is computed.
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </div>

            <div dojoType="dijit.layout.TabContainer" style="width: 100%;" doLayout="false">
                <div dojoType="dijit.layout.ContentPane" title="Bet details" selected="true">

                    <h2><span id="titleSection" class="helpTrigger">Title</span></h2>
                    <div data-dojo-type="dijit.Tooltip" data-dojo-props="connectId:'titleSection',position:['above']">
                        Select a short title for your bet, like :
                        <ul>
                            <li>Will it snow on christmas in Nice in 2012 ?</li>
                            <li>Is the LOSC going to win the french football championship ?</li>
                        </ul>
                    </div>
                    <input type="text" name="title" data-dojo-type="dijit.form.TextBox"
                        trim="true" id="title">
                    <script type="dojo/method" data-dojo-event="onKeyUp" data-dojo-args="evt">
                        var tb = dijit.byId('title');
                        var val = tb.getValue();
                        dijit.byId('save').setAttribute('disabled', val==null || val.length===0);
                    </script>
                    </input>?

                    <h2><span id="choicesSection" class="helpTrigger">Choices</span></h2>
                    <div data-dojo-type="dijit.Tooltip" data-dojo-props="connectId:'choicesSection',position:['above']">
                        Specify the possible answers for your bet.
                    </div>
                    <table id="choices">
                        <tbody id="choices_body">
                        </tbody>
                    </table>

                </div>
                <div dojoType="dijit.layout.ContentPane" title="Description">
                    <h2><span id="descriptionSection" class="helpTrigger">Description of the bet</span></h2>
                    <div data-dojo-type="dijit.Tooltip" data-dojo-props="connectId:'descriptionSection',position:['above']">
                        Type the rules and terms of your bet if needed, so that everybody
                        has the same understanding, and nobody complains when the bet is closed.
                    </div>
                    <div data-dojo-type="dijit.Editor" id="description">
                        <script type="dojo/method" data-dojo-event="onKeyUp" data-dojo-args="evt">
                            var tb = dijit.byId('title');
                            var val = tb.getValue();
                            dijit.byId('save').setAttribute('disabled', val==null || val.length===0);
                        </script>
                    </div>
                </div>
            </div>
        </div>
        </s:layout-component>
</s:layout-render>