<%@ tag import="com.ocpsoft.pretty.time.PrettyTime" %>
<%@ attribute name="date" type="java.util.Date" required="true" %>
<%=new PrettyTime().format(date)%>