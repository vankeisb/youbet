package com.rvkb.youbet.facets.user

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.builtin.developer.ViewImpl

@FacetKey(name="view", profileId="user", targetObjectType=Bet.class)
class ViewBet extends ViewImpl {
}
