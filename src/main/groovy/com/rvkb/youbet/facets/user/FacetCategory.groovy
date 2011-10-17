package com.rvkb.youbet.facets.user

import woko.facets.BaseFacet
import com.rvkb.youbet.model.User
import com.rvkb.youbet.woko.YoubetStore

@Category(BaseFacet)
class FacetCategory {

    User getCurrentUser() {
        def uname = woko.getUsername(facetContext.request)
        if (uname==null) {
            return null
        } else {
            return woko.objectStore.getUser(uname)
        }
    }

    def checkTargetBetIsOwnedByCurrentUser(bet) {
        def uname = woko.getUsername(facetContext.request)
        def betOwner = bet?.createdBy?.username
        if (betOwner) {
            return uname == betOwner
        }
        return true // bet is probably transient
    }

    YoubetStore getStore() {
        return objectStore
    }

}
