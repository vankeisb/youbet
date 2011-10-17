package com.rvkb.youbet.facets.user

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.BaseResolutionFacet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import net.sourceforge.stripes.action.RedirectResolution
import com.rvkb.youbet.model.User
import net.sourceforge.stripes.action.SimpleMessage

@FacetKey(name="join",profileId="user",targetObjectType=Bet.class)
@Mixin(FacetCategory)
class JoinBet extends BaseResolutionFacet {

    Resolution getResolution(ActionBeanContext abc) {
        Bet bet = facetContext.targetObject
        User user = currentUser
        if (store.joinBet(user, bet)) {
            abc.messages.add(new SimpleMessage("You have joined the bet."))
        } else {
            abc.messages.add(new SimpleMessage("You have already joined this bet."))
        }
        return new RedirectResolution("/view/Bet/${bet.id}")
    }


}
