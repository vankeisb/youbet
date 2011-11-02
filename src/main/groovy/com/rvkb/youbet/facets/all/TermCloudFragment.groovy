package com.rvkb.youbet.facets.all

import woko.facets.builtin.hbcompass.TermCloudFragmentFacet
import net.sourceforge.jfacets.annotations.FacetKey
import woko.hbcompass.tagcloud.CompassCloud
import net.sourceforge.jfacets.annotations.FacetKeyList

@FacetKeyList(keys=[
    @FacetKey(name = "termCloudFragment", profileId = "guest", targetObjectType = CompassCloud.class),
    @FacetKey(name = "termCloudFragment", profileId = "user", targetObjectType = CompassCloud.class)
])
class TermCloudFragment extends TermCloudFragmentFacet {
}
