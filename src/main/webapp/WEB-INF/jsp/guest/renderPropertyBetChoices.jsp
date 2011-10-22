<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="choices" value="${renderPropertyValue.propertyValue}"/>
<c:set var="bet" value="${renderPropertyValue.bet}"/>
<div dojoType="dijit.TitlePane" title="Choices & amounts">
    <div class="betChoices">
        <table cellpadding="8" cellspacing="0">
            <thead>
            <tr>
                <th>&nbsp;</th>
                <c:if test="${bet.published}">
                    <th>All bets</th>
                </c:if>
            </tr>
            </thead>
            <tbody>
                <c:forEach var="choice" items="${choices}" varStatus="vs">
                    <tr>
                        <th><c:out value="${choice.title}"/></th>
                        <c:if test="${bet.published}">
                            <td class="numCell">${choice.total}</td>
                        </c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>