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

@FacetKey(name="addValue",profileId="user",targetObjectType=Choice.class)
@Mixin(FacetCategory)
class AddValueToChoice extends BaseResolutionFacet {

    @Validate(minvalue=1.0d)
    Integer value

    Resolution getResolution(ActionBeanContext abc) {
        Choice choice = facetContext.targetObject
        Answer a = new Answer([
            choice: choice,
            user: currentUser,
            amount: value
        ])
        choice.addToAnswers(a)
        currentUser.addToAnswers(a)
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


}
