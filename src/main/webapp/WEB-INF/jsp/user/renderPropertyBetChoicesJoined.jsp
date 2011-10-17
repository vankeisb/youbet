<%@ page import="com.rvkb.youbet.facets.user.RenderPropertyBetChoicesUser" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="choicesAndAmounts" value="${renderPropertyValue.choicesAndAmounts}"/>
<div class="betChoices">
    <table>
        <thead>
        <tr>
            <th>#</th>
            <th>Choice</th>
            <th>Your bet</th>
            <th>All bets</th>
        </tr>
        </thead>
        <tbody>
            <c:forEach var="row" items="${choicesAndAmounts}" varStatus="vs">
                <tr>
                    <td>${vs.index}</td>
                    <td><c:out value="${row.choice.title}"/></td>
                    <td>${row.userBet}</td>
                    <td>${row.total}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>