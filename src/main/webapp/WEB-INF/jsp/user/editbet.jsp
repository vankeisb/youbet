<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <c:set var="dojoRoot" value="${pageContext.request.contextPath}/js/dojo-1.6.1"/>
        <script type="text/javascript" src="${dojoRoot}/dojo/dojo.js"
                djConfig="debugAtAllCosts:true, parseOnLoad:true"></script>
        <link rel="stylesheet" type="text/css" href="${dojoRoot}/dojo/resources/dojo.css">
        <link rel="stylesheet" type="text/css" href="${dojoRoot}/dijit/themes/claro/claro.css" />
        <script type="text/javascript">
            dojo.require("dijit.form.TextBox");
            dojo.require("dijit.form.Button");
            dojo.require("dijit.Editor");

            var idCounter = 0;

            var genId = function() {
                var res = "gen_" + idCounter;
                idCounter++;
                return res;
            };

            var createCells = function(theTr, theLabel) {
                var theId = genId();
                dojo.attr(theTr, 'id', theId);
                var titleTd = document.createElement("td");
                theTr.appendChild(titleTd);
                var textBox = new dijit.form.TextBox({id: "choiceTb" + theId});
                titleTd.appendChild(textBox.domNode);
                textBox.startup();
                if (theLabel) {
                    textBox.setValue(theLabel);
                }
                var btnsTd = document.createElement("td");
                theTr.appendChild(btnsTd);
                var btnPlus = new dijit.form.Button({label:"+"});
                btnsTd.appendChild(btnPlus.domNode);
                btnPlus.startup();
                dojo.connect(btnPlus, 'onClick', function() {
                    addChoiceAfter(theTr);
                });
                var btnMinus = new dijit.form.Button({label:"-"});
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

            dojo.addOnLoad(function() {
                // restore data if bet is not null, otherwise create an empty form
                <c:choose>
                    <c:when test="${bet!=null}">
                        var title = dojo.byId("dataTitle").innerHTML;
                        var description = dojo.byId("dataDescription").innerHTML;
                        dijit.byId("title").setValue(title);
                        dijit.byId("description").setValue(description);
                        dojo.query('div.dataChoice', dojo.byId("dataChoices")).forEach(function(node) {
                            addChoiceAfter(null, node.innerHTML);
                        });
                    </c:when>
                    <c:otherwise>
                        addChoiceAfter();
                    </c:otherwise>
                </c:choose>
            });

        </script>
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

        <h1>Create a bet</h1>
        <button data-dojo-type="dijit.form.Button" type="button">
            Save
            <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                this.setAttribute('disabled', true);
                createBet();
            </script>
        </button>
        <div class="help">
            Select a short title for your bet, like :
            <ul>
                <li>Will it snow on christmas in Nice in 2012 ?</li>
                <li>Is the LOSC going to win the french football championship ?</li>
            </ul>
        </div>
        <label for="title">
            Bet title
        </label>
        <input type="text" name="title" value="" size="100" data-dojo-type="dijit.form.TextBox"
            trim="true" id="title">
        <h2>Choices</h2>
        <table id="choices">
            <tbody id="choices_body">
            </tbody>
        </table>
        <h2>Description</h2>
        <div class="help">
            Type the rules and terms of your bet if needed, so that everybody
            has the same understanding, and nobody complains when the bet is closed.
        </div>
        <div data-dojo-type="dijit.Editor" id="description" data-dojo-props="onChange:function(){console.log('editor1 onChange handler: ' + arguments[0])}">
        </div>
    </s:layout-component>
</s:layout-render>