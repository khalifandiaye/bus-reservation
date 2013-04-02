/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import org.hibernate.HibernateException;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

/**
 * @author Yoshimi
 * 
 */
public class Pay01030Action extends BaseAction {

    /**
	 * 
	 */
    private static final long serialVersionUID = -855508237619631030L;

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

    // =========================Action Output============================
    private ReservationInfo reservationInfo;

    /**
     * @return the reservationInfo
     */
    public ReservationInfo getReservationInfo() {
        return reservationInfo;
    }

    public String execute() {
        String token = null;
        String status = null;
        int userId = 0;
        Object object = null;
        int paymentMethodId = 0;

        if (session != null) {
            if (session.containsKey(CommonConstant.SESSION_KEY_USER)) {
                object = session.get(CommonConstant.SESSION_KEY_USER);
                if (User.class.isAssignableFrom(object.getClass())) {
                    userId = ((User) object).getUserId();
                } else {
                    // wrong object on session
                    session.remove(CommonConstant.SESSION_KEY_USER);
                }
            }
            if (session
                    .containsKey(CommonConstant.SESSION_KEY_PAYMENT_METHOD_ID)) {
                object = session
                        .get(CommonConstant.SESSION_KEY_PAYMENT_METHOD_ID);
                if (Integer.class.isAssignableFrom(object.getClass())) {
                    paymentMethodId = (Integer) object;
                } else {
                    // wrong object on session
                    session.remove(CommonConstant.SESSION_KEY_PAYMENT_METHOD_ID);
                    commonSessionTimeoutError();
                    return ERROR;
                }
            }
        }
        if (session.containsKey(ReservationInfo.class.getName())) {
            object = session.get(ReservationInfo.class.getName());
            if (ReservationInfo.class.isAssignableFrom(object.getClass())) {
                reservationInfo = (ReservationInfo) object;
            } else {
                // wrong object on session
                session.remove(ReservationInfo.class.getName());
                commonSessionTimeoutError();
                return ERROR;
            }
        }

        token = (String) session.get(CommonConstant.SESSION_KEY_PAYMENT_TOKEN);
        status = reservationLogic.updateReservationStatus(reservationInfo
                .getId());
        if (ReservationStatus.DELETED.getValue().equals(status)) {
            // reservation time out
            String[] args = new String[1];
            args[0] = Integer.toString(CommonConstant.RESERVATION_TIMEOUT);
            addActionError(getText("msgerrrs002", args));
            return ERROR;
        } else if (!ReservationStatus.UNPAID.getValue().equals(status)) {
            // unknown, but it should not be paid for anyway
            addActionError(getText("msgerrrs003"));
            return ERROR;
        }
        try {
            paymentLogic.doPayment(reservationInfo, paymentMethodId, token);
            reservationInfo = reservationLogic.loadReservationInfo(
                    reservationInfo.getId(), userId);
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        } catch (HibernateException e) {
            // TODO error processing
            genericDatabaseErrorProcess(e);
            return ERROR;
        }
        try {
            paymentLogic.sendReservationCompleteMail(reservationInfo.getId(),
                    servletRequest.getContextPath());
        } catch (Exception e) {
            errorProcessing(new CommonException("msgerrcm003", e), false);
        }

        session.remove(ReservationInfo.class.getName());
        session.remove(CommonConstant.SESSION_KEY_PAYMENT_TOKEN);

        return SUCCESS;
    }
}
