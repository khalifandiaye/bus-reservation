/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.hibernate.HibernateException;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
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

    @Action(value = "/calculateFee", results = { @Result(type = "json", name = SUCCESS) })
    public String calculateFee() {
        if (paymentMethodId != null) {
            reservationInfo = (ReservationInfo) session.get(
                    ReservationInfo.class.getName());
            if (reservationInfo != null) {
                try {
                    paymentLogic.updateReservationPaymentInfo(reservationInfo,
                            paymentMethodId);
                } catch (CommonException e) {
                    errorProcessing(e);
                    return ERROR;
                } catch (HibernateException e) {
                    // TODO error processing
                    genericDatabaseErrorProcess(e);
                    return ERROR;
                }
                session.put(ReservationInfo.class.getName(), reservationInfo);
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
