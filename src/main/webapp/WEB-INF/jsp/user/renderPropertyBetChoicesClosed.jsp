<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<c:set var="bet" value="${renderPropertyValue.owningObject}"/>
<h2>Good answer to the bet</h2>
<div dojoType="dijit.TitlePane" title="Choices & amounts">
    <div class="betChoices">
        <table cellpadding="8" cellspacing="0">
            <thead>
            <tr>
                <th>&nbsp;</th>
                <th>Your bet</th>
                <th>All bets</th>
                <th>You win</th>
            </tr>
            </thead>
            <tbody id="choicesBody">
            <c:forEach items="${renderPropertyValue.choicesAndAmounts}" var="row">
                <c:choose>
                    <c:when test="${row.choice.goodChoice}">
                        <c:set var="rowClass" value="goodChoice"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="rowClass" value=""/>
                    </c:otherwise>
                </c:choose>
                <tr class="${rowClass}">
                    <td class="numCell"><c:out value="${row.choice.title}"/></td>
                    <td class="numCell"><c:out value="${row.userBet}"/></td>
                    <td class="numCell"><c:out value="${row.total}"/></td>
                    <c:set var="userWin" value="${row.userReport.win - row.userReport.total}"/>
                    <td class="numCell"><c:out value="${userWin}"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
