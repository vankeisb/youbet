package com.rvkb.youbet.facets.guest

import woko.facets.builtin.auth.LoginRequiredFacet
import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet

@FacetKey(name="join",profileId="guest",targetObjectType=Bet.class)
class JoinBetLoginRequired extends LoginRequiredFacet {
}
