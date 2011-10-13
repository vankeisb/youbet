package com.rvkb.youbet.facets.user

import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.BaseForwardResolutionFacet

@FacetKey(name="newbet", profileId="user")
class NewBet extends BaseForwardResolutionFacet {

    @Override
    String getPath() {
        return '/WEB-INF/jsp/user/newbet.jsp'
    }


}
