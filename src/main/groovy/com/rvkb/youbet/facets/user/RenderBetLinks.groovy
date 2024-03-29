package com.rvkb.youbet.facets.user

import com.rvkb.youbet.model.Bet
import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.builtin.all.Link
import com.rvkb.youbet.facets.guest.RenderBetLinksGuest
import com.rvkb.youbet.model.User
import com.rvkb.youbet.facets.user.FacetCategory
import net.sourceforge.jfacets.annotations.FacetKeyList

@FacetKey(name="renderLinks", profileId="user", targetObjectType=Bet.class)
@Mixin(FacetCategory)
class RenderBetLinks extends RenderBetLinksGuest {

    @Override
    List<Link> getLinks() {
        def links = []
        Bet bet = facetContext.targetObject
        if (checkTargetBetIsOwnedByCurrentUser(bet) && !bet.closed) {
            def linkText = "Edit"
            if (bet.published && bet.closable) {
                linkText = "Close the bet"
            }
            // user is owner, allow edit
            def link = new Link("edit/Bet/${bet.id}", linkText)
            link.cssClass = "edit"
            links << link
        } else {
            // user is not owner, show "join" link if not joined yet
            User user = getCurrentUser()
            if (!(user?.joinedBets?.contains(bet)) && bet.published && !bet.closed) {
                links << createJoinLink()
            }
        }
        return links
    }

}
