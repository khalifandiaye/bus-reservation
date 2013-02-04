/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.Date;
import java.util.List;

/**
 * @author Yoshimi
 *
 */
public class ReservationBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8741646328583374172L;
	private UserBean booker;
	private String code;
	private Date bookTime;
	private String status;
	private String bookerFirstName;
	private String bookerLastName;
	private String phone;
	private String email;
	private List<SeatPositionBean> seatPositions;
	private List<TripBean> trips;
	private List<PaymentBean> payments;
	/**
	 * @return the booker
	 */
	public UserBean getBooker() {
	    return booker;
	}
	/**
	 * @param booker the booker to set
	 */
	public void setBooker(UserBean booker) {
	    this.booker = booker;
	}
	/**
	 * @return the code
	 */
	public String getCode() {
	    return code;
	}
	/**
	 * @param code the code to set
	 */
	public void setCode(String code) {
	    this.code = code;
	}
	/**
	 * @return the bookTime
	 */
	public Date getBookTime() {
	    return bookTime;
	}
	/**
	 * @param bookTime the bookTime to set
	 */
	public void setBookTime(Date bookTime) {
	    this.bookTime = bookTime;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
	    return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
	    this.status = status;
	}
	/**
	 * @return the bookerFirstName
	 */
	public String getBookerFirstName() {
	    return bookerFirstName;
	}
	/**
	 * @param bookerFirstName the bookerFirstName to set
	 */
	public void setBookerFirstName(String bookerFirstName) {
	    this.bookerFirstName = bookerFirstName;
	}
	/**
	 * @return the bookerLastName
	 */
	public String getBookerLastName() {
	    return bookerLastName;
	}
	/**
	 * @param bookerLastName the bookerLastName to set
	 */
	public void setBookerLastName(String bookerLastName) {
	    this.bookerLastName = bookerLastName;
	}
	/**
	 * @return the phone
	 */
	public String getPhone() {
	    return phone;
	}
	/**
	 * @param phone the phone to set
	 */
	public void setPhone(String phone) {
	    this.phone = phone;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
	    return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
	    this.email = email;
	}
	/**
	 * @return the seatPositions
	 */
	public List<SeatPositionBean> getSeatPositions() {
	    return seatPositions;
	}
	/**
	 * @param seatPositions the seatPositions to set
	 */
	public void setSeatPositions(List<SeatPositionBean> seatPositions) {
	    this.seatPositions = seatPositions;
	}
	/**
	 * @return the trips
	 */
	public List<TripBean> getTrips() {
	    return trips;
	}
	/**
	 * @param trips the trips to set
	 */
	public void setTrips(List<TripBean> trips) {
	    this.trips = trips;
	}
	/**
	 * @return the payments
	 */
	public List<PaymentBean> getPayments() {
	    return payments;
	}
	/**
	 * @param payments the payments to set
	 */
	public void setPayments(List<PaymentBean> payments) {
	    this.payments = payments;
	}
}
