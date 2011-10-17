<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="o" value="${renderObject.facetContext.targetObject}"/>
<div class="wokoObject">
    <w:includeFacet targetObject="${o}" facetName="renderLinks"/>
    <w:includeFacet targetObject="${o}" facetName="renderTitle"/>
    <c:if test="${!o.published}">
        <p>
            This bet is not published yet.
        </p>
    </c:if>
    <w:includeFacet targetObject="${o}" facetName="renderProperties"/>
</div