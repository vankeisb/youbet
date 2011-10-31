package com.rvkb.youbet.facets.user

import woko.facets.builtin.developer.EditImpl
import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import net.sourceforge.stripes.action.SimpleMessage

@FacetKey(name="edit", profileId="user", targetObjectType=Bet.class)
@Mixin(FacetCategory)
class EditBet extends EditImpl {

    @Override
    Resolution getResolution(ActionBeanContext abc) {
        Bet bet = facetContext.targetObject
        if (!bet.published) {
            abc.messages << new SimpleMessage("""Editing the bet. You can save as many times as you want. Then, once your bet
                                    is ok, you can publish it so that others can join it, and bet on it.
                                    <br/>
                                    <br/>
                                    <b>IMPORTANT</b> : you won't be able to change your bet once it's published. Make
                                    sure everything is ok before you publish.""")
        } else {
            if (bet.closable) {
                abc.messages << new SimpleMessage("""You can close this bet whenever you want. Make sure
                                        everyone's ok with it !""")
            } else {
                abc.messages << new SimpleMessage("""This bet has been published, but nobody has yet answered any choice.
                                        You will be able to close it as soon as at least two people have answered.""")
            }
        }
        return super.getResolution(abc)
    }

    @Override
    String getFragmentPath() {
        return '/WEB-INF/jsp/user/editbet.jsp'
    }

    @Override
    boolean matchesTargetObject(Object targetObject) {
        return checkTargetBetIsOwnedByCurrentUser(targetObject)
    }


}
