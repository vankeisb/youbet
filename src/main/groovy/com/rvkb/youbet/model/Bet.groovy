package com.rvkb.youbet.model

import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.OneToMany
import javax.persistence.FetchType
import javax.persistence.CascadeType
import javax.persistence.ManyToOne

@Entity
class Bet {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    Long id

    String title

    String description

    @ManyToOne(fetch=FetchType.LAZY)
    User createdBy

    @OneToMany(mappedBy='bet', fetch=FetchType.LAZY, cascade=CascadeType.ALL)
    List<Choice> choices

    Bet addChoice(String label) {
        Choice c = new Choice([title:label, bet:this])
        if (choices==null) {
            choices = []
        }
        choices << c
        this
    }

}
