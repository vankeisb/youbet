<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="choices" value="${renderPropertyValue.propertyValue}"/>
<c:set var="bet" value="${renderPropertyValue.bet}"/>
<div class="betChoices">
    <table>
        <thead>
        <tr>
            <th>#</th>
            <th>Choice</th>
            <th>Your bet</th>
            <th>Other bets</th>
        </tr>
        </thead>
        <tbody>
            <c:forEach var="choice" items="${choices}" varStatus="vs">
                <tr>
                    <td>${vs.index}</td>
                    <td><c:out value="${choice.title}"/></td>
                    <td>TODO</td>
                    <td>TODO</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>