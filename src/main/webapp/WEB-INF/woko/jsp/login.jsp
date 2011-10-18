<%@ page import="woko.actions.auth.builtin.WokoLogin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<w:facet facetName="layout"/>

<fmt:message var="pageTitle" key="woko.login.pageTitle"/>
<s:layout-render name="${layout.layoutPath}" layout="${layout}" pageTitle="${pageTitle}" skipLoginLink="true">
    <s:layout-component name="body">
        <h1><fmt:message key="woko.login.title"/></h1>
            <s:form id="loginForm" beanclass="<%=WokoLogin.class%>">
                <s:hidden name="targetUrl"/>
                <s:hidden name="login" value="true"/>
                    <div class="wokoObject">
                      <table cellspacing="8">
                          <tbody>
                              <tr>
                                  <td align="right"><s:label for="user.username"/> </td>
                                  <td><s:text class="dojoLike" id="username" name="username"/></td>
                              </tr>
                              <tr>
                                  <td align="right"><s:label for="user.password"/> </td>
                                  <td><s:password class="dojoLike" id="password" name="password"/></td>
                              </tr>
                              <tr>
                                  <td colspan="2">
                                      <button id="login" name="login" data-dojo-type="dijit.form.Button" type="submit">
                                          Login
                                          <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                                              this.setAttribute('disabled', true);
                                              dojo.byId("loginForm").submit();
                                          </script>
                                      </button>
                                  </td>
                              </tr>
                          </tbody>
                      </table>
                    </div>
                <script type="text/javascript">
                    dojo.addOnLoad(function() {
                        var handleKeyStroke = function(evt) {
                            if (evt.keyCode===13) {
                                dijit.byId("login").setAttribute('disabled', true);
                                dojo.byId("loginForm").submit();
                            }
                        };
                        dojo.connect(dojo.byId("username"), 'onkeyup', handleKeyStroke);
                        dojo.connect(dojo.byId("pasword"), 'onkeyup', handleKeyStroke);
                    });
                </script>
          </s:form>
    </s:layout-component>
</s:layout-render>