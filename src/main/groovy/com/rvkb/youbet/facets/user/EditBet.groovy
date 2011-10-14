package com.rvkb.youbet.facets.user

import woko.facets.builtin.developer.EditImpl
import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet

@FacetKey(name="edit", profileId="user", targetObjectType=Bet.class)
@Mixin(BetOwnerAbility)
class EditBet extends EditImpl {

    @Override
    String getFragmentPath() {
        return '/WEB-INF/jsp/user/editbet.jsp'
    }

    @Override
    boolean matchesTargetObject(Object targetObject) {
        return checkTargetBetIsOwnedByCurrentUser(targetObject)
    }


}
