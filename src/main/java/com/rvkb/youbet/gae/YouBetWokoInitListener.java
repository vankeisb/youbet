package com.rvkb.youbet.gae;

import java.util.List;

import com.rvkb.youbet.model.Bet;
import com.rvkb.youbet.model.User;
import woko.gae.jdo.GaeJdoWokoInitListener;
import woko.gae.jdo.GaePersistenceManagerInterceptor;
import woko.persistence.ObjectStore;
import woko.users.UserManager;
import woko.users.UsernameResolutionStrategy;
import woko.auth.builtin.SessionUsernameResolutionStrategy;

import javax.jdo.PersistenceManager;

public class YouBetWokoInitListener extends GaeJdoWokoInitListener {

    private YouBetUserManager userManager;
    private YouBetWokoStore store;

    @Override
    protected ObjectStore createObjectStore() {
        List<String> packageNames = getPackageNamesFromConfig(CTX_PARAM_PACKAGE_NAMES);
        store = new YouBetWokoStore(packageNames);
        return store;
    }

    protected UserManager createUserManager() {
        YouBetUserManager um = new YouBetUserManager(store);
        // TODO remove this :
        // create default users
        PersistenceManager pm = GaePersistenceManagerInterceptor.PMF.getPersistenceManager();
        GaePersistenceManagerInterceptor.setPersistenceManagerForCurrentThread(pm);
        try {
            User wdevel = store.getUser("wdevel");
            if (wdevel == null) {
                wdevel = new User();
                wdevel.setUsername("wdevel");
                wdevel.setHashedPassword(um.hashPassword("wdevel"));
                wdevel.setEmail("wdevel@rvkb.com");
                store.save(wdevel);
            }
            User user = store.getUser("remi");
            if (user == null) {
                user = new User();
                user.setUsername("remi");
                user.setHashedPassword(um.hashPassword("remi"));
                user.setEmail("remi@rvkb.com");
                store.save(user);
            }
            return um;
        } finally {
            pm.close();
            GaePersistenceManagerInterceptor.clearPersistenceManagerForCurrentThread();
        }
    }

    @Override
    protected UsernameResolutionStrategy createUsernameResolutionStrategy() {
        return new SessionUsernameResolutionStrategy();
    }
}
