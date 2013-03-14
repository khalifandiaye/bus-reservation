/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.user;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.RegisterModel;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.UserLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
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
    private String id;
    private String code;

    /**
     * @param id
     *            the id to set
     */
    public void setId(String id) {
        this.id = id;
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
            user = userLogic.activateUser(Integer.parseInt(id), code);
            session.put(CommonConstant.SESSION_KEY_USER, user);
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        }
        return SUCCESS;
    }

    @Override
    public void validate() {
        if (CheckUtils.isNullOrBlank(id) || CheckUtils.isNullOrBlank(code)
                || !CheckUtils.isPositiveInteger(id)) {
            addActionError("msgerrau004");
        }
    }

}
