<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="y" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="o" value="${actionBean.object}"/>
<w:facet facetName="layout" targetObject="${o}"/>
<w:facet targetObject="${o}" facetName="renderTitle"/>
<s:layout-render name="${layout.layoutPath}" layout="${layout}" pageTitle="Youbet: home">
    <s:layout-component name="body">
        <h1>Welcome to <y:logo/></h1>

        <h2>Your bets</h2>
        <c:set var="userBets" value="${home.userBets}"/>
        <c:choose>
            <c:when test="${not empty userBets}">
                <ul>
                <c:forEach var="bet" items="${userBets}">
                    <w:url object="${bet}" var="betUrl"/>
                    <w:facet facetName="renderTitle" targetObject="${bet}"/>
                    <li><a href="${betUrl}">${renderTitle.title}</a></li>
                </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <p>You have not created any bet yet.</p>
            </c:otherwise>
        </c:choose>
        <h2>Bets you've joined</h2>
        <c:set var="joinedBets" value="${home.joinedBets}"/>
        <c:choose>
            <c:when test="${not empty joinedBets}">
                <ul>
                <c:forEach var="bet" items="${joinedBets}">
                    <li>
                        <w:url object="${bet}" var="betUrl"/>
                        <w:facet facetName="renderTitle" targetObject="${bet}"/>
                        <a href="${betUrl}">${renderTitle.title}</a>
                        created by
                        <w:url object="${bet.createdBy}" var="userUrl"/>
                        <w:facet facetName="renderTitle" targetObject="${bet.createdBy}"/>
                        <a href="${userUrl}">${renderTitle.title}</a>
                    </li>
                </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <p>You have not joined any bet yet.</p>
            </c:otherwise>
        </c:choose>

        <h2>Recent activity</h2>
        <y:activity/>

    </s:layout-component>
</s:layout-render>