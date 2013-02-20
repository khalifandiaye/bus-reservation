package vn.edu.fpt.capstone.busReservation.action.booking;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentMethodBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.SeatInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;

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

    private String selectedSeat;
    private List<SeatInfo> listSeats = new ArrayList<SeatInfo>();
    private List<PaymentMethodBean> paymentMethods;
    private ReservationInfo reservationInfo;

    public List<SeatInfo> getListSeats() {
        return listSeats;
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

    public void setSelectedSeat(String selectedSeat) {
        this.selectedSeat = selectedSeat;
    }

    @SuppressWarnings("unchecked")
    public String execute() {
        String[] seats;
        List<TripBean> tripBeanList = null;
        session.put("selectedSeats", selectedSeat);
        seats = selectedSeat.split(";");
        for (int i = 0; i < seats.length; i++) {
            listSeats.add(new SeatInfo(seats[i], "2"));
        }
        paymentMethods = paymentLogic.getPaymentMethods();
        tripBeanList = (List<TripBean>) session.get("listTripBean");
        try {
            reservationInfo = reservationLogic.createReservationInfo(
                    tripBeanList, listSeats.size());
            paymentLogic.updateReservationPaymentInfo(reservationInfo,
                    paymentMethods.get(0).getId());
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        }
        session.put(ReservationInfo.class.getName(), reservationInfo);
        return SUCCESS;
    }
}
