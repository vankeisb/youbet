package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.builtin.developer.ViewImpl
import net.sourceforge.jfacets.annotations.FacetKeyList
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import net.sourceforge.stripes.action.SimpleMessage

@FacetKeyList(
    keys= [
        @FacetKey(name="view", profileId="user", targetObjectType=Bet.class),
        @FacetKey(name="view", profileId="guest", targetObjectType=Bet.class)
    ]
)
class ViewBet extends ViewImpl {
    @Override
    Resolution getResolution(ActionBeanContext abc) {
        Bet bet = facetContext.targetObject
        def m = abc.messages
        if (!bet.published) {
            m << new SimpleMessage("This bet is not published yet.")
        }
        if (bet.closed) {
            m << new SimpleMessage("""This bet is closed. The result of the bet is displayed. You can't modify this bet any more.""")
        }
        super.getResolution(abc)
    }


}
