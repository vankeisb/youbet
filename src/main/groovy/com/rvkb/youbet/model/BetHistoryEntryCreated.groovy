package com.rvkb.youbet.model

import javax.persistence.Entity

@Entity
class BetHistoryEntryCreated extends BetHistoryEntry {

    @Override
    String getMessage() {
        'created the bet'
    }


}
