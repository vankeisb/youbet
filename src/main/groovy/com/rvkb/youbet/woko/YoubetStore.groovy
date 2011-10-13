package com.rvkb.youbet.woko

import com.rvkb.youbet.model.User
import org.hibernate.criterion.Restrictions
import woko.hibernate.HibernateStore
import com.rvkb.youbet.model.Bet

class YoubetStore extends HibernateStore {

    YoubetStore(List<String> packageNames) {
        super(packageNames)
    }

    User getUser(String username) {
        (User)session.createCriteria(User.class).
          add(Restrictions.eq("username", username)).
          uniqueResult()
    }

    List<Bet> getUserBets(String username) {
        User u = getUser(username)
        (List<Bet>)session.createCriteria(Bet.class).
          add(Restrictions.eq("createdBy", u)).
          list()
    }
}
