/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.io.Serializable;


/**
 * @author Yoshimi
 * 
 */
public class SeatPositionKey implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3947765243302644340L;
	private String name;
	private ReservationBean reservation;

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the reservation
	 */
	public ReservationBean getReservation() {
		return reservation;
	}

	/**
	 * @param reservation
	 *            the reservation to set
	 */
	public void setReservation(ReservationBean reservation) {
		this.reservation = reservation;
	}

	@Override
	public boolean equals(Object arg0) {
		if (arg0 == null || !this.getClass().isAssignableFrom(arg0.getClass())) {
			return false;
		} else {
			SeatPositionKey key = (SeatPositionKey) arg0;
			if (this.name == null && this.reservation == null) {
				return key.name == null && key.reservation == null;
			} else if (this.name == null && key.name == null) {
				return key.name == null
						&& this.reservation.equals(key.reservation);
			} else if (this.reservation == null) {
				return this.name.equals(key.name) && key.reservation == null;
			} else {
				return this.name.equals(key.name)
						&& this.reservation.equals(key.reservation);
			}
		}
	}

	@Override
    public int hashCode() {
        int hash = 5;
        hash = 89 * hash + (this.name != null ? this.name.hashCode() : 0);
        hash = 89 * hash + (this.reservation != null ? this.reservation.hashCode() : 0);
        return hash;
    }
}
