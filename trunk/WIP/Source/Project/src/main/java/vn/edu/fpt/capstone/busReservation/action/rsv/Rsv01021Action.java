/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.rsv;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;

/**
 * @author Yoshimi
 * 
 */
public class Rsv01021Action extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    // ==========================Logic Object==========================
    private ReservationLogic reservationLogic;

    /**
     * @param reservationLogic
     *            the reservationLogic to set
     */
    public void setReservationLogic(ReservationLogic reservationLogic) {
        this.reservationLogic = reservationLogic;
    }

    // ==========================Action Input==========================
    private String reservationCode;
    private String email;

    /**
     * @param reservationCode
     *            the reservationCode to set
     */
    public void setReservationCode(String reservationCode) {
        this.reservationCode = reservationCode;
    }

    /**
     * @param email
     *            the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    // ==========================Action Output=========================
    private ReservationInfo reservationInfo;

    /**
     * @return the reservationInfo
     */
    public ReservationInfo getReservationInfo() {
        return reservationInfo;
    }

    // ========================Action Execution========================
    @Override
    public void validate() {
        String[] params = null;
        if (CheckUtils.isNullOrBlank(reservationCode)) {
            params = new String[1];
            params[0] = getText("field.reservationCode");
            addFieldError("reservationCode", getText("msgerrcm001", params));
        }
        if (CheckUtils.isNullOrBlank(email)) {
            params = new String[1];
            params[0] = getText("field.email");
            addFieldError("email", getText("msgerrcm001", params));
        } else if (!CheckUtils.isEmail(email)) {
            addFieldError("email", getText("msgerrau002"));
        }
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.opensymphony.xwork2.ActionSupport#execute()
     */
    @Override
    @Action(results = { @Result(name = INPUT, location = "rsv01010-alt.jsp"),
            @Result(name = ERROR, location = "rsv01010-alt.jsp"),
            @Result(name = SUCCESS, location = "rsv01020-success.jsp")})
    public String execute() {
        try {
            reservationInfo = reservationLogic.loadReservationInfoByCode(
                    reservationCode, email, true);
        } catch (CommonException e) {
            // TODO handle exception
            errorProcessing(e);
            return ERROR;
        }
        return SUCCESS;
    }

}
