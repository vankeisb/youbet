<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="y" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="bet" value="${close.facetContext.targetObject}"/>
<w:facet facetName="layout" targetObject="${bet}"/>
<w:facet targetObject="${bet}" facetName="renderTitle"/>
<s:layout-render name="${layout.layoutPath}" layout="${layout}" pageTitle="Close bet">
    <s:layout-component name="body">
        <div class="wokoObject">
            <w:includeFacet targetObject="${bet}" facetName="renderTitle"/>
            <p>
                Please select the good choice for this bet, and submit. All amounts will
                be computed, and participants will be notified.
            </p>
            <s:form id="closeForm" action="/close">
                <s:hidden name="className" value="Bet"/>
                <s:hidden name="key" value="${bet.id}"/>
                Good choice : <s:select name="facet.choice">
                    <s:options-collection collection="${bet.choices}" value="id" label="title"/>
                </s:select>
                <button data-dojo-type="dijit.form.Button" type="submit" name="closeBet">
                    Close this bet
                    <script type="dojo/method" data-dojo-event="onClick" data-dojo-args="evt">
                        this.setAttribute('disabled', true);
                        dojo.byId("closeForm").submit();
                    </script>
                </button>
            </s:form>
        </div>
    </s:layout-component>
</s:layout-render>