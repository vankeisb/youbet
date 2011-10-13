package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.builtin.auth.LoginRequiredFacet

@FacetKey(name="newbet", profileId="all")
class NewBet extends LoginRequiredFacet {
}
