/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.booking;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.interceptor.SessionAware;

import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.SeatPositionDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionKey;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author NoName
 *
 */
public class BookingPayAction extends ActionSupport implements SessionAware {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5962554617409673584L;
	
	
	Map<String,Object> session = null;
	private TripBean tripBean;
	private ReservationDAO reservationDAO = null;
	private SeatPositionDAO seatPositionDAO = null;
	private String inputFirstName;
	private String inputLastName;
	private String inputMobile;
	private String inputEmail;

	public String getInputFirstName() {
		return inputFirstName;
	}

	public void setInputFirstName(String inputFirstName) {
		this.inputFirstName = inputFirstName;
	}

	public String getInputLastName() {
		return inputLastName;
	}

	public void setInputLastName(String inputLastName) {
		this.inputLastName = inputLastName;
	}

	public String getInputMobile() {
		return inputMobile;
	}

	public void setInputMobile(String inputMobile) {
		this.inputMobile = inputMobile;
	}

	public String getInputEmail() {
		return inputEmail;
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
    @Action(results = { @Result(name = SUCCESS, type = "chain", params = {
            "namespace", "/pay", "actionName", "pay01010" }) })
    public String execute(){
		List<TripBean> list = (List<TripBean>)session.get("listTripBean");
		String reservationId = null;
		
		UserBean userBean;
		if(!(session.get("User") == null)){
			userBean = (UserBean)session.get("User");
			this.inputFirstName = userBean.getFirstName();
			this.inputLastName = userBean.getLastName();
			this.inputEmail = userBean.getEmail();
			this.inputMobile = userBean.getMobileNumber();
		}else{
			userBean = null;
		}
		
		ReservationBean reservationBean = new ReservationBean();
		reservationBean.setBooker(userBean);
		reservationBean.setBookerFirstName(inputFirstName);
		reservationBean.setBookerLastName(inputLastName);
		reservationBean.setEmail(inputEmail);
		reservationBean.setPhone(inputMobile);
		
		reservationBean.setBookTime(new Date());
		reservationBean.setCode(null);//String Code
		reservationBean.setPayments(null);//List<PaymentBean>
		reservationBean.setSeatPositions(null);//List<seatPosition>
		reservationBean.setStatus("unpaid");
		reservationBean.setTrips(list);//List<tripBean>
		
        reservationId = Integer.toString((Integer) reservationDAO
                .insert(reservationBean));
		
		String[] tmp = ((String)session.get("selectedSeats")).split(";");
		for(int i =0 ; i< tmp.length; i++){
			SeatPositionBean spb = new SeatPositionBean();
			spb.setName(tmp[i]);
			spb.setReservation(reservationBean);
			
			seatPositionDAO.insert(spb);	
		}
		session.remove("listTripBean");
		session.remove("selectedSeats");
		session.put(CommonConstant.SESSION_KEY_RESERVATION_ID, reservationId);
		
		return SUCCESS;
	}

	@Override
	public void setSession(Map<String, Object> map) {
		this.session = map;
	}

	public SeatPositionDAO getSeatPositionDAO() {
		return seatPositionDAO;
	}

	public void setSeatPositionDAO(SeatPositionDAO seatPositionDAO) {
		this.seatPositionDAO = seatPositionDAO;
	}
}
