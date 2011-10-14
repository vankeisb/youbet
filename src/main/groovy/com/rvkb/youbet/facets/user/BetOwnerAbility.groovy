package com.rvkb.youbet.facets.user

import woko.facets.BaseFacet

@Category(BaseFacet)
class BetOwnerAbility {

    def checkTargetBetIsOwnedByCurrentUser(bet) {
        def uname = woko.getUsername(facetContext.request)
        def betOwner = bet?.createdBy?.username
        if (betOwner) {
            return uname == betOwner
        }
        return true // bet is probably transient
    }

}
