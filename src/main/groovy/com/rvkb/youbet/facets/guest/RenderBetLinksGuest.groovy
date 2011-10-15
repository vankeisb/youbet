package com.rvkb.youbet.facets.guest

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.builtin.all.RenderLinksImpl
import woko.facets.builtin.all.Link

@FacetKey(name="renderLinks", profileId="guest", targetObjectType=Bet.class)
class RenderBetLinksGuest extends RenderLinksImpl {

    @Override
    List<Link> getLinks() {
        def links = []
        links << createJoinLink()
        return links
    }

    protected Link createJoinLink() {
        def l = new Link("/join/Bet/${facetContext.targetObject.id}", "Join this bet")
        l.cssClass = "joinLink"
        return l
    }


}
