package com.rvkb.youbet.model

import javax.persistence.Entity
import javax.persistence.ManyToOne
import javax.persistence.FetchType

@Entity
class BetHistoryEntryAnswerAdded extends BetHistoryEntry {

    @ManyToOne(fetch=FetchType.LAZY)
    Answer answer

    @Override
    String getMessage() {
        return "added <b>${answer.amount}</b> to choice <b>${answer.choice.title}</b>"
    }


}
