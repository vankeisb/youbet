package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKey
import com.rvkb.youbet.model.Bet
import woko.facets.BaseResolutionFacet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import net.sourceforge.stripes.action.ForwardResolution
import com.rvkb.youbet.woko.GroovyRpcResolutionWrapper

@FacetKey(name="betHistoryFragment",profileId="all",targetObjectType=Bet.class)
class BetHistoryFragment extends BaseResolutionFacet {

    Resolution getResolution(ActionBeanContext abc) {
        def result = new ForwardResolution('/WEB-INF/jsp/all/betHistoryFragment.jsp')
        return new GroovyRpcResolutionWrapper(result, { result })
    }

}
