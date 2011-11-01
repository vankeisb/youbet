package com.rvkb.youbet.facets.user

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Choice
import woko.facets.BaseResolutionFacet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import com.rvkb.youbet.model.Answer
import net.sourceforge.stripes.validation.Validate
import com.rvkb.youbet.woko.GroovyRpcResolutionWrapper
import net.sourceforge.stripes.action.RedirectResolution
import com.rvkb.youbet.model.User
import com.rvkb.youbet.model.Bet

@FacetKey(name="addValue",profileId="user",targetObjectType=Choice.class)
@Mixin(FacetCategory)
class AddValueToChoice extends BaseResolutionFacet {

    @Validate(minvalue=1.0d)
    Integer value

    Resolution getResolution(ActionBeanContext abc) {
        Choice choice = facetContext.targetObject

        Answer a = store.addAnswer(choice, currentUser, value)
        objectStore.save(a)

        return new GroovyRpcResolutionWrapper(
          new RedirectResolution("/view/Bet/${choice.bet.id}"),
          {
            GetChoicesAndAmounts choicesAndAmounts = (GetChoicesAndAmounts)woko.
              getFacet('choicesAndAmounts', request, choice.bet)
            return choicesAndAmounts.getResolution(abc)
          }
        )
    }

    @Override
    boolean matchesTargetObject(Object targetObject) {
        Choice c = targetObject
        Bet b = c.bet
        // check if bet is published
        if (!b.published) {
            return false
        }
        // or closed...
        if (b.closed) {
            return false
        }
        // check if user has joined the bet or is the bet owner
        User u = currentUser
        if (b.createdBy == u || b?.joinedUsers?.contains(u)) {
            return true
        }
        return false
    }


}
