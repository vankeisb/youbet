package com.rvkb.youbet.model

import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.OneToMany
import javax.persistence.FetchType
import javax.persistence.CascadeType
import javax.persistence.ManyToOne
import javax.persistence.ManyToMany
import javax.persistence.OrderBy
import org.compass.annotations.Searchable
import org.compass.annotations.SearchableId
import org.compass.annotations.SearchableProperty
import org.compass.annotations.SearchableComponent

@Entity
@Searchable
class Bet {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @SearchableId
    Long id

    @SearchableProperty(boost=2.0f)
    String title

    @SearchableProperty
    String description

    Boolean published = false

    Boolean closed = false

    @ManyToOne(fetch=FetchType.LAZY)
    User createdBy

    @OneToMany(mappedBy='bet', fetch=FetchType.LAZY, cascade=CascadeType.ALL)
    @SearchableComponent
    List<Choice> choices

    @ManyToMany(fetch=FetchType.LAZY)
    Set<User> joinedUsers

    @OneToMany(mappedBy='bet', fetch=FetchType.LAZY, cascade=CascadeType.REMOVE)
    @OrderBy("creationDate DESC")
    List<BetHistoryEntry> history

    Bet addChoice(String label) {
        Choice c = new Choice([title:label, bet:this])
        if (choices==null) {
            choices = []
        }
        choices << c
        this
    }

    def joinUser(User user) {
        if (joinedUsers==null) {
            joinedUsers = []
        }
        joinedUsers << user
    }

    def getChoicesAndAmounts(User u) {
        def result = []
        if (choices) {
            choices.each { choice ->
                def row = [:]
                row.choice = choice
                row.userBet = choice.getUserValue(u)
                row.total = choice.getTotal()
                row.userReport = computeUserReport(choice, u)
                result << row
            }
        }
        return result
    }

    def computeUserWin(Choice choice, User user) {

        println "computing user win for choice $choice.title and user $user.username"

        def choiceValues = choice.userValues
        def totalChoice = 0
        choiceValues.each { u,v ->
            totalChoice += v
        }

        println "choice values : $choiceValues"
        println "total choice : $totalChoice"

        def userAmountGoodChoice = choiceValues[user]
        if (userAmountGoodChoice==null) {
            userAmountGoodChoice = 0
        }

        println "user amount on choice : $userAmountGoodChoice"

        if (totalChoice==0) {
            return null
        }
        def ratio = userAmountGoodChoice / totalChoice

        println "ratio = $ratio"

        // you win what you bet at least !
        def win = userAmountGoodChoice

        // plus the other choices' values, ceiled at what you've bet
        for (Choice c : choices) {
            if (c!=choice) {
                println "handling choice $c"
                // loosing choice
                def uv = c.userValues
                for (User u : uv.keySet()) {
                    def v = uv[u]
                    println "user $u, value $v"
                    def ceiledValue = Math.min(userAmountGoodChoice, v)
                    println "ceiled : $ceiledValue"
                    def valueForUser = ceiledValue * ratio
                    println "value for user : $valueForUser"
                    win += valueForUser
                }
            }
        }

        def rounded = Math.round(win)
        println "user win = $win, rounded = $rounded"
        return rounded
    }

    def computeUserReport(Choice choice, User user) {
        def userWin = computeUserWin(choice, user)
        def allBetValue = 0
        choices.each { c ->
            allBetValue += c.getUserValue(user)
        }
        return [
          win:userWin,
          total:allBetValue
        ]
    }

    Choice getChoice(String title) {
        for (Choice c : choices) {
            if (c.title==title) {
                return c
            }
        }
        return null
    }


    boolean equals(o) {
        if (this.is(o)) return true;
        if (getClass() != o.class) return false;

        Bet bet = (Bet) o;

        if (id != bet.id) return false;

        return true;
    }

    int hashCode() {
        return (id != null ? id.hashCode() : 0);
    }

    public String toString ( ) {
    final StringBuilder sb = new StringBuilder ( ) ;
    sb . append ( "Bet" ) ;
    sb . append ( "{id=" ) . append ( id ) ;
    sb . append ( ", title='" ) . append ( title ) . append ( '\'' ) ;
    sb . append ( '}' ) ;
    return sb . toString ( ) ;
    }

}
