<%@ page import="com.rvkb.youbet.facets.all.BetHistoryFragment" %>
<%@ page import="com.rvkb.youbet.model.Bet" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rvkb.youbet.model.BetHistoryEntry" %>
<%@ page import="com.ocpsoft.pretty.time.PrettyTime" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="y" tagdir="/WEB-INF/tags" %>
<%
    BetHistoryFragment betHistoryFragment = (BetHistoryFragment)request.getAttribute("betHistoryFragment");
    Bet bet = (Bet)betHistoryFragment.getFacetContext().getTargetObject();
    List<BetHistoryEntry> history = bet.getHistory();
    PrettyTime pt = new PrettyTime();
    if (history!=null && history.size()>0) {
        Map<String,List<BetHistoryEntry>> entriesByDate = new HashMap<String, List<BetHistoryEntry>>();
        List<String> orderedKeys = new ArrayList<String>();
        for (BetHistoryEntry e : history) {
            String prettyDate = pt.format(e.getCreationDate());
            List<BetHistoryEntry> entries4date = entriesByDate.get(prettyDate);
            if (entries4date==null) {
                entries4date = new ArrayList<BetHistoryEntry>();
                entriesByDate.put(prettyDate, entries4date);
                orderedKeys.add(prettyDate);
            }
            entries4date.add(e);
        }


%>
<table id="betHistoryFragment" cellpadding="0" cellspacing="0">
    <tbody>
    <%
        for (String prettyDate : orderedKeys) {
            List<BetHistoryEntry> entries = entriesByDate.get(prettyDate);
    %>
            <tr>
                <td class="dateGroup prettyDate" valign="top">
                    <c:out value="<%=prettyDate%>"/>
                </td>
                <td class="dateGroup" valign="top">
                    <% for (BetHistoryEntry e : entries) { %>
                        <div>
                            <w:url object="<%=e.getUser()%>" var="userLink"/>
                            <a href="${userLink}"><c:out value="<%=e.getUser().getUsername()%>"/></a>
                            <%=e.getMessage()%>
                        </div>
                    <% } %>
                </td>

            </tr>
    <%
        }
    %>
    </tbody>
</table>
<%
    } else {
%>
    <p>No history yet.</p>
<% } %>