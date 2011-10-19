package com.rvkb.youbet.facets.user

import woko.facets.BaseResolutionFacet
import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import org.json.JSONObject
import org.json.JSONArray
import com.rvkb.youbet.model.Choice
import net.sourceforge.stripes.action.StreamingResolution

@FacetKey(name="choicesAndAmounts",profileId="user",targetObjectType=Bet.class)
@Mixin(FacetCategory)
class GetChoicesAndAmounts extends BaseResolutionFacet {

    Resolution getResolution(ActionBeanContext abc) {
        Bet bet = facetContext.targetObject
        def choicesAndAmounts = bet.getChoicesAndAmounts(currentUser)
        JSONObject result = new JSONObject()
        JSONArray items = new JSONArray()
        result.put('items', items)
        choicesAndAmounts.each { row ->
            JSONObject jRow = new JSONObject()
            Choice c = row.choice
            JSONObject jc = new JSONObject()
            jRow.put("choice", jc)
            jc.put('id', c.id)
            jc.put('title', c.title)
            jRow.put('userBet', row.userBet)
            jRow.put('total', row.total)
            jRow.put('userWin', row.userWin)
            items.put(jRow)
        }
        return new StreamingResolution('text/json', result.toString())
    }


}
