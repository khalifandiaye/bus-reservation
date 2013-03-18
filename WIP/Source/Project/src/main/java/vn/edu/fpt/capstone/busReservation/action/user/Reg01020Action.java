/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.user;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.opensymphony.xwork2.ModelDriven;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.RegisterModel;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.UserLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;

/**
 * @author NoName
 * 
 */
public class Reg01020Action extends BaseAction implements ModelDriven<RegisterModel> {

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
    private RegisterModel model;
    private String recaptcha_challenge_field;
    private String recaptcha_response_field;

    /**
     * @return the model
     */
    public RegisterModel getModel() {
        return model;
    }

    /**
     * @param model
     *            the model to set
     */
    public void setModel(RegisterModel model) {
        this.model = model;
    }

    /**
     * @param recaptcha_challenge_field
     *            the recaptcha_challenge_field to set
     */
    public void setRecaptcha_challenge_field(String recaptcha_challenge_field) {
        this.recaptcha_challenge_field = recaptcha_challenge_field;
    }

    /**
     * @param recaptcha_response_field
     *            the recaptcha_response_field to set
     */
    public void setRecaptcha_response_field(String recaptcha_response_field) {
        this.recaptcha_response_field = recaptcha_response_field;
    }

    @Action(results = { @Result(name = INPUT, location = "reg01010-success.jsp") })
    public String execute() {
        try {
            userLogic.registerUser(model, servletRequest.getContextPath());
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
            params[0] = getText("field.confirmedPassword");
            addFieldError("model.confirmedPassword",
                    getText("msgerrcm001", params));
        } else if (!CheckUtils.isNullOrBlank(model.getPassword())
                && !model.getConfirmedPassword().equals(model.getPassword())) {
            addFieldError("model.confirmedPassword", getText("msgerrau002"));
        }
        if (CheckUtils.isNullOrBlank(model.getEmail())) {
            params = new String[1];
            params[0] = getText("field.email");
            addFieldError("model.email", getText("msgerrcm001", params));
        } else if (!CheckUtils.isEmail(model.getEmail())) {
            addFieldError("model.email", getText("msgerrau002"));
        }
        try {
            if (!userLogic.confirmCaptcha(recaptcha_challenge_field,
                    recaptcha_response_field, servletRequest.getRemoteAddr())) {
                addFieldError("captcha", getText("msgerrau005"));
            }
        } catch (CommonException e) {
            errorProcessing(e);
        }
    }

    @Override
    public void prepare() throws Exception {
        super.prepare();
        if (model == null) {
            model = new RegisterModel();
        }
    }
}
