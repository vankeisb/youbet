package com.rvkb.youbet.model

import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.FetchType
import javax.persistence.OneToMany
import javax.persistence.ManyToMany
import javax.persistence.OrderBy

@Entity
class User {

    @Id
    @GeneratedValue
    Long id

    @OneToMany(mappedBy="createdBy", fetch=FetchType.LAZY)
    List<Bet> bets

    @ManyToMany(mappedBy="joinedUsers", fetch=FetchType.LAZY)
    Set<Bet> joinedBets

    String username

    String hashedPassword

    String role

    @OneToMany(mappedBy="user", fetch=FetchType.LAZY)
    @OrderBy("creationDate ASC")
    List<BetHistoryEntry> betHistory

    @OneToMany(mappedBy="user", fetch=FetchType.LAZY)
    Set<Answer> answers

    void addToAnswers(Answer answer) {
        if (answers==null) {
            answers = []
        }
        answers << answer
    }


    boolean equals(o) {
        if (this.is(o)) return true;
        if (getClass() != o.class) return false;

        User user = (User) o;

        if (id != user.id) return false;

        return true;
    }

    int hashCode() {
        return (id != null ? id.hashCode() : 0);
    }


    public String toString ( ) {
        final StringBuilder sb = new StringBuilder ( ) ;
        sb . append ( "User" ) ;
        sb . append ( "{id=" ) . append ( id ) ;
        sb . append ( ", username='" ) . append ( username ) . append ( '\'' ) ;
        sb . append ( '}' ) ;
        return sb . toString ( ) ;
    }
}
