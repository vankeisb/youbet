<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
    dojo.require("dijit.form.Button");
</script>
<div class="wokoObjectLinks">
    <c:forEach var="link" items="${renderLinks.links}">
        <button class="${link.cssClass}" dojoType="dijit.form.Button" type="button" iconClass="dijitEditorIcon ${link.cssClass}">
            ${link.text}
            <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                this.setAttribute('disabled', true);
                window.location = "${pageContext.request.contextPath}/${link.href}";
            </script>
        </button>
    </c:forEach>
</div>