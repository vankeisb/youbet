<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="w" tagdir="/WEB-INF/tags/woko" %>
<%@ taglib prefix="y" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="o" value="${actionBean.object}"/>
<w:facet facetName="layout" targetObject="${o}"/>
<w:facet targetObject="${o}" facetName="renderTitle"/>
<s:layout-render name="${layout.layoutPath}" layout="${layout}">
    <s:layout-component name="body">
        <h1>Welcome to <y:logo/></h1>

        <script type="text/javascript">
            dojo.require('dijit.form.CheckBox');
        </script>

        <h2>Your bets</h2>
        <div class="betOptions">
            <input id="cbJoined" name="cbJoined" dojoType="dijit.form.CheckBox" value="joined"
                checked onChange="dojo.publish('/filter', []);">
            <label for="cbJoined">
                display joined bets
            </label>
        </div>

        <div id="myBets"></div>
        <script type="text/javascript">

            var createBetLi = function(theUl, bet, owned) {
                var theLi = document.createElement('li');
                theUl.appendChild(theLi);
                var theA = document.createElement("a");
                theLi.appendChild(theA);
                theA.innerHTML = bet._title;
                theA.href = "${pageContext.request.contextPath}/view/Bet/" + bet.id;
                dojo.addClass(theLi, owned ? "ownedBet" : "joinedBet");
            };

            var displayBets = function(cntr, bets, includeJoined) {
                dojo.empty(cntr);
                var theUl = document.createElement('ul');
                cntr.appendChild(theUl);
                var noBets = true;
                if (bets && bets.length>0) {
                    dojo.forEach(bets, function(b) {
                        var owned = b.createdBy._key === "${home.currentUserId}";
                        var theLi;
                        if (owned) {
                            noBets = false;
                            createBetLi(theUl, b, owned);
                        } else {
                            if (includeJoined) {
                                noBets = false;
                                createBetLi(theUl, b, owned);
                            }
                        }
                    });
                }
                if (noBets) {
                    cntr.innerHTML = "<p>You have no bets yet.</p>";
                }
            };

            dojo.addOnLoad(function() {
                var cntr = dojo.byId('myBets');
                dojo.addClass(cntr, 'ajaxLoaderBig');
                // load user's bets
                var cli = new woko.rpc.Client({
                    baseUrl: '${pageContext.request.contextPath}'
                });
                var bets;
                cli.invokeFacet({
                    facetName: 'mybets',
                    handleAs: "json",
                    load: function(data) {
                        //  build the dom for bet list
                        bets = data.bets;
                        displayBets(cntr, bets, true);
                        // remove the load class
                        dojo.removeClass(cntr, 'ajaxLoaderBig');
                        if (bets) {
                            // subscribe to the filtering channel
                            dojo.subscribe('/filter', function(data) {
                                var cbJoined = dijit.byId('cbJoined');
                                var joined = cbJoined.attr('value') != false;
                                displayBets(cntr, bets, joined);
                            });
                        }
                    },
                    error: function(err) {
                        cntr.innerHTML = "Error : could not load your bets !";
                        dojo.removeClass(cntr, 'ajaxLoaderBig');
                    }
                });

            });
        </script>

        <h2>Recent activity</h2>
        <y:activity/>

    </s:layout-component>
</s:layout-render>