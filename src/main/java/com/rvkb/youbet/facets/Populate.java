package com.rvkb.youbet.facets;

import com.rvkb.youbet.gae.YouBetUserManager;
import com.rvkb.youbet.gae.YouBetWokoStore;
import com.rvkb.youbet.model.Bet;
import com.rvkb.youbet.model.User;
import net.sourceforge.jfacets.annotations.FacetKey;
import net.sourceforge.stripes.action.ActionBeanContext;
import net.sourceforge.stripes.action.RedirectResolution;
import net.sourceforge.stripes.action.Resolution;
import net.sourceforge.stripes.action.SimpleMessage;
import woko.Woko;
import woko.facets.BaseResolutionFacet;

import java.util.Date;

@FacetKey(name="populate", profileId = "developer")
public class Populate extends BaseResolutionFacet {

    @Override
    public Resolution getResolution(ActionBeanContext actionBeanContext) {
        Woko woko = getFacetContext().getWoko();
        //YouBetUserManager userManager = (YouBetUserManager)woko.getUserManager();
        YouBetWokoStore store = (YouBetWokoStore)woko.getObjectStore();
        User remi = store.getUser("remi");

        Bet bet = new Bet();
        bet.setCreatedOn(new Date());
        bet.setTitle("combien de temps Tommy va-t-il se voir retirer son permis de conduire ?");

        store.save(bet);



        actionBeanContext.getMessages().add(new SimpleMessage("example bet created"));

        return new RedirectResolution("/find");
    }
}
