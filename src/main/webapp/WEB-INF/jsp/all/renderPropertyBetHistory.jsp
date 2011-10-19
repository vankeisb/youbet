<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="bet" value="${renderPropertyValue.owningObject}"/>
<script type="text/javascript">
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
        dojo.publish("/history/${bet.id}", []);
    });
</script>
<h2>Bet history</h2>
<div id="betHistory">
    Loading history...
</div>

