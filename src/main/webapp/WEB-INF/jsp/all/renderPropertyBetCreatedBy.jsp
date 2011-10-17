<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<c:set var="u" value="${renderPropertyValue.propertyValue}"/>
<w:url object="${u}" var="userLink"/>
<p>This bet has been created by <a href="${userLink}">${u.username}</a></p>


