<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="choices" value="${renderPropertyValue.propertyValue}"/>
<c:set var="bet" value="${renderPropertyValue.bet}"/>
<div class="betChoices">
    <table>
        <thead>
        <tr>
            <th>#</th>
            <th>Choice</th>
            <c:if test="${bet.published}">
                <th>All bets</th>
            </c:if>
        </tr>
        </thead>
        <tbody>
            <c:forEach var="choice" items="${choices}" varStatus="vs">
                <tr>
                    <td>${vs.index}</td>
                    <td><c:out value="${choice.title}"/></td>
                    <c:if test="${bet.published}">
                        <td>${choice.total}</td>
                    </c:if>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>