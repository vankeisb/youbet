package com.rvkb.youbet.facets.user

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.BaseResolutionFacet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import net.sourceforge.stripes.action.RedirectResolution
import net.sourceforge.stripes.action.SimpleMessage
import net.sourceforge.stripes.action.StreamingResolution
import com.rvkb.youbet.woko.GroovyRpcResolutionWrapper

@FacetKey(name="publish", profileId="user", targetObjectType=Bet.class)
@Mixin(BetOwnerAbility)
class PublishBet extends BaseResolutionFacet {

    Resolution getResolution(ActionBeanContext abc) {
        def bet = facetContext.targetObject
        bet.published = true
        objectStore.save(bet)
        abc.messages.add(new SimpleMessage("bet published"))
        return new GroovyRpcResolutionWrapper(
          new RedirectResolution("/edit/Bet/${bet.id}"),
          {
              return new StreamingResolution("text/json", "{success:true, betId:${bet.id}}")
          }
        )
    }

    @Override
    boolean matchesTargetObject(Object targetObject) {
        return checkTargetBetIsOwnedByCurrentUser(targetObject)
    }

}
