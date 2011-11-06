<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="y" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld" %>
<c:set var="o" value="${actionBean.object}"/>
<w:facet facetName="layout" targetObject="${o}"/>
<w:facet targetObject="${o}" facetName="renderTitle"/>
<s:layout-render name="${layout.layoutPath}" layout="${layout}" pageTitle="Youbet: home">
    <s:layout-component name="body">

        <div class="homeLeft">

            <y:termcloud/>

            <h1>Welcome to <y:logo/></h1>

            <p>
                <y:logo/> allows you and your mates to bet on virtually anything. It can be about the issue
                of a sports event, about how many beers one can drink under the water...
            </p>
            <p class="help">
                We don't handle the financial aspect of the bet if any. In case you're really betting
                money, we don't wanna know !
            </p>
            <p>
                You can browse bets as a
                guest, but you'll need a valid account in order to create or join
                existing bets.
            </p>

            <div class="activity" dojoType="dijit.TitlePane" title="Recent activity">
                <y:activity/>
            </div>

        </div>

    </s:layout-component>
</s:layout-render>