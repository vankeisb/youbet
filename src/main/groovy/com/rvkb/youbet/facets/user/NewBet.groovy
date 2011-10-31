package com.rvkb.youbet.facets.user

import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.BaseForwardResolutionFacet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import net.sourceforge.stripes.action.SimpleMessage

@FacetKey(name="newbet", profileId="user")
class NewBet extends BaseForwardResolutionFacet {

    @Override
    Resolution getResolution(ActionBeanContext abc) {
        abc.messages << new SimpleMessage("""You are creating a new bet. Please fill in the details, and save.""")
        return super.getResolution(abc)
    }

    @Override
    String getPath() {
        return '/WEB-INF/jsp/user/editbet.jsp'
    }


}
