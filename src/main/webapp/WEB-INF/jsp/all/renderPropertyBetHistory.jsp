<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="bet" value="${renderPropertyValue.owningObject}"/>
<script type="text/javascript">
    dojo.require("dijit.TitlePane");
    dojo.addOnLoad(function() {
        var cli = new woko.rpc.Client({baseUrl:"${pageContext.request.contextPath}"});
        dojo.subscribe("/history/${bet.id}", function() {
            cli.invokeFacet({
                facetName: "betHistoryFragment",
                className: "Bet",
                key: ${bet.id},
                load: function(resp) {
                    dojo.byId('betHistory').innerHTML = resp;
                },
                error: function(resp) {
                    alert('An error occured.');
                }
            });
        });
    });
</script>
<div dojoType="dijit.TitlePane" title="Bet history">
    <div id="betHistory">
        <w:includeFacet facetName="betHistoryFragment" targetObject="${bet}"/>
    </div>
</div>

