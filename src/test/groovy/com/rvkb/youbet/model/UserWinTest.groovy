package com.rvkb.youbet.model

import junit.framework.TestCase

class UserWinTest extends TestCase {

    def createBet(amountRemiA, amountRemiB, amountAlexA, amountAlexB) {
        User remi = new User([
          id:1,
          username:"remi"
        ])
        User alex = new User([
          id:2,
          username:"alex"
        ])
        Bet bet = new Bet([
          id:1,
          createdBy:remi,
        ])
        bet.joinedUsers = [alex]
        alex.joinedBets = [bet]
        bet.addChoice("a").addChoice("b")
        Choice ca = bet.getChoice("a")
        ca.id = 1
        ca.addToAnswers(
          new Answer([
            id:1,
            user: remi,
            amount: amountRemiA
          ])
        )
        ca.addToAnswers(
          new Answer([
            id:2,
            user: alex,
            amount: amountAlexA
          ])
        )
        Choice cb = bet.getChoice("b")
        cb.id = 2
        cb.addToAnswers(
          new Answer([
            id:3,
            user: alex,
            amount: amountAlexB
          ])
        )
        cb.addToAnswers(
          new Answer([
            id:4,
            user: remi,
            amount: amountRemiB
          ])
        )

        return [
          remi:remi,
          alex:alex,
          bet:bet,
          ca:ca,
          cb:cb
        ]
    }

    void testUserWinSameAmount() {
        def b = createBet(100, 0, 0, 100)

        assert 200 == b.bet.computeUserWin(b.ca, b.remi)
        assert 0 == b.bet.computeUserWin(b.cb, b.remi)

        assert 0 == b.bet.computeUserWin(b.ca, b.alex)
        assert 200 == b.bet.computeUserWin(b.cb, b.alex)
    }

    void testUserWin100v50() {
        def b = createBet(100, 0, 0, 50)

        assert 150 == b.bet.computeUserWin(b.ca, b.remi)
        assert 0 == b.bet.computeUserWin(b.cb, b.remi)

        assert 0 == b.bet.computeUserWin(b.ca, b.alex)
        assert 100 == b.bet.computeUserWin(b.cb, b.alex)
    }

    void testUserWin10v100() {
        def b = createBet(10, 0, 0, 100)

        assert 20 == b.bet.computeUserWin(b.ca, b.remi)
        assert 0 == b.bet.computeUserWin(b.cb, b.remi)

        assert 0 == b.bet.computeUserWin(b.ca, b.alex)
        assert 110 == b.bet.computeUserWin(b.cb, b.alex)
    }

    void testUserWinCrossed() {
        def b = createBet(10, 1, 1, 10)

        assert 20 == b.bet.computeUserWin(b.ca, b.remi)
        assert 1 == b.bet.computeUserWin(b.cb, b.remi)

        assert 1 == b.bet.computeUserWin(b.ca, b.alex)
        assert 20 == b.bet.computeUserWin(b.cb, b.alex)
    }

    void testUserWinNoWin() {
        def b = createBet(10, 0, 10, 0)

        assert 10 == b.bet.computeUserWin(b.ca, b.remi)
        assert null == b.bet.computeUserWin(b.cb, b.remi)

        assert 10 == b.bet.computeUserWin(b.ca, b.alex)
        assert null == b.bet.computeUserWin(b.cb, b.alex)
    }



}
