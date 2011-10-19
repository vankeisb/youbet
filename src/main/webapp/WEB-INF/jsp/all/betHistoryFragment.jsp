<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="bet" value="${betHistoryFragment.facetContext.targetObject}"/>
<c:set var="history" value="${bet.history}"/>
<c:choose>
    <c:when test="${not empty history}">
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
    </c:when>
    <c:otherwise>
        <p>No history yet.</p>
    </c:otherwise>
</c:choose>