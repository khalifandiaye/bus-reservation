/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

/**
 * @author Yoshimi
 *
 */
public class SeatPositionBean extends AbstractBean<SeatPositionKey> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6583091312608772197L;
	/**
	 * @return the name
	 */
	public String getName() {
		return getId().getName();
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.getId().setName(name);
	}
	/**
	 * @return the reservation
	 */
	public ReservationBean getReservation() {
		return getId().getReservation();
	}
	/**
	 * @param reservation the reservation to set
	 */
	public void setReservation(ReservationBean reservation) {
		this.getId().setReservation(reservation);
	}
}
