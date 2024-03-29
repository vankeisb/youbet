package com.rvkb.youbet.model

import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.ManyToOne
import javax.persistence.FetchType

@Entity
class Answer {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    Long id

    @ManyToOne(fetch=FetchType.LAZY)
    Choice choice

    @ManyToOne(fetch=FetchType.LAZY)
    User user

    Integer amount

    Date createdOn = new Date()

    boolean equals(o) {
        if (this.is(o))
            return true
        if (getClass() != o.class)
            return false

         return id == o.id
    }

    int hashCode() {
        return (id != null ? id.hashCode() : 0);
    }
}
