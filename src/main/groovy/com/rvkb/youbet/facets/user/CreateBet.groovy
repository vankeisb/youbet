package com.rvkb.youbet.facets.user

import net.sourceforge.jfacets.annotations.FacetKey
import woko.facets.BaseResolutionFacet
import net.sourceforge.stripes.action.Resolution
import net.sourceforge.stripes.action.ActionBeanContext
import com.rvkb.youbet.model.Bet
import com.rvkb.youbet.model.User
import net.sourceforge.stripes.action.RedirectResolution
import com.rvkb.youbet.woko.GroovyRpcResolutionWrapper
import net.sourceforge.stripes.action.StreamingResolution
import net.sourceforge.stripes.action.SimpleMessage

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

        return new GroovyRpcResolutionWrapper(
          new RedirectResolution("/view/Bet/${bet.id}"),
          {
              return new StreamingResolution("text/json", "{success:true, betId:${bet.id}}")
          }
        )
    }


}
