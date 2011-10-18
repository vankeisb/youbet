<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="history" value="${renderPropertyValue.propertyValue}"/>
<c:set var="bet" value="${renderPropertyValue.owningObject}"/>
<c:if test="${not empty history}">
    <h2>Bet history</h2>
    <table id="betHistory">
        <tbody>
            <c:forEach var="item" items="${history}">
                <tr>
                    <td>
                        <fmt:formatDate value="${item.creationDate}" type="both" dateStyle="short"/>
                    </td>
                    <td>
                        <w:url object="${item.user}" var="userLink"/>
                        <a href="${userLink}">${item.user.username}</a>
                    </td>
                    <td>
                        ${item.message}
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</c:if>

