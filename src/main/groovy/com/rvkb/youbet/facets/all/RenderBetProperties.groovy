package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.builtin.all.RenderPropertiesImpl
import com.rvkb.youbet.facets.user.FacetCategory

@FacetKey(name="renderProperties", profileId="all", targetObjectType=Bet.class)
@Mixin(FacetCategory)
class RenderBetProperties extends RenderPropertiesImpl  {

    RenderBetProperties() {
        useFlatLayout = true
    }

    @Override
    List<String> getPropertyNames() {
        def props = []
        props << "choices"
        props << "description"
        props << "history"
        return props
    }


}
