<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="d" value="${renderPropertyValue.propertyValue}"/>
<c:if test="${not empty d}">
    <h2>Description</h2>
    <div class="betDescription">${d}</div>
</c:if>

