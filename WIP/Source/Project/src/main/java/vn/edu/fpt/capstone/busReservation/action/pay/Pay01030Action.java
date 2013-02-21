/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import java.io.IOException;

import org.hibernate.HibernateException;

import urn.ebay.api.PayPalAPI.GetExpressCheckoutDetailsResponseType;
import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
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
     * @param reservationLogic the reservationLogic to set
     */
    public void setReservationLogic(ReservationLogic reservationLogic) {
        this.reservationLogic = reservationLogic;
    }

    // =========================Action Output============================
    private String reservationCode;
    private ReservationInfo reservationInfo;

    /**
     * @return the reservationCode
     */
    public String getReservationCode() {
        return reservationCode;
    }

    /**
     * @return the reservationInfo
     */
    public ReservationInfo getReservationInfo() {
        return reservationInfo;
    }

    public String execute() {
        GetExpressCheckoutDetailsResponseType checkoutDetailsResponse = null;
        String token = null;
        String reservationId = null;
        String[] paymentDetails = null;
        String status = null;

        token = (String) session.get(CommonConstant.SESSION_KEY_PAYMENT_TOKEN);
        reservationId = (String) session.get(CommonConstant.SESSION_KEY_RESERVATION_ID);
        if (CheckUtils.isNullOrBlank(reservationId)
                || CheckUtils.isNullOrBlank(token)
                || !CheckUtils.isPositiveInteger(reservationId)) {
            LOG.debug("paymentToken: " + token + "; reservationId: " + reservationId);
            commonSessionTimeoutError();
            return ERROR;
        }
        status = reservationLogic.updateStatus(reservationId);
        if (ReservationStatus.DEPARTED.getValue().equals(status)) {
            // bus has departed
            addActionError(getText("msgerrrs001"));
            return ERROR;
        } else if(ReservationStatus.DELETED.getValue().equals(status)) {
            // reservation time out
            String[] args = new String[1];
            args[0] = Integer.toString(CommonConstant.RESERVATION_TIMEOUT);
            addActionError(getText("msgerrrs002", args));
            return ERROR;
        } else if(!ReservationStatus.UNPAID.getValue().equals(status)) {
            // unknown, but it should not be paid for anyway
            addActionError(getText("msgerrrs003"));
            return ERROR;
        }
        try {
            checkoutDetailsResponse = paymentLogic
                    .getPaypalExpressCheckoutDetails(token);
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        }
        try {
            paymentDetails = paymentLogic
                    .doPaypalExpressCheckoutPayment(checkoutDetailsResponse);
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        }
        try {
            reservationCode = paymentLogic.savePayment(reservationId, paymentDetails);
            reservationInfo = reservationLogic.loadReservationInfo(reservationId);
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        } catch (HibernateException e) {
            // TODO error processing
            genericDatabaseErrorProcess(e);
            return ERROR;
        } catch (IOException e) {
            //TODO error processing
            addActionError(getText("msgerrws001"));
            return ERROR;
        }
        session.remove(ReservationInfo.class.getName());
        session.remove(CommonConstant.SESSION_KEY_RESERVATION_ID);
        session.remove(CommonConstant.SESSION_KEY_PAYMENT_TOKEN);
        return SUCCESS;
    }
}
