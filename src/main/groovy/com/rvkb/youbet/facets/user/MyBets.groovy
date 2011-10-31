package com.rvkb.youbet.facets.user

import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.BaseResolutionFacet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import org.json.JSONObject
import org.json.JSONArray
import woko.facets.builtin.RenderObjectJson
import net.sourceforge.stripes.action.StreamingResolution

@FacetKey(name="mybets",profileId="user")
@Mixin(FacetCategory)
class MyBets extends BaseResolutionFacet {

    Resolution getResolution(ActionBeanContext abc) {
        def uname = currentUser.username
        def bets = store.getUserBets(uname)
        def joinedBets = store.getJoinedBets(uname)
        def allBets = []
        allBets.addAll(bets)
        allBets.addAll(joinedBets)
        JSONObject jResult = new JSONObject()
        JSONArray jBets = new JSONArray()
        jResult.put("bets", jBets)
        allBets.each { b ->
            RenderObjectJson jsonFacet = (RenderObjectJson)woko.getFacet('renderObjectJson', request, b)
            JSONObject jsonBet = jsonFacet.objectToJson(request)
            jBets.put(jsonBet)
        }
        return new StreamingResolution('text/json', jResult.toString())
    }


}
