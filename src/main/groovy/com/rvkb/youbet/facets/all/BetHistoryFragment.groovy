package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.BaseResolutionFacet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import net.sourceforge.stripes.action.ForwardResolution
import com.rvkb.youbet.woko.GroovyRpcResolutionWrapper
import woko.facets.FragmentFacet
import javax.servlet.http.HttpServletRequest

@FacetKey(name="betHistoryFragment",profileId="all",targetObjectType=Bet.class)
class BetHistoryFragment extends BaseResolutionFacet implements FragmentFacet {

    Resolution getResolution(ActionBeanContext abc) {
        def result = new ForwardResolution(getFragmentPath(abc.request))
        return new GroovyRpcResolutionWrapper(result, { result })
    }

    String getFragmentPath(HttpServletRequest request) {
        '/WEB-INF/jsp/all/betHistoryFragment.jsp'
    }


}
