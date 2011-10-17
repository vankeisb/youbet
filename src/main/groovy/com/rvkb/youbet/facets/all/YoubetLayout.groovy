package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKeyList
import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.builtin.all.LayoutAll

@FacetKeyList(keys=[
    @FacetKey(name="layout", profileId="guest"),
    @FacetKey(name="layout", profileId="user")
])
class YoubetLayout extends LayoutAll {

    @Override
    String getLayoutPath() {
        '/WEB-INF/jsp/all/layout.jsp'
    }

    @Override
    String getAppTitle() {
        'YouBet'
    }


}
