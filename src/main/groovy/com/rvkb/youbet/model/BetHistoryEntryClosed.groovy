package com.rvkb.youbet.model

import javax.persistence.Entity

@Entity
class BetHistoryEntryClosed extends BetHistoryEntry {

    @Override
    String getMessage() {
        'closed the bet'
    }


}
