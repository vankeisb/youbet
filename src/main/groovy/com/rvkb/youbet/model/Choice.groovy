package com.rvkb.youbet.model

import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import org.compass.annotations.Searchable
import org.compass.annotations.SearchableId
import org.compass.annotations.SearchableProperty
import org.compass.annotations.SearchableParent
import org.hibernate.engine.Cascade
import javax.persistence.CascadeType
import javax.persistence.FetchType

@Entity
@Searchable
class Choice {

    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @SearchableId
    Long id

    @SearchableProperty
    String title

    @ManyToOne
    Bet bet

    @OneToMany(mappedBy="choice", cascade=CascadeType.ALL, fetch=FetchType.LAZY)
    Set<Answer> answers

    Boolean goodChoice

    Integer getTotal() {
        def total = 0
        if (answers) {
            answers.each { answer ->
                total += answer.amount
            }
        }
        return total
    }

    Integer getUserValue(User user) {
        def v = 0
        for (Answer a : answers) {
            if (a.user == user) {
                v += a.amount
            }
        }
        return v
    }

    def getUserValues() {
        def res = [:]
        for (Answer a : answers) {
            def u = a.user
            def uv = res[u]
            if (uv==null) {
                uv = 0
            }
            res[u] = uv + a.amount
        }
        return res
    }

    void addToAnswers(Answer answer) {
        if (answers==null) {
            answers = []
        }
        answers << answer
    }



    boolean equals(o) {
        if (this.is(o))
            return true;
        if (getClass() != o.class)
            return false;

        return id == o.id;
    }

    int hashCode() {
        return (id != null ? id.hashCode() : 0);
    }



    public String toString ( ) {
        final StringBuilder sb = new StringBuilder ( ) ;
        sb . append ( "Choice" ) ;
        sb . append ( "{id=" ) . append ( id ) ;
        sb . append ( ", title='" ) . append ( title ) . append ( '\'' ) ;
        sb . append ( '}' ) ;
        return sb . toString ( ) ;
    }

}
