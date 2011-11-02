<%@ tag import="woko.hbcompass.tagcloud.CompassCloud" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%
    CompassCloud cc = new CompassCloud();
%>
<script type="text/javascript">
    dojo.require("dijit.TitlePane");
</script>
<div class="tagCloud">
    <div class="tagCloud-top">Popular terms</div>
    <div class="tagCloud-bottom">
        <w:includeFacet facetName="termCloudFragment" targetObject="<%=cc%>"/>
    </div>
</div>