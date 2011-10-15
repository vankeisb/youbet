package com.rvkb.youbet.facets.user

import woko.facets.builtin.developer.SaveImpl
import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import net.sourceforge.stripes.action.ActionBeanContext

@FacetKey(name="save", profileId="user", targetObjectType=Bet.class)
@Mixin(FacetCategory)
class SaveBet extends SaveImpl {

    List<String> choices

    @Override
    protected void doSave(ActionBeanContext abc) {
        Bet bet = facetContext.targetObject
        // update the choices if they've been modified
        def betChoices = []
        def titles = []
        bet?.choices?.each { choice ->
            betChoices << choice
            titles << choice.title
        }
        if (choices != betChoices) {
            // choices have changed, remove the previous ones and recreate the list
            betChoices.each { choice ->
                bet.choices.remove(choice)
                objectStore.delete(choice)
            }
            choices?.each {
                bet.addChoice(it)
            }
        }
        super.doSave(abc)
    }

    @Override
    boolean matchesTargetObject(Object targetObject) {
        // check if bet is already published
        if (targetObject.published) {
            return false
        }
        return checkTargetBetIsOwnedByCurrentUser(targetObject)
    }

}
