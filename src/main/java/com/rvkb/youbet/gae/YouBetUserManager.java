package com.rvkb.youbet.gae;

import com.rvkb.youbet.model.User;
import woko.users.UserManager;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class YouBetUserManager implements UserManager {

    private static final String ROLE_USER = "user";
    private static final List<String> ROLES = Collections.unmodifiableList(Arrays.asList(ROLE_USER));
    private static final String REQ_PARAM_PASSWORD = "password";

    private final YouBetWokoStore store;

    public YouBetUserManager(YouBetWokoStore store) {
        this.store = store;
    }

    @Override
    public List<String> getRoles(String username) {
        if (username==null) {
            return Collections.emptyList();
        }
        User user = store.getUser(username);
        if (user==null) {
            return Collections.emptyList();
        }
        if (username.equals("wdevel")) {
            return Arrays.asList("developer");
        } else {
            return ROLES;
        }
    }

    @Override
    public boolean authenticate(String username, HttpServletRequest req) {
        if (username==null) {
            return false;
        }
        String pass =  req.getParameter(REQ_PARAM_PASSWORD);
        if (pass==null) {
            return false;
        }
        String expected = hashPassword(pass);
        User user = store.getUser(username);
        if (user==null) {
            return false;
        }
        String actual = user.getHashedPassword();
        return actual != null && actual.equals(expected);
    }

    public String hashPassword(String pass) {
        return Integer.toString(pass.hashCode());
    }

    public User addUser(User user) {
        return (User)store.save(user);
    }
}
