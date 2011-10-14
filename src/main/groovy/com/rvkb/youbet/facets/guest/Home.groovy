package com.rvkb.youbet.facets.guest

import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.builtin.all.HomeImpl

@FacetKey(name="home", profileId="guest")
class Home extends HomeImpl {

    @Override
    String getPath() {
        return '/WEB-INF/jsp/guest/home.jsp'
    }


}
