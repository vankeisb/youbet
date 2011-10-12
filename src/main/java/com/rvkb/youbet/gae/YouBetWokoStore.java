package com.rvkb.youbet.gae;

import com.rvkb.youbet.model.User;
import woko.gae.GaeStore;
import woko.gae.jdo.GaeJdoStore;

import javax.persistence.Query;
import java.util.List;

public class YouBetWokoStore extends GaeJdoStore {

    public YouBetWokoStore(List<String> packageNames) {
        super(packageNames);
    }

    public User getUser(String username) {
        List users = getPm().
                createQuery("select o from User o where o.username = ?1").
                setParameter(1, username).
                getResultList();
        int nbUsers = users.size();
        if (nbUsers==0) {
            return null;
        }
        if (nbUsers>1) {
            throw new IllegalStateException("More than 1 user found for username " + username);
        }
        return (User)users.get(0);
    }

}
