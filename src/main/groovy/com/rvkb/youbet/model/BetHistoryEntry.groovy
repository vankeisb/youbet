package com.rvkb.youbet.model

import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.ManyToOne
import javax.persistence.FetchType

@Entity
abstract class BetHistoryEntry {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    Long id

    Date creationDate = new Date()

    @ManyToOne
    Bet bet

    @ManyToOne(fetch=FetchType.LAZY)
    User user

    abstract String getMessage()



}
