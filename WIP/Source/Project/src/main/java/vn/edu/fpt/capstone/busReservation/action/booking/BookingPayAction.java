/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.booking;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.interceptor.SessionAware;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.SeatPositionDAO;
import vn.edu.fpt.capstone.busReservation.dao.UserDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

/**
 * @author NoName
 *
 */
public class BookingPayAction extends BaseAction implements SessionAware {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5962554617409673584L;

    // ==========================Logic Object==========================
    private PaymentLogic paymentLogic;

    /**
     * @param paymentLogic
     *            the paymentLogic to set
     */
    public void setPaymentLogic(PaymentLogic paymentLogic) {
        this.paymentLogic = paymentLogic;
    }

    // =========================Action Output==========================

    private String redirectUrl;

    /**
     * @return the redirectUrl
     */
    public String getRedirectUrl() {
        return redirectUrl;
    }
	
	
	private TripBean tripBean;
	private ReservationDAO reservationDAO = null;
	private SeatPositionDAO seatPositionDAO = null;
	private String inputFirstName;
	private String inputLastName;
	private String inputMobile;
	private String inputEmail;
	private UserDAO userDAO = null;
	private String selectedSeat;
	
	/**
	 * @param selectedSeats the selectedSeats to set
	 */
	public void setSelectedSeat(String selectedSeat) {
		this.selectedSeat = selectedSeat;
	}

	/**
	 * @param userDAO the userDAO to set
	 */
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public void setInputFirstName(String inputFirstName) {
		this.inputFirstName = inputFirstName;
	}

	public void setInputLastName(String inputLastName) {
		this.inputLastName = inputLastName;
	}

	public void setInputMobile(String inputMobile) {
		this.inputMobile = inputMobile;
	}

	public void setInputEmail(String inputEmail) {
		this.inputEmail = inputEmail;
	}

	public void setReservationDAO(ReservationDAO reservationDAO) {
		this.reservationDAO = reservationDAO;
	}

	public TripBean getTripBean() {
		return tripBean;
	}

	public void setTripBean(TripBean tripBean) {
		this.tripBean = tripBean;
	}

    @SuppressWarnings("unchecked")
    @Action(results = { /*@Result(name = SUCCESS, type = "chain", params = {
        			"namespace", "/pay", "actionName", "pay01010" }),*/
            @Result(name = "double",type="chain",params = {
                    "namespace", "/booking", "actionName", "booking" }) })
    public String execute(){
		List<TripBean> list = (List<TripBean>)session.get("listTripBean");
		String reservationId = null;
		
		//Check user logged in and set user info  
		UserBean userBean = null;
		
		if(!(session.get(CommonConstant.SESSION_KEY_USER) == null)){
			User user = (User)session.get(CommonConstant.SESSION_KEY_USER);
			userBean = userDAO.getById(Integer.parseInt(user.getUserId()));
		}
		
		//Set tmp user info
		User tmp_user = new User("","","",inputFirstName,inputLastName,inputMobile,inputEmail);
		session.put("User_tmp", tmp_user);
		
		//Check double seat
		String[] tmp = selectedSeat.split(";");
		List<String> listSelectedSeat = new ArrayList<String>();  
		for (String string : tmp) {
			listSelectedSeat.add(string);
		}
		//put selected seat
        session.put("selectedSeats",selectedSeat);
		
		List<String> seatsDouble = seatPositionDAO.checkDoubleBooking(list, listSelectedSeat);
		
		if(seatsDouble.size() == 0){
		
			ReservationBean reservationBean = new ReservationBean();
			
			reservationBean.setBooker(userBean);
			reservationBean.setBookerFirstName(inputFirstName);
			reservationBean.setBookerLastName(inputLastName);
			reservationBean.setEmail(inputEmail); 
			reservationBean.setPhone(inputMobile);
			
			reservationBean.setBookTime(new Date());
			reservationBean.setCode(null);//String Code
			reservationBean.setPayments(null);//List<PaymentBean>
			reservationBean.setStatus("unpaid");
			
			List<TicketBean> listTicket = null;
			
			TicketBean ticketBean = new TicketBean();
			ticketBean.setReservation(reservationBean);
			ticketBean.setTrips(list);
			
			List<SeatPositionBean> listSeatPositionBean = null;
			
			for(int i = 0 ; i< tmp.length; i++){
				SeatPositionBean spb = new SeatPositionBean();
				spb.setName(tmp[i]);
				spb.setTicket(ticketBean);
				
				listSeatPositionBean.add(spb);
			}
			
			ticketBean.setSeatPositions(listSeatPositionBean);
			
			reservationBean.setTickets(listTicket);
			
			reservationId = Integer.toString((Integer) reservationDAO
	                .insert(reservationBean));
	 
			// moved below
//			session.remove("listTripBean");
//			session.remove("selectedSeats");
//			session.put(CommonConstant.SESSION_KEY_RESERVATION_ID, reservationId);
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
            session.put(CommonConstant.SESSION_KEY_RESERVATION_ID, reservationId);
            session.remove("listTripBean");
            session.remove("selectedSeats");
            session.remove("User_tmp");
			
			return SUCCESS;
		} else{
			//send selectedSeat and  double 
			request.put("backFrom","bookingPay");
			request.put("doubleSeat", seatsDouble);//List<String>
			//session.remove("listTripBean");
			return "double"; 
		}		
	}

	public SeatPositionDAO getSeatPositionDAO() {
		return seatPositionDAO;
	}

	public void setSeatPositionDAO(SeatPositionDAO seatPositionDAO) {
		this.seatPositionDAO = seatPositionDAO;
	}
	
}
