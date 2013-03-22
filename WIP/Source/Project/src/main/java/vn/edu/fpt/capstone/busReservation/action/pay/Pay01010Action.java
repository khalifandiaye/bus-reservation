/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import java.util.List;

import org.hibernate.HibernateException;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentMethodBean;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

/**
 * @author Yoshimi
 * 
 */
public class Pay01010Action extends BaseAction {

    /**
	 * 
	 */
    private static final long serialVersionUID = 5713118155580163291L;

    // ==========================Action Input==========================
    // private String reservationId;

    // /**
    // * @param reservationId
    // * the reservationId to set
    // */
    // public void setReservationId(String reservationId) {
    // this.reservationId = reservationId;
    // }

    // ==========================Logic Object==========================
    private PaymentLogic paymentLogic;
    private ReservationLogic reservationLogic;

    /**
     * @param paymentLogic
     *            the paymentLogic to set
     */
    public void setPaymentLogic(PaymentLogic paymentLogic) {
        this.paymentLogic = paymentLogic;
    }

    /**
     * @param reservationLogic
     *            the reservationLogic to set
     */
    public void setReservationLogic(ReservationLogic reservationLogic) {
        this.reservationLogic = reservationLogic;
    }

    // ==========================Action Output=========================
    private ReservationInfo reservationInfo;
    private List<PaymentMethodBean> paymentMethods;

    /**
     * @return the reservationInfo
     */
    public ReservationInfo getReservationInfo() {
        return reservationInfo;
    }

    /**
     * @return the paymentMethods
     */
    public List<PaymentMethodBean> getPaymentMethods() {
        return paymentMethods;
    }

    @Override
    public void validate() {
        // if (CheckUtils.isNullOrBlank(reservationId)) {
        // addFieldError("reservationId", "Please choose an id");
        // }
        // if (!CheckUtils.isPositiveInteger(reservationId)) {
        // addFieldError("reservationId",
        // "System error, please wait for update");
        // }
    }

    private String forTest() {
        String reservationId = null;
        // ===TEST CODE (wokr in conjuction with pay01000)
        reservationId = servletRequest
                .getParameter(CommonConstant.SESSION_KEY_RESERVATION_ID);
        if (reservationId == null) {
            reservationId = (String) session.get(
                    CommonConstant.SESSION_KEY_RESERVATION_ID);
        }
        session.put(CommonConstant.SESSION_KEY_RESERVATION_ID, reservationId);
        // ===TEST CODE END================================
        return reservationId;
    }

    /* (non-Javadoc)
     * @see com.opensymphony.xwork2.ActionSupport#execute()
     */
    public String execute() {
        String reservationId = null;
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
        reservationId = (String) session.get("reservationId");
        if (CheckUtils.isNullOrBlank(reservationId)) {
            
        }

        // TODO remove this later
        reservationId = forTest();

        paymentMethods = paymentLogic.getPaymentMethods();
        session.put(CommonConstant.SESSION_KEY_RESERVATION_ID,
                reservationId);
        try {
            reservationInfo = reservationLogic
                    .loadReservationInfo(reservationId, userId);
            paymentLogic.updateReservationPaymentInfo(
                    reservationInfo, reservationInfo.getTickets().get(0).getSeats(), paymentMethods.get(0).getId());
        } catch (HibernateException e) {
            // TODO error processing
            genericDatabaseErrorProcess(e);
            return ERROR;
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        }
        session.put(ReservationInfo.class.getName(), reservationInfo);

        return SUCCESS;
    }

}
