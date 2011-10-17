package com.rvkb.youbet.facets.guest

import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.builtin.all.NavBarAll

@FacetKey(name="navBar",profileId="guest")
class NavbarGuest extends NavBarAll {

    @Override
    String getPath() {
        '/WEB-INF/jsp/guest/navBar.jsp'
    }


}
