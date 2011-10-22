<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="d" value="${renderPropertyValue.propertyValue}"/>
<script type="text/javascript">
    dojo.require("dijit.TitlePane");
</script>
<div dojoType="dijit.TitlePane" title="Description">
    <c:choose>
        <c:when test="${not empty d}">
            ${d}
        </c:when>
        <c:otherwise>
            This bet has no description.
        </c:otherwise>
    </c:choose>
</div>

