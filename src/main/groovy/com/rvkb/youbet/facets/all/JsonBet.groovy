package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.builtin.developer.JsonImpl

@FacetKey(name="json", profileId="all", targetObjectType=Bet.class)
class JsonBet extends JsonImpl {
}
