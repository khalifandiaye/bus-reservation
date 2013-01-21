/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author Yoshimi
 * 
 */
public class TestPayAction extends ActionSupport implements SessionAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5713118155580163291L;

	private Map<String, Object> session;

	private ReservationInfo reservationInfo;

	/**
	 * @return the reservationInfo
	 */
	public ReservationInfo getReservationInfo() {
		return reservationInfo;
	}

	public String execute() {
		reservationInfo = new ReservationInfo();
		reservationInfo.setRouteName("Ha Noi - TP. Ho Chi Minh");
		reservationInfo.setSubRouteName("Quang Ngai - Nha Trang");
		reservationInfo.setDepartureDate("T5 31/1/2013 9:00 SA");
		reservationInfo.setArrivalDate("T5 31/1/2013 7:00 CH");
		reservationInfo.setSeatNumbers("A1, A2, B1, B2");
		reservationInfo.setQuantity("7");
		reservationInfo.setAmount("4.3");
		reservationInfo.setCurrency("USD");
		session.put("reservationInfo", reservationInfo);
		return SUCCESS;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
