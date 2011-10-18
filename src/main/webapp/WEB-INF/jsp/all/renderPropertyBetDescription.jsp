<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="d" value="${renderPropertyValue.propertyValue}"/>
<script type="text/javascript">
    dojo.addOnLoad(function() {
        var a = dojo.byId("dscLink");
        var d = dojo.byId("betDescription");
        dojo.connect(a, 'onclick', function() {
            var collapsed = a.getAttribute("collapsed") === true;
            a.collapsed = !collapsed;
            if (collapsed) {
                a.innerHTML = "[hide]";
            } else {
                a.innerHTML = "[show]";
            }
            a.setAttribute("style", "display:" + (collapsed ? "none;" : "block;"));
        });
    });
</script>
<c:if test="${not empty d}">
    <h2>Description <span class="titleLink"><a id="dscLink" href="#">[hide]</a></span></h2>
    <div id="betDescription" class="betDescription">${d}</div>
</c:if>

