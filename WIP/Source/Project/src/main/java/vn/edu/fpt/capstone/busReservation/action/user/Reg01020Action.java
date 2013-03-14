/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.user;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.RegisterModel;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.UserLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;

/**
 * @author NoName
 * 
 */
public class Reg01020Action extends BaseAction {

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
    private RegisterModel model;

    /**
     * @param model
     *            the model to set
     */
    public void setModel(RegisterModel model) {
        this.model = model;
    }

    @Action(results = { @Result(name = INPUT, location = "reg01010-success.jsp") })
    public String execute() {
        try {
            userLogic.registerUser(model);
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        }
        return SUCCESS;
    }

    @Override
    public void validate() {
        super.validate();
        String[] params = null;
        if (CheckUtils.isNullOrBlank(model.getUsername())) {
            params = new String[1];
            params[0] = getText("field.username");
            addFieldError("model.username", getText("msgerrcm001", params));
        } else if (userLogic.isUsernameExists(model.getUsername())) {
            addFieldError("model.username", getText("msgerrau003"));
        }
        if (CheckUtils.isNullOrBlank(model.getPassword())) {
            params = new String[1];
            params[0] = getText("field.password");
            addFieldError("model.password", getText("msgerrcm001", params));
        }
        if (CheckUtils.isNullOrBlank(model.getConfirmedPassword())) {
            params = new String[1];
            params[0] = getText("field.confirmPassword");
            addFieldError("model.confirmPassword",
                    getText("msgerrcm001", params));
        } else if (!CheckUtils.isNullOrBlank(model.getPassword())
                && !model.getConfirmedPassword().equals(model.getPassword())) {
            addFieldError("model.confirmPassword", getText("msgerrau002"));
        }
        if (CheckUtils.isNullOrBlank(model.getEmail())) {
            params = new String[1];
            params[0] = getText("field.email");
            addFieldError("model.email", getText("msgerrcm001", params));
        } else if (!CheckUtils.isEmail(model.getEmail())) {
            addFieldError("model.email", getText("msgerrau002"));
        }
    }
}
