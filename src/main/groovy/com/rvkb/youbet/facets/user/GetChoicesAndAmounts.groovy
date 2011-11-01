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
        if (bet.closed) {
            result.put("closed", true)
        }
        choicesAndAmounts.each { row ->
            JSONObject jRow = new JSONObject()
            Choice c = row.choice
            JSONObject jc = new JSONObject()
            jRow.put("choice", jc)
            jc.put('id', c.id)
            jc.put('title', c.title)
            jRow.put('userBet', row.userBet)
            jRow.put('total', row.total)
            if (row.userReport!=null) {
                JSONObject userReport = new JSONObject()
                jRow.put('userReport', userReport)
                userReport.put('win', row.userReport.win)
                userReport.put('total', row.userReport.total)
            }
            items.put(jRow)
        }
        return new StreamingResolution('text/json', result.toString())
    }


}
