package com.rvkb.youbet.woko

import woko.users.UserManager
import javax.servlet.http.HttpServletRequest
import com.rvkb.youbet.model.User

class YoubetUserManager implements UserManager {

    private final YoubetStore store

    YoubetUserManager(YoubetStore store) {
        this.store = store
    }

    List<String> getRoles(String s) {
        User user = store.getUser(s)
        if (user==null) {
            return Collections.emptyList()
        }
        return Arrays.asList(user.role)
    }

    boolean authenticate(String s, HttpServletRequest request) {
        User u = store.getUser(s)
        if (u==null) {
            return false
        }
        String actualPassword = u.hashedPassword
        String expectedPassword = extractPassword(request)
        return actualPassword == expectedPassword
    }

    String extractPassword(HttpServletRequest request) {
        String realPass = request.getParameter('password')
        if (realPass==null) {
            return null
        }
        return hashPassword(realPass)
    }

    String hashPassword(String p) {
        if (p==null) {
            return null
        }
        return Integer.toString(p.hashCode())
    }

}
