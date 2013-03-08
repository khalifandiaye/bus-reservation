/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.io.Serializable;
import java.security.InvalidParameterException;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;

/**
 * @author Yoshimi
 *
 */
public class SeatPositionBean extends AbstractBean<SeatPositionKey> {
    public static final class SeatPositionStatus implements Serializable {
        /**
         * serialVersionUID
         */
        private static final long serialVersionUID = 1L;
        /**
         * The ticket is in effect.
         */
        public static final SeatPositionStatus ACTIVE = new SeatPositionStatus("active");
        /**
         * The ticket has been cancelled due to the trip being cancelled.<br>
         * Awaiting refund or changing trip.
         */
        public static final SeatPositionStatus CANCELLED = new SeatPositionStatus(
                "cancelled");
        /**
         * The seat has been moved to another seat
         */
        public static final SeatPositionStatus MOVED = new SeatPositionStatus("moved");
        /**
         * The ticket was cancelled, and refund is completed.
         */
        public static final SeatPositionStatus REFUNDED = new SeatPositionStatus("refunded");
        private final String value;

        /**
         * @param value
         */
        private SeatPositionStatus(String value) {
            this.value = value;
        }

        public static final SeatPositionStatus fromValue(final String value) {
            if (value == null) {
                return null;
            } else if (ACTIVE.value.equalsIgnoreCase(value)) {
                return ACTIVE;
            } else if (CANCELLED.value.equalsIgnoreCase(value)) {
                return CANCELLED;
            } else if (MOVED.value.equalsIgnoreCase(value)) {
                return MOVED;
            } else if (REFUNDED.value.equalsIgnoreCase(value)) {
                return REFUNDED;
            } else {
                throw new InvalidParameterException("Can not instantiate new "
                        + ReservationStatus.class.getName()
                        + " from the value \"" + value + "\"");
            }
        }
    }
	/**
	 * 
	 */
	private static final long serialVersionUID = 6583091312608772197L;
	private SeatPositionStatus status;
	public SeatPositionBean() {
		setId(new SeatPositionKey());
	}
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
	public TicketBean getTicket() {
		return getId().getTicket();
	}
	/**
	 * @param reservation the reservation to set
	 */
	public void setTicket(TicketBean ticket) {
		this.getId().setTicket(ticket);
	}

    /**
     * @return the status
     */
    public String getStatus() {
        return status != null ? status.value : null;
    }

    /**
     * @param status
     *            the status to set
     */
    public void setStatus(String status) {
        this.status = SeatPositionStatus.fromValue(status);
    }
}
