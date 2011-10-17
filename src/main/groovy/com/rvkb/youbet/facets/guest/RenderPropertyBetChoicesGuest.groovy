package com.rvkb.youbet.facets.guest

import com.rvkb.youbet.model.Bet
import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.builtin.all.RenderPropertyValueImpl
import net.sourceforge.jfacets.annotations.FacetKeyList

@FacetKey(name="renderPropertyValue_choices", profileId="guest", targetObjectType=Bet.class)
class RenderPropertyBetChoicesGuest extends RenderPropertyValueImpl {

    Bet getBet() {
        return owningObject
    }

    @Override
    String getPath() {
        '/WEB-INF/jsp/guest/renderPropertyBetChoices.jsp'
    }


}
