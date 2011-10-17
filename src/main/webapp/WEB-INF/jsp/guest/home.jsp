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
        <p>
            YouBet! is an online betting-for-fun platform. You can browse bets as a
            guest, but you'll need a valid account in order to create or join
            existing bets.
        </p>
    </s:layout-component>
</s:layout-render>