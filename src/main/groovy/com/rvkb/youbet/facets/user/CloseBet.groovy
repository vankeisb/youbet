package com.rvkb.youbet.facets.user

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.BaseResolutionFacet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import net.sourceforge.stripes.action.ForwardResolution
import com.rvkb.youbet.model.Choice
import net.sourceforge.stripes.action.RedirectResolution
import net.sourceforge.stripes.action.SimpleMessage
import com.rvkb.youbet.model.BetHistoryEntryClosed
import com.rvkb.youbet.model.BetHistoryEntry

@FacetKey(name="close", profileId="user", targetObjectType=Bet.class)
@Mixin(FacetCategory)
class CloseBet extends BaseResolutionFacet {

    Choice choice

    Resolution getResolution(ActionBeanContext abc) {
        if (choice==null) {
            abc.messages.add(new SimpleMessage("You cannot re-open a closed bet, so be careful when you close it."))
            return new ForwardResolution('/WEB-INF/jsp/user/closeBet.jsp')
        } else {
            // choice specified, close the bet !
            store.closeBet(choice)
            abc.messages.add(new SimpleMessage("Bet closed."))
            return new RedirectResolution("/view/Bet/${facetContext.targetObject.id}")
        }
    }

    @Override
    boolean matchesTargetObject(Object targetObject) {
        Bet bet = targetObject
        // check if bet is already published
        return bet.closable && checkTargetBetIsOwnedByCurrentUser(bet)
    }

}
