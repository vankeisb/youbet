<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="o" value="${actionBean.object}"/>
<w:facet facetName="layout" targetObject="${o}"/>
<w:facet targetObject="${o}" facetName="renderTitle"/>
<s:layout-render name="${layout.layoutPath}" layout="${layout}" bodyClass="claro" pageTitle="Youbet: create bet">

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

            var createCells = function(theTr) {
                var titleTd = document.createElement("td");
                theTr.appendChild(titleTd);
                var textBox = new dijit.form.TextBox();
                titleTd.appendChild(textBox.domNode);
                textBox.startup();
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

            var createRow = function() {
                // add a new row
                var newTr = document.createElement("tr");
                createCells(newTr);
                return newTr;
            };

            var addChoiceAfter = function(theTr) {
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
                    createCells(newRow);
                } else {
                    // append at end
                    tBody.appendChild(createRow());
                }
            };

            dojo.addOnLoad(function() {
                addChoiceAfter();
            });

        </script>
    </s:layout-component>

    <s:layout-component name="body">
        <h1>Create a bet</h1>
        <button data-dojo-type="dijit.form.Button" type="button">
            Save
            <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                // Do something:
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