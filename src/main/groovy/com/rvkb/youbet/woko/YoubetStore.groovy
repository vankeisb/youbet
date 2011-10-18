package com.rvkb.youbet.woko

import com.rvkb.youbet.model.User
import org.hibernate.criterion.Restrictions
import woko.hibernate.HibernateStore
import com.rvkb.youbet.model.Bet
import com.rvkb.youbet.model.BetHistoryEntry
import com.rvkb.youbet.model.Answer
import com.rvkb.youbet.model.Choice
import com.rvkb.youbet.model.BetHistoryEntryCreated
import com.rvkb.youbet.model.BetHistoryEntryAnswerAdded
import com.rvkb.youbet.model.BetHistoryEntryUserJoined
import org.hibernate.criterion.Order

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

    Bet createBet(String title, String description, User user, List<String> choices) {
        Bet bet = new Bet([
          title : title,
          description: description,
          createdBy: user
        ])
        choices.each { choice ->
            bet.addChoice(choice)
        }
        save(bet)

        BetHistoryEntry e = new BetHistoryEntryCreated([
          bet: bet,
          user: user
        ])
        save(e)

        return bet
    }

    Answer addAnswer(Choice choice, User user, Integer value) {
        Answer a = new Answer([
            choice: choice,
            user: user,
            amount: value
        ])
        choice.addToAnswers(a)
        user.addToAnswers(a)
        save(a)

        BetHistoryEntry e = new BetHistoryEntryAnswerAdded([
          user: user,
          bet: a.choice.bet,
          answer: a
        ])
        save(e)

        return a
    }

    boolean joinBet(User user, Bet bet) {
        if (bet?.joinedUsers?.contains(user) || bet?.createdBy==user) {
            return false
        }
        bet.joinUser(user)
        if (user.bets==null) {
            user.bets=[]
        }
        user.bets << bet
        save(bet)

        BetHistoryEntry e = new BetHistoryEntryUserJoined([
          bet:bet,
          user: user
        ])
        save(e)
        return true
    }

    List<BetHistoryEntry> getHistory () {
        session.createCriteria(BetHistoryEntry.class).
          addOrder(Order.desc("creationDate")).
          list()
    }

    Collection<Bet> getJoinedBets(String username) {
        User user = getUser(username)
        if (user==null) {
            return []
        }
        return user.joinedBets
    }

}
