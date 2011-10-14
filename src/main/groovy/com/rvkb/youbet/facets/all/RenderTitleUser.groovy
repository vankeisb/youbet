package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.User
import woko.facets.builtin.all.RenderTitleImpl

@FacetKey(name="renderTitle", profileId="all", targetObjectType=User.class)
class RenderTitleUser extends RenderTitleImpl {

    @Override
    String getTitle() {
        facetContext.targetObject.username
    }


}
