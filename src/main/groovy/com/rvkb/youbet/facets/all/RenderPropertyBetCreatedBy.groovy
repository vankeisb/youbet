package com.rvkb.youbet.facets.all

import com.rvkb.youbet.model.Bet
import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.builtin.all.RenderPropertyValueImpl
import net.sourceforge.jfacets.annotations.FacetKeyList

@FacetKeyList(
    keys=[
        @FacetKey(name="renderPropertyValue_createdBy", profileId="guest", targetObjectType=Bet.class),
        @FacetKey(name="renderPropertyValue_createdBy", profileId="user", targetObjectType=Bet.class)
    ]
)
class RenderPropertyBetCreatedBy extends RenderPropertyValueImpl {

    @Override
    String getPath() {
        '/WEB-INF/jsp/all/renderPropertyBetCreatedBy.jsp'
    }


}
