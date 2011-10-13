package com.rvkb.youbet.facets.user

import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.BaseResolutionFacet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import com.rvkb.youbet.model.Bet
import com.rvkb.youbet.model.User
import org.codehaus.groovy.control.messages.SimpleMessage
import net.sourceforge.stripes.action.RedirectResolution

@FacetKey(name="createBet", profileId="user")
class CreateBet extends BaseResolutionFacet {

    String title
    List<String> choices
    String description

    Resolution getResolution(ActionBeanContext actionBeanContext) {
        String username = woko.getUsername(request)
        User user = objectStore.getUser(username)
        Bet bet = new Bet([
          title : title,
          description: description,
          createdBy: user
        ])
        choices.each { choice ->
            bet.addChoice(choice)
        }
        objectStore.save(bet);

        actionBeanContext.messages.add(new SimpleMessage("Bet created. You can now invite people."))
        new RedirectResolution("/view/Bet/${bet.id}");
    }


}
