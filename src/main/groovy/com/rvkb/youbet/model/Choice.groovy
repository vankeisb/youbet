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
            if (a.user.equals(user)) {
                v += a.amount
            }
        }
        return v
    }

    void addToAnswers(Answer answer) {
        if (answers==null) {
            answers = []
        }
        answers << answer
    }
}
