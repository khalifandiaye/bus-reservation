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

    private List<PaymentMethodBean> paymentMethods;
    private ReservationInfo reservationInfo;
    private String inputFirstName;
	private String inputLastName;
	private String inputMobile;
	private String inputEmail;
	private String seatToPayment;
	

	/**
	 * @param seatToPayment the seatToPayment to set
	 */
	public void setSeatToPayment(String seatToPayment) {
		this.seatToPayment = seatToPayment;
	}

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
    	if(seatToPayment == null){
    		return ERROR;
    	}
    	User user;
		if(!(session.get(CommonConstant.SESSION_KEY_USER) == null) || !(session.get("User_tmp") == null)){
			if(!(session.get("User_tmp") == null)){
				user = (User)session.get("User_tmp");
			}else{
				user = (User)session.get(CommonConstant.SESSION_KEY_USER);
			}
			this.inputFirstName = user.getFirstName();
			this.inputLastName = user.getLastName();
			this.inputEmail = user.getEmail();
			this.inputMobile = user.getMobilePhone();
		}
    	
        List<TripBean> tripBeanList = null;

        paymentMethods = paymentLogic.getPaymentMethods();
        tripBeanList = (List<TripBean>) session.get("listTripBean");
        try {
            reservationInfo = reservationLogic.createReservationInfo(
                    tripBeanList, seatToPayment.split(";").length);
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
