<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="o" value="${renderObject.facetContext.targetObject}"/>
<script type="text/javascript">
    dojo.require("dojox.timing");
    var timer = new dojox.timing.Timer(10000); // 10s timer
    timer.onTick = function() {
        dojo.publish("/choices/${o.id}", []);
    };
    timer.start();
</script>
<div class="wokoObject">
    <w:includeFacet targetObject="${o}" facetName="renderLinks"/>
    <w:includeFacet targetObject="${o}" facetName="renderTitle"/>
    <c:if test="${!o.published}">
        <div class="messages">
            This bet is not published yet.
        </div>
    </c:if>
    <c:if test="${o.closed}">
        <div class="messages">
            This bet is closed. The result of the bet is displayed. You can't
            modify this bet any more.
        </div>
    </c:if>
    <w:includeFacet targetObject="${o}" facetName="renderProperties"/>
</div