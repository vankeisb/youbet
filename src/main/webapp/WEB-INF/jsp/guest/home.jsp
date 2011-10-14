<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="o" value="${actionBean.object}"/>
<w:facet facetName="layout" targetObject="${o}"/>
<w:facet targetObject="${o}" facetName="renderTitle"/>
<s:layout-render name="${layout.layoutPath}" layout="${layout}" pageTitle="Youbet: home">
    <s:layout-component name="body">
        <h1>Welcome to YouBet !</h1>
        <div id="addbet">
            <a href="${pageContext.request.contextPath}/newbet">Create bet</a>
        </div>
        <p>
            YouBet allows you to make bets with folks about anything.
        </p>
        <h2>Active bets</h2>
        <p>
            TODO
        </p>

    </s:layout-component>
</s:layout-render>