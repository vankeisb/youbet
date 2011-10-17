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
            return '/WEB-INF/jsp/user/renderPropertyBetChoicesJoined.jsp'
        } else {
            return '/WEB-INF/jsp/guest/renderPropertyBetChoices.jsp'
        }
    }

    def getChoicesAndAmounts() {
        def u = currentUser
        def result = []
        bet.choices.each { choice ->
            def row = [:]
            row.choice = choice
            row.userBet = choice.getUserValue(u)
            row.total = choice.getTotal()
            result << row
        }
        return result
    }

}
