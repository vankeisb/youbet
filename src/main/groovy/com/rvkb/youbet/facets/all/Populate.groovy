package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.BaseResolutionFacet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import com.rvkb.youbet.model.Bet
import net.sourceforge.stripes.action.RedirectResolution
import com.rvkb.youbet.woko.YoubetStore
import woko.Woko

@FacetKey(name="populate", profileId="all")
class Populate extends BaseResolutionFacet {

    Resolution getResolution(ActionBeanContext actionBeanContext) {
        YoubetStore s = facetContext.woko.objectStore
        def user = s.getUser("remi")

        Bet bet = s.createBet('combien de temps Tommy va-t-il se faire niquer au permis',
          "this is a <b>test</b><br/>description<ul><li>a</li><li>b</li></ul>",
            user,
          ['1 mois','6 mois','1 an','2 ans']
        );

        bet.published = true
        s.save(bet)

        def alex = s.getUser("alex")
        s.joinBet(alex, bet)

        return new RedirectResolution("/view/Bet/${bet.id}")
    }


}
