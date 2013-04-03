/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.booking;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

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
import vn.edu.fpt.capstone.busReservation.displayModel.PaymentSetupDetails;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.SearchParamsInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
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

    // =========================Action Input===========================
    private Integer paymentMethodId;

    /**
     * @param paymentMethodId
     *            the paymentMethodId to set
     */
    public void setPaymentMethodId(Integer paymentMethodId) {
        this.paymentMethodId = paymentMethodId;
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
	private String selectedOutSeat;
	private String selectedReturnSeat;

	/**
	 * @param selectedOutSeat the selectedOutSeat to set
	 */
	public void setSelectedOutSeat(String selectedOutSeat) {
		this.selectedOutSeat = selectedOutSeat;
	}

	/**
	 * @param selectedReturnSeat the selectedReturnSeat to set
	 */
	public void setSelectedReturnSeat(String selectedReturnSeat) {
		this.selectedReturnSeat = selectedReturnSeat;
	}

	/**
	 * @param userDAO
	 *            the userDAO to set
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
	@Action(results = { /*
						 * @Result(name = SUCCESS, type = "chain", params = {
						 * "namespace", "/pay", "actionName", "pay01010" }),
						 */
	@Result(name = "double", type = "redirectAction", params = { "namespace",
			"/booking", "actionName", "booking" }),
	@Result(name = "full", type = "redirectAction", params = { "namespace",
			"/search", "actionName", "search-result"})
	})
	public String execute() {
		if(!session.containsKey("listOutTripBean") && !session.containsKey("listReturnTripBean")){
			return ERROR;
		}
		List<TripBean> listOutTripBean = null;
		List<TripBean> listReturnTripBean = null;
		int reservationId;
		UserBean userBean = null;
		String[] tmpOut = null;
		String[] tmpReturn = null;
		List<String> listOutSeat = new ArrayList<String>();
		List<String> listReturnSeat = new ArrayList<String>();
		List<String> seatsOutDouble = null;
		List<String> seatsReturnDouble = null;
		
		if (!(session.get(CommonConstant.SESSION_KEY_USER) == null)) {
			User user = (User) session.get(CommonConstant.SESSION_KEY_USER);
			userBean = userDAO.getById(user.getUserId());
		}
		// Set tmp user info
		User tmp_user = new User(1, "", 1, inputFirstName, inputLastName,
				inputMobile, inputEmail);
		session.put("User_tmp", tmp_user);
		
		if(session.containsKey("listOutTripBean")){
			listOutTripBean = (List<TripBean>) session.get("listOutTripBean");
			if(selectedOutSeat!=""){
				tmpOut = selectedOutSeat.split(";");
				for (String string : tmpOut) {
					listOutSeat.add(string);
				}
			}
		}
		if(session.containsKey("listReturnTripBean")){
			listReturnTripBean = (List<TripBean>) session.get("listReturnTripBean");
			if(selectedReturnSeat!=""){
				tmpReturn = selectedReturnSeat.split(";");
				for (String string : tmpReturn) {
					listReturnSeat.add(string);
				}
			}
		}
		
		// put selected seat
		session.put("selectedOutSeat", selectedOutSeat);
		session.put("selectedReturnSeat", selectedReturnSeat);
		
		ReservationBean reservationBean = new ReservationBean();

		reservationBean.setBooker(userBean);
		reservationBean.setBookerFirstName(inputFirstName);
		reservationBean.setBookerLastName(inputLastName);
		reservationBean.setEmail(inputEmail);
		reservationBean.setPhone(inputMobile);

		reservationBean.setBookTime(new Date());
//		reservationBean.setCode(null);// String Code
//		reservationBean.setPayments(null);// List<PaymentBean>
		reservationBean.setStatus("unpaid");

		List<TicketBean> listTicket = new ArrayList<TicketBean>();
		
		if(listOutTripBean != null && tmpOut.length>0){
			TicketBean ticketBean = creatTicket(reservationBean, listOutTripBean, tmpOut);
			listTicket.add(ticketBean);
			seatsOutDouble = seatPositionDAO.checkDoubleBooking(listOutTripBean,
				listOutSeat);
		
		}
		if(listReturnTripBean != null && tmpReturn.length > 0){
			TicketBean ticketBean = creatTicket(reservationBean, listReturnTripBean, tmpReturn);
			listTicket.add(ticketBean);
			seatsReturnDouble = seatPositionDAO.checkDoubleBooking(listReturnTripBean,
				listReturnSeat);
		}
		reservationBean.setTickets(listTicket);

		if (seatsOutDouble == null && seatsReturnDouble == null) {

            reservationId = (Integer) reservationDAO.insert(reservationBean);

            reservationDAO.endTransaction();

            ReservationInfo reservationInfo = null;
            PaymentSetupDetails setupDetails = null;

            reservationInfo = (ReservationInfo) session
                    .get(ReservationInfo.class.getName());
            reservationInfo.setId(reservationId);
            try {
                setupDetails = paymentLogic.setupPayment(reservationInfo,
                        paymentMethodId, servletRequest.getContextPath());
            } catch (CommonException e) {
                errorProcessing(e);
                return ERROR;
            }
            redirectUrl = setupDetails.getRedirectUrl();
            if (!CheckUtils.isNullOrBlank(setupDetails.getPaymentToken())) {
                session.put(CommonConstant.SESSION_KEY_PAYMENT_TOKEN,
                        setupDetails.getPaymentToken());
            }
            session.put(CommonConstant.SESSION_KEY_PAYMENT_METHOD_ID,
                    paymentMethodId);
			
			session.remove("listOutTripBean");
			session.remove("listReturnTripBean");
			session.remove("selectedOutSeat");
			session.remove("selectedReturnSeat");
			session.remove("passengerNo");
			session.remove("User_tmp");

			return SUCCESS;
		} else {
			//check full seats
			int numSelectSeatOut = tmpOut.length;
			int isFullOut = 0;
			int isFullReturn = 0;
			if(listOutTripBean != null){
				List<String> soldSeatOut = seatPositionDAO.getSoldSeats(listOutTripBean);
				int numBusSeatOut = listOutTripBean.get(0).getBusStatus().getBus().getBusType().getNumberOfSeats();
				isFullOut = numBusSeatOut - soldSeatOut.size();
			}
			if(listReturnTripBean != null){
				List<String> soldSeatReturn = seatPositionDAO.getSoldSeats(listReturnTripBean);
				int numBusSeatReturn = listReturnTripBean.get(0).getBusStatus().getBus().getBusType().getNumberOfSeats();
				isFullReturn = numBusSeatReturn - soldSeatReturn.size();
			}
			if((listOutTripBean != null && isFullOut == 0) || (isFullReturn == 0 && listReturnTripBean != null)){
				
				SimpleDateFormat fromFormat = new SimpleDateFormat("dd-MM-yyyy", Locale.US);
				SearchParamsInfo searchParams = new SearchParamsInfo();
				searchParams.setDepartureCity(listOutTripBean.get(0).getRouteDetails().getSegment().getStartAt().getCity().getId());
				searchParams.setArrivalCity(listOutTripBean.get(listOutTripBean.size()-1).getRouteDetails().getSegment().getEndAt().getCity().getId());
				searchParams.setDepartureDate(fromFormat.format(listOutTripBean.get(0).getDepartureTime()));
				searchParams.setReturnDate(fromFormat.format(listOutTripBean.get(0).getArrivalTime()));
				searchParams.setBusType(listOutTripBean.get(0).getBusStatus().getBus().getBusType().getId());
				searchParams.setPassengerNo(numSelectSeatOut);
				if(listOutTripBean != null || listReturnTripBean !=null){
					if(listOutTripBean != null && listReturnTripBean != null){
						searchParams.setTicketType("roundtrip");
					}else{
						searchParams.setTicketType("oneway");
					}
				}
				
				session.put("searchAnother", searchParams);
				session.put("message", getText("msg_booking003"));
				
				session.remove("listOutTripBean");
				session.remove("listReturnTripBean");
				session.remove("selectedOutSeat");
				session.remove("selectedReturnSeat");
				return "full";
			}
			if((isFullOut > 0 && isFullOut < numSelectSeatOut) || (isFullReturn > 0 && isFullReturn < numSelectSeatOut))
			{
				session.put("message", getText("msg_booking001"));
			}else{
				session.put("message", getText("msg_booking002"));
			}
			
			if(seatsOutDouble != null){
				session.put("seatsOutDouble", seatsOutDouble);
			}
			if(seatsReturnDouble != null){
				session.put("seatsReturnDouble", seatsReturnDouble);
			}
			//session to knows redirect form booking pay
			session.put("redirectFrom", "bookingPay");
			return "double";
		}
	}

	public SeatPositionDAO getSeatPositionDAO() {
		return seatPositionDAO;
	}

	public void setSeatPositionDAO(SeatPositionDAO seatPositionDAO) {
		this.seatPositionDAO = seatPositionDAO;
	}

	public TicketBean creatTicket(ReservationBean reservationBean,List<TripBean> list,String[] tmp){
		TicketBean ticketBean = new TicketBean();
		ticketBean.setReservation(reservationBean);
		ticketBean.setTrips(list);

		List<SeatPositionBean> listSeatPositionBean = new ArrayList<SeatPositionBean>();

		for (int i = 0; i < tmp.length; i++) {
			SeatPositionBean spb = new SeatPositionBean();
			spb.setName(tmp[i]);
			spb.setTicket(ticketBean);
			listSeatPositionBean.add(spb);
		}

		ticketBean.setSeatPositions(listSeatPositionBean);
		return ticketBean;
	}
}
