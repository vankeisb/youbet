<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="choicesAndAmounts" value="${renderPropertyValue.choicesAndAmounts}"/>
<script type="text/javascript">
    dojo.require("dijit.form.NumberTextBox");
    dojo.require("dijit.form.Button");
</script>
<div class="betChoices">
    <table cellspacing="8">
        <thead>
        <tr>
            <th>&nbsp;</th>
            <th>Your bet</th>
            <th>All bets</th>
            <th>&nbsp;</th>
        </tr>
        </thead>
        <tbody>
            <c:forEach var="row" items="${choicesAndAmounts}" varStatus="vs">
                <tr>
                    <td><c:out value="${row.choice.title}"/></td>
                    <td class="numCell">${row.userBet}</td>
                    <td class="numCell">${row.total}</td>
                    <td>
                        <input id="amount_${vs.index}"
                               type="text"
                               dojoType="dijit.form.NumberTextBox"
                               name="amount_${vs.index}"
                               constraints="{min:1}"
                                style="width: 50px;">

                        <button id="add_${vs.index}" data-dojo-type="dijit.form.Button" type="button">
                            add
                            <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                                // TODO
                            </script>
                        </button>
                        <div data-dojo-type="dijit.Tooltip" data-dojo-props="connectId:'save',position:['above']">
                            Click to add an amount to this choice. The amount will be added
                            to what you have already put on this choice.
                        </div>




                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>