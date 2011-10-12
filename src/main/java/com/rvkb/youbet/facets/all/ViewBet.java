package com.rvkb.youbet.facets.all;

import com.rvkb.youbet.model.Bet;
import net.sourceforge.jfacets.annotations.FacetKey;
import woko.facets.builtin.developer.ViewImpl;

@FacetKey(name="view", profileId = "all", targetObjectType = Bet.class)
public class ViewBet extends ViewImpl {
}
