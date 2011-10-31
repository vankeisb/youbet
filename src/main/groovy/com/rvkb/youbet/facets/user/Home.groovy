package com.rvkb.youbet.facets.user

import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.builtin.all.HomeImpl
import com.rvkb.youbet.model.Bet

@FacetKey(name="home", profileId="user")
@Mixin(FacetCategory)
class Home extends HomeImpl {

    @Override
    String getPath() {
        return '/WEB-INF/jsp/user/home.jsp'
    }

    List<Bet> getUserBets() {
        return objectStore.getUserBets(woko.getUsername(request))
    }

    Collection<Bet> getJoinedBets() {
        return objectStore.getJoinedBets(woko.getUsername(request))
    }

    Long getCurrentUserId() {
        return currentUser.id
    }


}
