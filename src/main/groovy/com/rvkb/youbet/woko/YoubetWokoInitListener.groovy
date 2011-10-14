package com.rvkb.youbet.woko

import woko.persistence.ObjectStore
import woko.users.UserManager
import woko.hbcompass.HibernateCompassWokoInitListener
import com.rvkb.youbet.model.User
import woko.users.UsernameResolutionStrategy
import woko.auth.builtin.SessionUsernameResolutionStrategy

class YoubetWokoInitListener extends HibernateCompassWokoInitListener {

    private YoubetStore store

    @Override
    protected ObjectStore createObjectStore() {
        List<String> packageNames = getPackageNamesFromConfig(CTX_PARAM_PACKAGE_NAMES);
        store = new YoubetStore(packageNames)
        return store
    }

    @Override
    protected UserManager createUserManager() {
        YoubetUserManager um = new YoubetUserManager(store)
        // init the users here
        def sf = store.getSessionFactory()
        def s = sf.getCurrentSession()
        def tx = s.beginTransaction()

        try {
            User wdevel = store.getUser('wdevel')
            if (wdevel==null) {
                wdevel = new User([
                  username:'wdevel',
                  hashedPassword:um.hashPassword('wdevel'),
                  role:'developer'
                ])
                s.save(wdevel)
                User remi = new User([
                  username:'remi',
                  hashedPassword:um.hashPassword('remi'),
                  role:'user'
                ])
                s.save(remi)
                User alex = new User([
                  username:'alex',
                  hashedPassword:um.hashPassword('alex'),
                  role:'user'
                ])
                s.save(alex)
            }
            tx.commit()
        } catch(Exception e) {
            tx.rollback()
        }
        return um
    }

    @Override
    protected UsernameResolutionStrategy createUsernameResolutionStrategy() {
        new SessionUsernameResolutionStrategy()
    }


}
