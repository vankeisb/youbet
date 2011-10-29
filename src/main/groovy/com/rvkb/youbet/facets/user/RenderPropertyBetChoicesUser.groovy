package com.rvkb.youbet.facets.user

import com.rvkb.youbet.model.Bet
import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.builtin.all.RenderPropertyValueImpl
import com.rvkb.youbet.facets.guest.RenderPropertyBetChoicesGuest

@FacetKey(name="renderPropertyValue_choices", profileId="user", targetObjectType=Bet.class)
@Mixin(FacetCategory)
class RenderPropertyBetChoicesUser extends RenderPropertyBetChoicesGuest {

    @Override
    String getPath() {
        // check if the user has joined the bet
        if (bet.joinedUsers.contains(getCurrentUser()) || checkTargetBetIsOwnedByCurrentUser(bet)) {
            return bet.closed ?
                '/WEB-INF/jsp/user/renderPropertyBetChoicesClosed.jsp' :
                '/WEB-INF/jsp/user/renderPropertyBetChoicesJoined.jsp'
        } else {
            return '/WEB-INF/jsp/guest/renderPropertyBetChoices.jsp'
        }
    }

    def getChoicesAndAmounts() {
        def u = currentUser
        return bet.getChoicesAndAmounts(u)
    }

}
