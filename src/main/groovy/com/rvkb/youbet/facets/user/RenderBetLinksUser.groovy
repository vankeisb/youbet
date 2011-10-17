package com.rvkb.youbet.facets.user

import com.rvkb.youbet.model.Bet
import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.builtin.all.Link
import com.rvkb.youbet.facets.guest.RenderBetLinksGuest
import com.rvkb.youbet.model.User

@FacetKey(name="renderLinks", profileId="user", targetObjectType=Bet.class)
@Mixin(FacetCategory)
class RenderBetLinksUser extends RenderBetLinksGuest {

    @Override
    List<Link> getLinks() {
        def links = []
        Bet bet = facetContext.targetObject
        if (checkTargetBetIsOwnedByCurrentUser(bet)) {
            def linkText = "Edit"
            if (bet.published) {
                linkText = "Close"
            }
            // user is owner, allow edit
            def link = new Link("edit/Bet/${bet.id}", linkText)
            link.cssClass = "edit"
            links << link
        } else {
            // user is not owner, show "join" link if not joined yet
            User user = getCurrentUser()
            if (!(user?.joinedBets?.contains(bet)) && bet.published) {
                links << createJoinLink()
            }
        }
        return links
    }


}
