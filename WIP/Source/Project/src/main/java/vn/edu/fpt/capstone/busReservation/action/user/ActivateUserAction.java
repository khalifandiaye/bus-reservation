/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.user;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.UserLogic;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

/**
 * @author Yoshimi
 * 
 */
public class ActivateUserAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    // ===========================DAO Object===========================
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
    private String code;

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @param code
     *            the code to set
     */
    public void setCode(String code) {
        this.code = code;
    }

    public String execute() {
        User user = null;
        try {
            user = userLogic.activateUser(username, code);
            session.put(CommonConstant.SESSION_KEY_USER, user);
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        }
        return SUCCESS;
    }

    @Override
    public void validate() {
    }

}
