package com.rvkb.youbet.woko

import net.sourceforge.stripes.rpc.RpcResolutionWrapper
import net.sourceforge.stripes.action.Resolution

class GroovyRpcResolutionWrapper extends RpcResolutionWrapper {

    private Closure c

    GroovyRpcResolutionWrapper(Resolution originalResolution, Closure c) {
        super(originalResolution)
        this.c = c
    }

    Resolution getRpcResolution() {
        return c.call()
    }


}
