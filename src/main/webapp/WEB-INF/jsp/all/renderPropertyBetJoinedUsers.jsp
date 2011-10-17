<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="users" value="${renderPropertyValue.propertyValue}"/>
<c:if test="${fn:length(users)>0}">
    <p>The following user(s) have joined the bet :</p>
    <ul>
    <c:forEach var="u" items="${users}">
        <w:url object="${u}" var="userLink"/>
        <li><a href="${userLink}">${u.username}</a></li>
    </c:forEach>
    </ul>
</c:if>



