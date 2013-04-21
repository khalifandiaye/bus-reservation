package vn.edu.fpt.capstone.busReservation.action.booking;

import java.util.List;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentMethodBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

public class BookingInfoAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
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

    // ==========================Action Input==========================
    private String forwardSeats;
    private String returnSeats;

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
    private List<PaymentMethodBean> paymentMethods;
    private ReservationInfo reservationInfo;
    private String inputFirstName;
    private String inputLastName;
    private String inputMobile;
    private String inputEmail;

    /**
     * @return the inputFirstName
     */
    public String getInputFirstName() {
        return inputFirstName;
    }

    /**
     * @return the inputLastName
     */
    public String getInputLastName() {
        return inputLastName;
    }

    /**
     * @return the inputMobile
     */
    public String getInputMobile() {
        return inputMobile;
    }

    /**
     * @return the inputEmail
     */
    public String getInputEmail() {
        return inputEmail;
    }

    /**
     * @return the paymentMethods
     */
    public List<PaymentMethodBean> getPaymentMethods() {
        return paymentMethods;
    }

    /**
     * @return the reservationInfo
     */
    public ReservationInfo getReservationInfo() {
        return reservationInfo;
    }

    @SuppressWarnings("unchecked")
    public String execute() {
        User user = null;
        User sessionUser = null;
        if (forwardSeats == null) {
            return ERROR;
        }
        // get user if exists from session
        sessionUser = getUserFromSession();
        if (session.containsKey("User_tmp")) {
            user = (User) session.get("User_tmp");
        } else if (sessionUser != null) {
            user = sessionUser;
        }
        if (user != null) {
            this.inputFirstName = user.getFirstName();
            this.inputLastName = user.getLastName();
            this.inputEmail = user.getEmail();
            this.inputMobile = user.getMobilePhone();
        }

        List<TripBean> tripBeanList = null;
        List<TripBean> returnTrips = null;

        paymentMethods = paymentLogic.getPaymentMethods(sessionUser == null ? 0
                : sessionUser.getRoleId());
        tripBeanList = (List<TripBean>) session.get("listOutTripBean");
        returnTrips = (List<TripBean>) session.get("listReturnTripBean");
        try {
            reservationInfo = reservationLogic.createReservationInfo(
                    tripBeanList, returnTrips, forwardSeats.split(";").length,
                    returnSeats == null ? 0 : returnSeats.split(";").length);
            paymentLogic.updateReservationPaymentInfo(reservationInfo,
                    forwardSeats.split(";"), returnSeats == null ? null
                            : returnSeats.split(";"), paymentMethods.get(0)
                            .getId());
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        }
        session.put(ReservationInfo.class.getName(), reservationInfo);
        return SUCCESS;
    }
}
