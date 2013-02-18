/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import java.io.IOException;
import java.text.ParseException;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;

/**
 * @author Yoshimi
 * 
 */
@ParentPackage("jsonPackage")
public class PayJSONAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 3069892143448698004L;

    // ==========================Logic Object==========================
    private PaymentLogic paymentLogic;

    /**
     * @param paymentLogic
     *            the paymentLogic to set
     */
    public void setPaymentLogic(PaymentLogic paymentLogic) {
        this.paymentLogic = paymentLogic;
    }

    // ==========================Action Input==========================
    private Integer paymentMethodId;

    /**
     * @param paymentMethodId
     *            the paymentMethodId to set
     */
    public void setPaymentMethodId(Integer paymentMethodId) {
        this.paymentMethodId = paymentMethodId;
    }

    // ==========================Action Output=========================
    private ReservationInfo reservationInfo;
    private String errorMessage;

    /**
     * @return the reservationInfo
     */
    public ReservationInfo getReservationInfo() {
        return reservationInfo;
    }

    /**
     * @return the errorMessage
     */
    public String getErrorMessage() {
        return errorMessage;
    }

    @Action(value = "/calculateFee", results = { @Result(type = "json", name = SUCCESS, params = {
            "includeProperties", "reservationInfo, errorMessage" }) })
    public String calculateFee() {
        if (paymentMethodId != null) {
            reservationInfo = (ReservationInfo) getSession().get(
                    "reservationInfo");
            if (reservationInfo != null) {
                try {
                    paymentLogic.updateReservationInfo(reservationInfo,
                            paymentMethodId);
                } catch (IOException e) {
                    // TODO error processing
                    errorMessage = getText("msgerrcm000");
                    LOG.error("msgerrcm000", e);
                    return SUCCESS;
                } catch (ParseException e) {
                    // TODO error processing
                    errorMessage = getText("msgerrcm000");
                    LOG.error("msgerrcm000", e);
                    return SUCCESS;
                }
                getSession().put("reservationInfo", reservationInfo);
            } else {
                // TODO error processing
                errorMessage = getText("msgerrcm000");
                LOG.error("msgerrcm000");
                return SUCCESS;
            }
        } else {
            // TODO error processing
            errorMessage = getText("msgerrcm000");
            LOG.error("msgerrcm000");
            return SUCCESS;
        }
        return SUCCESS;
    }

}
