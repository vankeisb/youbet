<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="choices" value="${renderPropertyValue.propertyValue}"/>
<h2>Choices</h2>
<div class="betChoices">
    <ol>
        <c:forEach var="choice" items="${choices}">
            <li><b><c:out value="${choice.title}"/></b></li>
        </c:forEach>
    </ol>
</div>


