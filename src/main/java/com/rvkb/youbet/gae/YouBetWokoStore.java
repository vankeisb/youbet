package com.rvkb.youbet.gae;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.rvkb.youbet.model.User;
import woko.gae.jdo.GaeJdoStore;

import javax.jdo.Query;
import java.util.List;

public class YouBetWokoStore extends GaeJdoStore {

    public YouBetWokoStore(List<String> packageNames) {
        super(packageNames);
    }

    public User getUser(String username) {
        Query q = getPm().newQuery(User.class);
        q.setFilter("username == pUsername");
        q.declareParameters("java.lang.String pUsername");
        List<User> users = (List<User>)q.execute(username);
        int nbUsers = users.size();
        if (nbUsers==0) {
            return null;
        }
        if (nbUsers>1) {
            throw new IllegalStateException("More than 1 user found for username " + username);
        }
        return (User)users.get(0);
    }

    @Override
    protected Object convertKey(Class<?> clazz, String key) {
        if (Key.class.isAssignableFrom(clazz)) {
            return KeyFactory.createKey(clazz.getName(), key);
        }
        return super.convertKey(clazz, key);    //To change body of overridden methods use File | Settings | File Templates.
    }
}
