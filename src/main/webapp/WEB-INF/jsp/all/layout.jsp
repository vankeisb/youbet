<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<w:username var="username"/>

<s:layout-definition>
    <html>
        <head>
            <title>${layout.appTitle} - ${pageTitle}</title>
            <c:set var="dojoRoot" value="${pageContext.request.contextPath}/js/dojo-1.6.1"/>
            <script type="text/javascript" src="${dojoRoot}/dojo/dojo.js"
                    djConfig="debugAtAllCosts:true, parseOnLoad:true"></script>
            <link rel="stylesheet" type="text/css" href="${dojoRoot}/dojo/resources/dojo.css">
            <link rel="stylesheet" type="text/css" href="${dojoRoot}/dijit/themes/claro/claro.css" />
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/css/youbet.css" />
            <script type="text/javascript" src="${pageContext.request.contextPath}/woko/js/woko.base.js"></script>
            <script type="text/javascript" src="${pageContext.request.contextPath}/woko/js/woko.rpc.js"></script>
            <s:layout-component name="customCss"/>
            <s:layout-component name="customJs"/>
            <script type="text/javascript">
                dojo.require("dijit.form.Button");
                dojo.require("dijit.form.TextBox");
            </script>
        </head>
        <body class="claro">
            <div id="wrap">
                <div id="header-space">
                    <div id="logo">
                        <span id="youT">You</span><span id="betT">Bet</span><span id="bangT">!</span>
                        <div id="searchBox">
                            <s:form action="/search">
                                <input type="text" name="facet.query" data-dojo-type="dijit.form.TextBox"
                                    data-dojo-props="trim:true"/>
                                <button data-dojo-type="dijit.form.Button" type="submit" name="search">
                                    search
                                    <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                                        this.setAttribute('disabled', true);
                                    </script>
                                </button>
                            </s:form>
                        </div>
                        <c:if test="${skipLoginLink==null}">
                            <span id="authInfo">
                                <c:choose>
                                    <c:when test="${username != null}">
                                        <fmt:message key="woko.layout.loggedAs"/> <strong>${username}</strong> -
                                        <a href="${pageContext.request.contextPath}/logout"><fmt:message key="woko.layout.logout"/> </a>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:message key="woko.layout.notLogged"/>
                                        <a href="${pageContext.request.contextPath}/login"><fmt:message key="woko.layout.login"/> </a>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </c:if>
                    </div>
                </div>
                <div id="navbar">
                    <div id="nbar">
                        <w:includeFacet facetName="navBar" targetObject="${layout.facetContext.targetObject}"/>
                    </div>
                </div>
                <div id="content-wrap">
                    <div id="content">
                        <s:messages/>
                        <s:errors/>
                        <s:layout-component name="body"/>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
            <div id="divider-line"></div>
        </body>
    </html>
</s:layout-definition>