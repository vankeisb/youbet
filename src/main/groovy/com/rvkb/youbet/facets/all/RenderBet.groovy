package com.rvkb.youbet.facets.all

import woko.facets.builtin.all.RenderObjectImpl
import net.sourceforge.jfacets.annotations.FacetKey
import net.sourceforge.jfacets.annotations.FacetKeyList
import com.rvkb.youbet.model.Bet
import javax.servlet.http.HttpServletRequest

@FacetKeyList(
keys=[
@FacetKey(name="renderObject",profileId="guest",targetObjectType=Bet.class),
@FacetKey(name="renderObject",profileId="user",targetObjectType=Bet.class)
]
)
class RenderBet extends RenderObjectImpl {

    @Override
    String getFragmentPath(HttpServletRequest request) {
        '/WEB-INF/jsp/all/renderBet.jsp'
    }


}
