/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

/**
 * @author Yoshimi
 *
 */
public class PaymentSetupDetails implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String paymentToken;
    private String redirectUrl;
    /**
     * @return the paymentToken
     */
    public String getPaymentToken() {
        return paymentToken;
    }
    /**
     * @param paymentToken the paymentToken to set
     */
    public void setPaymentToken(String paymentToken) {
        this.paymentToken = paymentToken;
    }
    /**
     * @return the redirectUrl
     */
    public String getRedirectUrl() {
        return redirectUrl;
    }
    /**
     * @param redirectUrl the redirectUrl to set
     */
    public void setRedirectUrl(String redirectUrl) {
        this.redirectUrl = redirectUrl;
    }

}
