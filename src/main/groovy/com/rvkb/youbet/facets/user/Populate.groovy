package com.rvkb.youbet.facets.user

import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.BaseResolutionFacet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import com.rvkb.youbet.model.Bet
import net.sourceforge.stripes.action.RedirectResolution
import com.rvkb.youbet.woko.YoubetStore
import woko.Woko

@FacetKey(name="populate", profileId="user")
class Populate extends BaseResolutionFacet {

    Resolution getResolution(ActionBeanContext actionBeanContext) {
        Woko w = facetContext.woko
        String username = w.getUsername(actionBeanContext.request)
        YoubetStore s = facetContext.woko.objectStore
        def user = s.getUser(username)
        Bet bet = new Bet([
          title:'combien de temps Tommy va-t-il se faire niquer au permis',
            createdBy: user
        ])
        bet.addChoice('1 mois').
            addChoice('6 mois').
            addChoice('1 an').
            addChoice('2 ans')
        s.save(bet)
        return new RedirectResolution("/view/Bet/${bet.id}")
    }


}
