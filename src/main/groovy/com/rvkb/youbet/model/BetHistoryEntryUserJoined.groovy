package com.rvkb.youbet.model

import javax.persistence.Entity

@Entity
class BetHistoryEntryUserJoined extends BetHistoryEntry {

    @Override
    String getMessage() {
        'joined the bet'
    }


}
