package com.rvkb.youbet.facets.all

import net.sourceforge.jfacets.annotations.FacetKey
import net.sourceforge.jfacets.annotations.FacetKeyList
import woko.facets.builtin.developer.SearchImpl
import woko.persistence.ResultIterator
import net.sourceforge.stripes.action.ActionBeanContext
import woko.persistence.ListResultIterator

@FacetKeyList(keys = [
@FacetKey(name = "search", profileId = "guest"),
@FacetKey(name = "search", profileId = "user")
])
class YoubetSearch extends SearchImpl {

    @Override
    protected ResultIterator createResultIterator(ActionBeanContext abc, int start, int limit) {
        if (query == null) {
            return new ListResultIterator(Collections.emptyList(), start, limit, 0);
        } else {
            return getFacetContext().getWoko().getObjectStore().search(query, start, limit);
        }
    }

}
