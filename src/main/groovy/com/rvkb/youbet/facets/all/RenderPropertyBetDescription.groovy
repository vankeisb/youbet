package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.builtin.all.RenderPropertyValueImpl
import net.sourceforge.jfacets.annotations.FacetKeyList

@FacetKeyList(
    keys=[
        @FacetKey(name="renderPropertyValue_description", profileId="guest", targetObjectType=Bet.class),
        @FacetKey(name="renderPropertyValue_description", profileId="user", targetObjectType=Bet.class)
    ]
)
class RenderPropertyBetDescription extends RenderPropertyValueImpl {

    @Override
    String getPath() {
        '/WEB-INF/jsp/all/renderPropertyBetDescription.jsp'
    }


}
