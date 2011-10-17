package com.rvkb.youbet.model

import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.ManyToOne
import javax.persistence.OneToMany

@Entity
class Choice {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    Long id

    String title

    @ManyToOne
    Bet bet

    @OneToMany(mappedBy="choice")
    Set<Answer> answers


}
