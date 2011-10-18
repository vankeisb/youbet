<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ tag import="com.rvkb.youbet.woko.YoubetStore" %>
<%@ tag import="woko.Woko" %>
<%@ tag import="com.rvkb.youbet.model.Bet" %>
<%@ tag import="java.util.List" %>
<%@ tag import="com.rvkb.youbet.model.BetHistoryEntry" %><%
    Woko woko = Woko.getWoko(application);
    YoubetStore store = (YoubetStore)woko.getObjectStore();
    List<BetHistoryEntry> history = store.getHistory();
%>
<div class="activity">
    <table id="betHistory">
        <tbody>
            <c:forEach var="item" items="<%=history%>">
                <tr>
                    <td rowspan="2">
                        <fmt:formatDate value="${item.creationDate}" type="both" dateStyle="short"/>
                    </td>
                    <td>
                        <w:url object="${item.bet}" var="betUrl"/>
                        <w:facet facetName="renderTitle" targetObject="${item.bet}"/>
                        <a href="${betUrl}">${renderTitle.title}</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <w:url object="${item.user}" var="userLink"/>
                        <a href="${userLink}">${item.user.username}</a>
                        ${item.message}
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>