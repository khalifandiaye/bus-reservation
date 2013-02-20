/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import org.apache.struts2.convention.annotation.ParentPackage;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

/**
 * @author Yoshimi
 * 
 */
@ParentPackage(value = "basePackage")
public class Pay01020Action extends BaseAction {

    /**
	 * 
	 */
    private static final long serialVersionUID = 850559893103389051L;

    // ==========================Logic Object==========================
    private PaymentLogic paymentLogic;

    /**
     * @param paymentLogic
     *            the paymentLogic to set
     */
    public void setPaymentLogic(PaymentLogic paymentLogic) {
        this.paymentLogic = paymentLogic;
    }

    private String redirectUrl;

    /**
     * @return the redirectUrl
     */
    public String getRedirectUrl() {
        return redirectUrl;
    }

    public String execute() {
        String paymentToken = null;
        ReservationInfo reservationInfo = null;

        reservationInfo = (ReservationInfo) session.get(
                ReservationInfo.class.getName());
        try {
            paymentToken = paymentLogic.setPaypalExpressCheckout(
                    reservationInfo, servletRequest.getContextPath());
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        }
        redirectUrl = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token="
                + paymentToken;
        session.put(CommonConstant.SESSION_KEY_PAYMENT_TOKEN, paymentToken);

        return SUCCESS;
    }

}
