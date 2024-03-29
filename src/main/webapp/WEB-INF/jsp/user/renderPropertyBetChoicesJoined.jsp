<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="bet" value="${renderPropertyValue.owningObject}"/>
<script type="text/javascript">
    dojo.require("dijit.form.NumberTextBox");
    dojo.require("dijit.form.Button");
    dojo.require("dojox.timing");

    dojo.addOnLoad(function() {

        var choicesAdded = false;

        var cli = new woko.rpc.Client({
            baseUrl: '${pageContext.request.contextPath}'
        });

        var buttons = [];
        var textBoxes = [];

        var createRow = function(row) {
            var choiceTitle = row.choice.title;
            var choiceId = row.choice.id;
            var userBet = row.userBet;
            var total = row.total;

            var newTr = document.createElement('tr');
            var titleTd = document.createElement('th');
            titleTd.setAttribute("id", "title_" + choiceId);
            titleTd.innerHTML = choiceTitle;
            newTr.appendChild(titleTd);

            var userBetTd = document.createElement('td');
            userBetTd.setAttribute("id", "userBet_" + choiceId);
            userBetTd.innerHTML = userBet;
            newTr.appendChild(userBetTd);
            dojo.addClass(userBetTd, 'numCell');

            var addTd = document.createElement('td');
            newTr.appendChild(addTd);
            var tb = new dijit.form.NumberTextBox({
                id: 'tb_' + choiceId,
                constraints: {
                    min: 1
                },
                style:{
                    width: "50px"
                },
                onKeyUp: function() {
                    var v = tb.get('value');
                    btn.setAttribute("disabled", isNaN(v) || (typeof v != 'number' || v<1));
                },
                onFocus: function() {
                    onTbFocused(tb);
                }
            });
            addTd.appendChild(tb.domNode);
            tb.startup();
            textBoxes.push(tb);

            var btn = new dijit.form.Button({
                label:"add",
                disabled: true,
                onClick: function() {
                    var value = tb.getValue();
                    addToChoice(choiceId, value);
                }
            });
            addTd.appendChild(btn.domNode);
            btn.startup();
            buttons.push(btn);

            var totalTd = document.createElement('td');
            totalTd.setAttribute("id", "total_" + choiceId);
            totalTd.innerHTML = total;
            newTr.appendChild(totalTd);
            dojo.addClass(totalTd, 'numCell');

            var resultTd = document.createElement('td');
            resultTd.setAttribute("id", "result_" + choiceId);

            computeResultValueAndStyle(resultTd, row.userReport);

            newTr.appendChild(resultTd);

            dojo.addClass(resultTd, 'numCell');

            return newTr;
        };

        var computeResultValueAndStyle = function(resultTd, userReport) {
            var innerH = "N/A";
            var cssClass = "zero";
            if (userReport) {
                var win = userReport.win;
                if (win!=undefined) {
                    win = win - userReport.total;
                    if (win<0) {
                        cssClass = "negative";
                    } else if (win>0) {
                        cssClass = "positive"
                    }
                    innerH = win.toString();
                }
            }
            dojo.removeClass(resultTd, ["negative","positive","zero"]);
            resultTd.innerHTML = innerH;
            dojo.addClass(resultTd, cssClass);
        };

        var onTbFocused = function(tb) {
            // clear all textboxes content, and disable buttons
            dojo.forEach(textBoxes, function(theTb) {
                if (tb!==theTb) {
                    theTb.set('value', null);
                }
            });
            dojo.forEach(buttons, function(theBtn) {
                theBtn.setAttribute('disabled', true);
            });
        };

        var refreshChoices = function(choicesAndAmounts) {
            if (choicesAndAmounts) {

                if (choicesAndAmounts.closed) {
                    timer && timer.stop();
                    window.location = "${pageContext.request.contextPath}/view/Bet/${bet.id}";
                    return;
                }

                // choices table
                for (var i = 0; i < choicesAndAmounts.items.length; i++) {
                    var row = choicesAndAmounts.items[i];
                    if (!choicesAdded) {
                        var newTr = createRow(row);
                        dojo.byId('choicesBody').appendChild(newTr);
                    } else {
                        var choiceId = row.choice.id;
                        var choiceTitle = row.choice.title;
                        var userBet = row.userBet;
                        var total = row.total;
                        dojo.byId('title_' + choiceId).innerHTML = choiceTitle;
                        dojo.byId('userBet_' + choiceId).innerHTML = userBet;
                        dojo.byId('total_' + choiceId).innerHTML = total;
                        var resTd = dojo.byId('result_' + choiceId);
                        computeResultValueAndStyle(resTd,row.userReport);
                    }
                }
                choicesAdded = true;

                // refresh history
                dojo.publish("/history/${bet.id}", []);

            } else {
                cli.invokeFacet({
                    facetName: 'choicesAndAmounts',
                    className: 'Bet',
                    handleAs: "json",
                    key: ${bet.id},
                    load: function(data) {
                        refreshChoices(data);
                    },
                    error: function(err) {
                        alert('An error has occured');
                    }
                });
            }
        };

        var addToChoice = function(choiceId, theValue) {
            cli.invokeFacet({
                facetName:'addValue',
                className:'Choice',
                key: choiceId,
                handleAs: 'json',
                content: {
                    "facet.value": theValue
                },
                load: function(data) {
                    refreshChoices(data);
                    onTbFocused();
                    dijit.byId('tb_' + choiceId).focus();
                },
                error: function(data) {
                    alert('An error occured');
                }
            });
        };

        // initial population
        refreshChoices();

        // sub to the choices channel
        dojo.subscribe("/choices/${bet.id}", function() {
            refreshChoices();
        });

        <% if (request.getParameter("dontrefresh")==null) { %>
            // publish to channel infinitely
            var timer = new dojox.timing.Timer(2000);
            timer.onTick = function() {
                dojo.publish("/choices/${bet.id}", []);
            };
            timer.start();
        <% } %>

    });

</script>

<div class="betChoices" dojoType="dijit.TitlePane" title="Choices & amounts">
    <table cellpadding="8" cellspacing="0">
        <thead>
        <tr>
            <th>&nbsp;</th>
            <th>Your bet</th>
            <th>&nbsp;</th>
            <th>All bets</th>
            <th>You win</th>
        </tr>
        </thead>
        <tbody id="choicesBody">
        </tbody>
    </table>
</div>
