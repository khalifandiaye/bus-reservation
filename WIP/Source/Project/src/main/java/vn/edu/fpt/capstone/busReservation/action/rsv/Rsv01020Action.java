/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.rsv;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;

/**
 * @author Yoshimi
 * 
 */
public class Rsv01020Action extends BaseAction {

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
    private String reservationId;

    /**
     * @param reservationId
     *            the reservationId to set
     */
    public void setReservationId(String reservationId) {
        this.reservationId = reservationId;
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
        if (CheckUtils.isNullOrBlank(reservationId)) {
            addActionError(getText("msgerrcm000"));
        } else if (!CheckUtils.isPositiveInteger(reservationId)) {
            addActionError(getText("msgerrcm000"));
        }
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.opensymphony.xwork2.ActionSupport#execute()
     */
    @Override
    public String execute() {
        try {
            reservationInfo = reservationLogic.loadReservationInfo(
                    reservationId, false);
        } catch (CommonException e) {
            // TODO handle exception
            errorProcessing(e);
            return ERROR;
        }
        return SUCCESS;
    }

}
