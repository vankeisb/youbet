package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.builtin.all.RenderTitleImpl

@FacetKey(name="renderTitle",profileId="all",targetObjectType=Bet.class)
class RenderBetTitle extends RenderTitleImpl {

    @Override
    String getTitle() {
        String t = facetContext.targetObject.title
        if (t==null) {
            return null
        }
        t = t.trim()
        if (t.endsWith("?")) {
            return t
        }
        return "$t ?"
    }


}
