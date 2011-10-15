package com.rvkb.youbet.model

import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.FetchType
import javax.persistence.OneToMany
import javax.persistence.ManyToMany

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
    Set<Answer> answers

}
