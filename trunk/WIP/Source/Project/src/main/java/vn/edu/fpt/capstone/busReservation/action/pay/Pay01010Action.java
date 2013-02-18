/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;

import org.hibernate.HibernateException;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentMethodBean;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;

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

    /**
     * @param paymentLogic
     *            the paymentLogic to set
     */
    public void setPaymentLogic(PaymentLogic paymentLogic) {
        this.paymentLogic = paymentLogic;
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

    public String execute() {
        String reservationId = null;
        // reservationId = (String) getSession().get("reservationId");

        // ===TEST CODE (wokr in conjuction with pay01000)
        reservationId = servletRequest.getParameter("reservationId");
        if (reservationId == null) {
            reservationId = (String) getSession().get("reservationId");
        }
        session.put("reservationId", reservationId);
        // ===TEST CODE END================================

        paymentMethods = paymentLogic.getPaymentMethods();
        getSession().put("reservationId", reservationId);
        try {
            reservationInfo = paymentLogic.getReservationInfo(reservationId,
                    Integer.toString(paymentMethods.get(0).getId()));
        } catch (IOException e) {
            addActionError(getText("msgerrws001"));
            return ERROR;
        } catch (NumberFormatException e) {
            // TODO error processing
            addActionError(getText("msgerrcm000"));
            return ERROR;
        } catch (ParseException e) {
            // TODO error processing
            addActionError(getText("msgerrcm000"));
            return ERROR;
        } catch (HibernateException e) {
            // TODO error processing
            genericDatabaseErrorProcess(e);
            return ERROR;
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        }
        getSession().put("reservationInfo", reservationInfo);

        return SUCCESS;
    }

}
