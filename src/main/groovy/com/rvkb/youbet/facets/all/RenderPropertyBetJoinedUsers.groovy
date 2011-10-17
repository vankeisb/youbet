package com.rvkb.youbet.facets.all

import com.rvkb.youbet.model.Bet
import net.sourceforge.jfacets.annotations.FacetKey
import net.sourceforge.jfacets.annotations.FacetKeyList
import woko.facets.builtin.all.RenderPropertyValueImpl

@FacetKeyList(
    keys=[
        @FacetKey(name="renderPropertyValue_joinedUsers", profileId="guest", targetObjectType=Bet.class),
        @FacetKey(name="renderPropertyValue_joinedUsers", profileId="user", targetObjectType=Bet.class)
    ]
)
class RenderPropertyBetJoinedUsers extends RenderPropertyValueImpl {

    @Override
    String getPath() {
        '/WEB-INF/jsp/all/renderPropertyBetJoinedUsers.jsp'
    }


}
