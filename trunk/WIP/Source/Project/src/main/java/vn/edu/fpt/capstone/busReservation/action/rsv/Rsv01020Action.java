/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.rsv;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

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
        if (CheckUtils.isNullOrBlank(reservationId)
                && !session
                        .containsKey(CommonConstant.SESSION_KEY_RESERVATION_ID)) {
            addActionError(getText("msgerrcm000"));
        } else if ((!CheckUtils.isNullOrBlank(reservationId) && !CheckUtils
                .isPositiveInteger(reservationId))
                || !Integer.class.isAssignableFrom(session.get(
                        CommonConstant.SESSION_KEY_RESERVATION_ID).getClass())) {
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
        int userId = 0;
        Object user = null;
        if (session != null
                && session.containsKey(CommonConstant.SESSION_KEY_USER)) {
            user = session.get(CommonConstant.SESSION_KEY_USER);
            if (User.class.isAssignableFrom(user.getClass())) {
                userId = ((User) user).getUserId();
            } else {
                // wrong object on session
                session.remove(CommonConstant.SESSION_KEY_USER);
            }
        }
        try {
            if (CheckUtils.isNullOrBlank(reservationId)) {
                reservationInfo = reservationLogic
                        .loadReservationInfo(
                                (Integer) session
                                        .get(CommonConstant.SESSION_KEY_RESERVATION_ID),
                                userId);
            } else {
                reservationInfo = reservationLogic.loadReservationInfo(
                        reservationId, userId);
                session.put(CommonConstant.SESSION_KEY_RESERVATION_ID,
                        Integer.parseInt(reservationId));
            }
        } catch (CommonException e) {
            // TODO handle exception
            errorProcessing(e);
            return ERROR;
        }
        return SUCCESS;
    }

}
