/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.hibernate.HibernateException;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.RefundInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

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
    private String reservationId;
    private String forwardSeats;
    private String returnSeats;

    /**
     * @param paymentMethodId
     *            the paymentMethodId to set
     */
    public void setPaymentMethodId(Integer paymentMethodId) {
        this.paymentMethodId = paymentMethodId;
    }

    /**
     * @param reservationId
     *            the reservationId to set
     */
    public void setReservationId(String reservationId) {
        this.reservationId = reservationId;
    }

    /**
     * @param forwardSeats
     *            the forwardSeats to set
     */
    public void setForwardSeats(String forwardSeats) {
        this.forwardSeats = forwardSeats;
    }

    /**
     * @param returnSeats
     *            the returnSeats to set
     */
    public void setReturnSeats(String returnSeats) {
        this.returnSeats = returnSeats;
    }

    // ==========================Action Output=========================
    private ReservationInfo reservationInfo;
    private String cancelConfirmMessage;
    private String errorMessage;

    /**
     * @return the reservationInfo
     */
    public ReservationInfo getReservationInfo() {
        return reservationInfo;
    }

    /**
     * @return the cancelConfirmMessage
     */
    public String getCancelConfirmMessage() {
        return cancelConfirmMessage;
    }

    /**
     * @return the errorMessage
     */
    public String getErrorMessage() {
        return errorMessage;
    }

    @Action(value = "/calculateFee", results = { @Result(type = "json", name = SUCCESS, params = {
            "excludeProperties", "cancelConfirmMessage", "callbackParameter",
            "callback" }) })
    public String calculateFee() {
        if (paymentMethodId != null) {
            reservationInfo = (ReservationInfo) session
                    .get(ReservationInfo.class.getName());
            if (reservationInfo != null) {
                try {
                    paymentLogic.updateReservationPaymentInfo(
                            reservationInfo,
                            forwardSeats == null ? null : forwardSeats
                                    .split(";"), returnSeats == null ? null
                                    : returnSeats.split(";"), paymentMethodId);
                } catch (CommonException e) {
                    errorMessage = getText(e.getMessageId(), e.getParameters());
                    ;
                    return SUCCESS;
                } catch (HibernateException e) {
                    // TODO error processing
                    errorMessage = getText("msgerrdb001");
                    return SUCCESS;
                }
                session.put(ReservationInfo.class.getName(), reservationInfo);
                session.put(CommonConstant.SESSION_KEY_PAYMENT_METHOD_ID,
                        paymentMethodId);
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

    @Action(value = "/calculateRefund", results = { @Result(type = "json", name = SUCCESS, params = {
            "excludeProperties", "reservationInfo", "callbackParameter",
            "callback" }) })
    public String calculateRefund() {
        String args[] = null;
        RefundInfo refundInfo = null;
        if (CheckUtils.isNullOrBlank(reservationId)) {
            // TODO handle error
            errorMessage = getText("msgerrcm000");
            LOG.error("msgerrcm000");
            return SUCCESS;
        } else if (!CheckUtils.isPositiveInteger(reservationId)) {
            // TODO handle error
            errorMessage = getText("msgerrcm000");
            LOG.error("msgerrcm000");
            return SUCCESS;
        }
        try {
            refundInfo = paymentLogic.calculateRefundAmount(Integer
                    .parseInt(reservationId));
            args = new String[3];
            args[0] = refundInfo.getRefundAmountString();
            args[1] = refundInfo.getRefundAmountInUSDString();
            args[2] = refundInfo.getRefundRateString();
            cancelConfirmMessage = getText("message.cancelConfirm", args);
        } catch (CommonException e) {
            errorMessage = getText(e.getMessageId(), e.getParameters());
            return SUCCESS;
        } catch (HibernateException e) {
            // TODO error processing
            genericDatabaseErrorProcess(e);
            return ERROR;
        }
        return SUCCESS;
    }

    @Action(value = "/cancelReservation", results = { @Result(type = "json", name = SUCCESS, params = {
            "excludeProperties", "reservationInfo", "callbackParameter",
            "callback" }) })
    public String cancelReservation() {
        int userId = 0;
        if (CheckUtils.isNullOrBlank(reservationId)) {
            // TODO handle error
            errorMessage = getText("msgerrcm000");
            LOG.error("msgerrcm000");
            return SUCCESS;
        } else if (!CheckUtils.isPositiveInteger(reservationId)) {
            // TODO handle error
            errorMessage = getText("msgerrcm000");
            LOG.error("msgerrcm000");
            return SUCCESS;
        }
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
            paymentLogic.doRefund(Integer.parseInt(reservationId), userId);
            cancelConfirmMessage = getText("message.cancelSuccess");
        } catch (Exception e) {
            errorProcessing(e, true);
            errorMessage = getActionErrors().iterator().next();
            return SUCCESS;
        }
        try {
            paymentLogic.sendCancelReservationMail(
                    Integer.parseInt(reservationId),
                    servletRequest.getContextPath());
        } catch (Exception e) {
            errorProcessing(e, false);
            errorMessage = getActionErrors().iterator().next();
            return SUCCESS;
        }
        return SUCCESS;
    }

}
