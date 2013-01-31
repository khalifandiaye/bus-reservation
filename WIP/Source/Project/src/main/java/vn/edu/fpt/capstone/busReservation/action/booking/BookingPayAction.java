/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.booking;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import vn.edu.fpt.capstone.busReservation.dao.CustomerDAO;
import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.SeatPositionDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.CustomerBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionKey;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

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
	private CustomerDAO customerDAO = null;
	private SeatPositionDAO seatPositionDAO = null;
	private String selectedSeat;
	private String inputFirstName;
	private String inputLastName;
	private String inputPhone;
	private String inputMobile;
	private String inputEmail;
	private String inputCivilID;
	
	public String getSelectedSeat() {
		return selectedSeat;
	}

	public void setSelectedSeat(String selectedSeat) {
		this.selectedSeat = selectedSeat;
	}

	public void setCustomerDAO(CustomerDAO customerDAO) {
		this.customerDAO = customerDAO;
	}
	
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

	public String getInputPhone() {
		return inputPhone;
	}

	public void setInputPhone(String inputPhone) {
		this.inputPhone = inputPhone;
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

	public String getInputCivilID() {
		return inputCivilID;
	}

	public void setInputCivilID(String inputCivilID) {
		this.inputCivilID = inputCivilID;
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

	public String execute(){
		List<TripBean> list = (List<TripBean>)session.get("listTripBean");
		
		CustomerBean customerBean = new CustomerBean();
		customerBean.setCivilId(inputCivilID);
		customerBean.setEmail(inputEmail);
		customerBean.setFirstName(inputFirstName);
		customerBean.setLastName(inputLastName);
		customerBean.setMobileNumber(inputMobile);
		customerBean.setPhoneNumber(inputPhone);
		customerBean.setUsername("");
		customerBean.setPassword("");
		customerBean.setStatus("active");
		
		customerDAO.save(customerBean);
		
		ReservationBean reservationBean = new ReservationBean();
		reservationBean.setBooker(customerBean);//CustomerBean
		reservationBean.setBookTime(new Date());
		reservationBean.setCode(null);//String Code
		reservationBean.setPayments(null);//List<PaymentBean>
		reservationBean.setSeatPositions(null);//List<seatPosition>
		reservationBean.setStatus("available");
		reservationBean.setTrips(list);//List<tripBean>
		
		reservationDAO.save(reservationBean);
		
		List<SeatPositionBean> listSeats = new ArrayList<SeatPositionBean>();
		String[] tmp = selectedSeat.split(";");
		for(int i =0 ; i< tmp.length; i++){
			SeatPositionKey key = new SeatPositionKey();
			key.setName(tmp[i]);
			key.setReservation(reservationBean);
			
			SeatPositionBean spb = new SeatPositionBean();
			spb.setId(key);
			spb.setName(tmp[i]);
			spb.setReservation(reservationBean);
			
			seatPositionDAO.save(spb);
			
			listSeats.add(spb);
		}
		
		reservationBean.setSeatPositions(listSeats);
		reservationDAO.save(reservationBean);
		
		session.remove("listTripBean");
		
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
