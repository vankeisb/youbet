<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<c:set var="bet" value="${renderPropertyValue.owningObject}"/>
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
                    <c:set var="rowClass" value="badChoice"/>
                </c:otherwise>
            </c:choose>
            <tr class="${rowClass}">
                <td class="numCell"><c:out value="${row.choice.title}"/></td>
                <td class="numCell"><c:out value="${row.userBet}"/></td>
                <td class="numCell"><c:out value="${row.total}"/></td>
                <c:set var="userWin" value="${row.userReport.win - row.userReport.total}"/>
                <c:choose>
                    <c:when test="${userWin<0}">
                        <c:set var="cssClass" value="negative"/>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${userWin>0}">
                                <c:set var="cssClass" value="positive"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="cssClass" value="zero"/>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
                <td class="numCell ${cssClass}"><c:out value="${userWin}"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
