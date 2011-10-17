package com.rvkb.youbet.facets.user

import woko.facets.builtin.all.NavBarAll
import net.sourceforge.jfacets.annotations.FacetKey

@FacetKey(name="navBar",profileId="user")
class NavbarUser extends NavBarAll {

    @Override
    String getPath() {
        '/WEB-INF/jsp/user/navBar.jsp'
    }


}
