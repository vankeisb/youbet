package com.rvkb.youbet.facets.guest

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.builtin.all.RenderLinksImpl
import woko.facets.builtin.all.Link
import com.rvkb.youbet.facets.user.FacetCategory

@FacetKey(name="renderLinks", profileId="guest", targetObjectType=Bet.class)
@Mixin(FacetCategory)
class RenderBetLinksGuest extends RenderLinksImpl {

    Bet getBet() {
        return facetContext.targetObject
    }

    @Override
    List<Link> getLinks() {
        def links = []
        if (bet.published) {
            links << createJoinLink()
        }
        return links
    }

    protected Link createJoinLink() {
        def l = new Link("join/Bet/${bet.id}", "Join this bet")
        l.cssClass = "joinLink"
        return l
    }

    @Override
    String getPath() {
        '/WEB-INF/jsp/all/renderLinks.jsp'
    }

}
