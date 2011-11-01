<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ tag import="com.rvkb.youbet.woko.YoubetStore" %>
<%@ tag import="woko.Woko" %>
<%@ tag import="java.util.List" %>
<%@ tag import="com.rvkb.youbet.model.BetHistoryEntry" %>
<%@ tag import="java.util.HashMap" %>
<%@ tag import="java.util.Map" %>
<%@ tag import="com.ocpsoft.pretty.time.PrettyTime" %>
<%@ tag import="java.util.ArrayList" %><%
    Woko woko = Woko.getWoko(application);
    YoubetStore store = (YoubetStore)woko.getObjectStore();
    List<BetHistoryEntry> history = store.getHistory();
    Map<String,List<BetHistoryEntry>> entriesByDate = new HashMap<String,List<BetHistoryEntry>>();
    PrettyTime pt = new PrettyTime();
    List<String> orderedKeys = new ArrayList<String>();
    for (BetHistoryEntry e : history) {
        String prettyDate = pt.format(e.getCreationDate());
        List<BetHistoryEntry> entries4Date = entriesByDate.get(prettyDate);
        if (entries4Date==null) {
            entries4Date = new ArrayList<BetHistoryEntry>();
            entriesByDate.put(prettyDate,entries4Date);
            orderedKeys.add(prettyDate);
        }
        entries4Date.add(e);
    }
%>
<div class="activity">
    <table id="betHistory" cellspacing="0" cellpadding="0">
        <tbody>
        <%
            for (String prettyDate : orderedKeys) {
        %>
        <tr>
            <td class="dateGroup prettyDate" valign="top"><c:out value="<%=prettyDate%>"/></td>
            <td class="dateGroup" valign="top">
                <table>
                    <tbody>

        <%
            List<BetHistoryEntry> entries = entriesByDate.get(prettyDate);
            for (BetHistoryEntry e : entries) {
        %>
                <tr>
                    <td>
                        <w:url object="<%=e.getBet()%>" var="betUrl"/>
                        <w:facet facetName="renderTitle" targetObject="<%=e.getBet()%>"/>
                        <a href="${betUrl}">${renderTitle.title}</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <w:url object="<%=e.getUser()%>" var="userLink"/>
                        <a href="${userLink}"><c:out value="<%=e.getUser().getUsername()%>"/></a>
                        <%=e.getMessage()%>
                    </td>
                </tr>
        <%
            }
        %>
                    </tbody>
                </table>
            </td>
            <% } %>
        </tbody>
    </table>
</div>