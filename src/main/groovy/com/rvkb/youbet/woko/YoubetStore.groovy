package com.rvkb.youbet.woko

import com.rvkb.youbet.model.User
import org.hibernate.criterion.Restrictions
import com.rvkb.youbet.model.Bet
import com.rvkb.youbet.model.BetHistoryEntry
import com.rvkb.youbet.model.Answer
import com.rvkb.youbet.model.Choice
import com.rvkb.youbet.model.BetHistoryEntryCreated
import com.rvkb.youbet.model.BetHistoryEntryAnswerAdded
import com.rvkb.youbet.model.BetHistoryEntryUserJoined
import org.hibernate.criterion.Order
import woko.hbcompass.HibernateCompassStore
import woko.persistence.ResultIterator
import org.compass.core.Compass
import org.compass.core.CompassTemplate
import woko.hbcompass.CompassResultIterator
import org.compass.core.CompassCallback
import org.compass.core.CompassSession
import org.compass.core.CompassException
import org.compass.core.CompassHits
import org.compass.core.CompassHitsOperations
import org.compass.core.CompassQueryBuilder
import woko.util.WLogger

class YoubetStore extends HibernateCompassStore {

    private static final WLogger logger = WLogger.getLogger(YoubetStore.class)

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
        save(bet)
        if (user.bets==null) {
            user.bets=[]
        }
        user.bets << bet
        save(user)

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

    @Override
    ResultIterator search(Object query, Integer start, Integer limit) {
        if (!(query instanceof String)) {
            throw new IllegalStateException("query ain't a String !")
        }
        final int iStart = start==null ? 0 : start;
        final int iLimit = limit==null ? -1 : limit;

        Compass compass = getCompass();
        logger.debug("Querying in template (using compass " + compass + ")");
        return new CompassTemplate(compass).execute(new CompassCallback<CompassResultIterator>() {
          @Override
          public CompassResultIterator doInCompass(CompassSession session) throws CompassException {
              CompassQueryBuilder qb = session.queryBuilder();
              CompassHits hits = qb.bool().
                addMust(qb.alias("Bet")).
                addMust(qb.queryString(query).toQuery()).
                toQuery().
                hits();

            int len = hits.length();
            logger.debug("Query executed, returned " + len + " hit(s)");
            int size = iLimit == -1 ? len - iStart : iLimit;
            CompassHitsOperations hitsOps = hits.detach(iStart, size);
            logger.debug("Hits detached, commiting and returning result iterator");
            return new CompassResultIterator(hitsOps, iStart, iLimit, len);
          }
        });
    }

}
