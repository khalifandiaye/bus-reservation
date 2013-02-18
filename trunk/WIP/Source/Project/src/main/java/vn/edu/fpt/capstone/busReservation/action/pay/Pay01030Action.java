/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import urn.ebay.api.PayPalAPI.GetExpressCheckoutDetailsResponseType;
import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;

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

    /**
     * @param paymentLogic
     *            the paymentLogic to set
     */
    public void setPaymentLogic(PaymentLogic paymentLogic) {
        this.paymentLogic = paymentLogic;
    }

    // =========================Action Output============================
    private String reservationCode;

    /**
     * @return the reservationCode
     */
    public String getReservationCode() {
        return reservationCode;
    }

    public String execute() {
        GetExpressCheckoutDetailsResponseType checkoutDetailsResponse = null;
        String token = null;
        String reservationId = null;
        String[] paymentDetails = null;

        token = (String) session.get("paymentToken");
        reservationId = (String) session.get("reservationId");
        if (CheckUtils.isNullOrBlank(reservationId)
                || CheckUtils.isNullOrBlank(token)
                || !CheckUtils.isPositiveInteger(reservationId)) {
            LOG.debug("paymentToken: " + token + "; reservationId: " + reservationId);
            commonSessionTimeoutError();
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
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        }
        session.remove("reservationInfo");
        session.remove("reservationId");
        return SUCCESS;
    }
}
