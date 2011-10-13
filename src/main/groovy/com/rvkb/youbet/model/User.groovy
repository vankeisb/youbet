package com.rvkb.youbet.model

import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.FetchType
import javax.persistence.OneToMany

@Entity
class User {

    @Id
    @GeneratedValue
    Long id

    @OneToMany(mappedBy="createdBy", fetch=FetchType.LAZY)
    List<Bet> bets

    String username

    String hashedPassword

    String role

}
