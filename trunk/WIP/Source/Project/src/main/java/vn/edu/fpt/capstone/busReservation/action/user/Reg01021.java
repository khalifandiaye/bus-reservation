/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.user;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.UserLogic;

/**
 * @author Yoshimi
 * 
 */
public class Reg01021 extends BaseAction {

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

    /**
     * @param username
     *            the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String execute() {
        try {
            userLogic.sendActivationMail(username, servletRequest.getContextPath());
        } catch (Exception e) {
            errorProcessing(new CommonException("msgerrcm003", e), false);
            return ERROR;
        }
        return SUCCESS;
    }
}
