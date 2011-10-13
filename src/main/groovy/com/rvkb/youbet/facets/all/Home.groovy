package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.builtin.all.HomeImpl

@FacetKey(name="home", profileId="all")
class Home extends HomeImpl {

    @Override
    String getPath() {
        return '/WEB-INF/jsp/all/home.jsp'
    }


}
