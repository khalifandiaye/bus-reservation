/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.user;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.UserLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

/**
 * @author Yoshimi
 * 
 */
@ParentPackage("jsonPackage")
public class LoginAction extends BaseAction {

    /**
	 * 
	 */
    private static final long serialVersionUID = 1L;

    // ==========================Logic Object==========================
    private UserLogic userLogic;

    /**
     * @param userLogic
     *            the userLogic to set
     */
    public void setUserLogic(UserLogic userLogic) {
        this.userLogic = userLogic;
    }

    // ==========================Action Input==========================
    private String username;
    private String password;

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // ==========================Action Output=========================
    private boolean success;
    private String name;
    private int roleId;
    private String errorMessage;

    public boolean isSuccess() {
        return success;
    }

    public String getName() {
        return name;
    }

    /**
     * @return the roleId
     */
    public int getRoleId() {
        return roleId;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    @Action(value = "/login", results = { @Result(type = "json", name = SUCCESS) })
    public String login() {
        String[] params = null;
        User user = null;
        success = false;
        if (CheckUtils.isNullOrBlank(username)) {
            params = new String[1];
            params[0] = "username";
            errorMessage = getText("msgerrcm001", params);
        } else if (CheckUtils.isNullOrBlank(password)) {
            params = new String[1];
            params[0] = "password";
            errorMessage = getText("msgerrcm001", params);
        } else {
            try {
                user = userLogic.loginUser(username, password);
            } catch (CommonException e) {
                errorProcessing(e);
                errorMessage = getActionErrors().iterator().next();
                return SUCCESS;
            }
            session.put(CommonConstant.SESSION_KEY_USER, user);
            name = user.getLastName() + " " + user.getFirstName();
            roleId = user.getRoleId();
            success = true;
        }
        return SUCCESS;
    }

    @Action(value = "/checkUser", results = { @Result(type = "json", name = SUCCESS, params = {
            "excludeProperties", "errorMessage" }) })
    public String checkUser() {
        Object user = null;
        success = false;
        if (session != null
                && session.containsKey(CommonConstant.SESSION_KEY_USER)) {
            user = session.get(CommonConstant.SESSION_KEY_USER);
            if (User.class.isAssignableFrom(user.getClass())) {
                name = ((User) user).getLastName() + " "
                        + ((User) user).getFirstName();
                roleId = ((User) user).getRoleId();
                success = true;
            } else {
                // wrong object on session
                session.remove(CommonConstant.SESSION_KEY_USER);
            }
        }
        return SUCCESS;
    }

    @Action(value = "/logOut", results = { @Result(type = "json", name = SUCCESS, params = {
            "excludeProperties", "name, roleId, errorMessage" }) })
    public String logOut() {
        success = false;
        if (session != null
                || session.containsKey(CommonConstant.SESSION_KEY_USER)) {
            session.remove(CommonConstant.SESSION_KEY_USER);
        }
        success = true;
        return SUCCESS;
    }
}
