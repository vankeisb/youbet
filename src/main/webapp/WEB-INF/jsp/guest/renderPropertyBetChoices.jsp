<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="choices" value="${renderPropertyValue.propertyValue}"/>
<c:set var="bet" value="${renderPropertyValue.bet}"/>
<div class="betChoices" dojoType="dijit.TitlePane" title="Choices & amounts">
    <table cellpadding="8" cellspacing="0">
        <tbody>
            <c:forEach var="choice" items="${choices}" varStatus="vs">
                <tr>
                    <th><c:out value="${choice.title}"/></th>
                    <c:if test="${bet.published}">
                        <td class="numCell">
                            <c:if test="${choice.total > 0}">
                                ${choice.total}
                            </c:if>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>