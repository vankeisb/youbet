package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.builtin.developer.ViewImpl
import net.sourceforge.jfacets.annotations.FacetKeyList

@FacetKeyList(
    keys= [
        @FacetKey(name="view", profileId="all", targetObjectType=Bet.class),
        @FacetKey(name="view", profileId="guest", targetObjectType=Bet.class)
    ]
)
class ViewBet extends ViewImpl {

}
