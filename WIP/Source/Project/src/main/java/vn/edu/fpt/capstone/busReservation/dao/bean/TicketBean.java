package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.io.Serializable;
import java.security.InvalidParameterException;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;

public class TicketBean extends AbstractBean<Integer> {
    public static final class TicketStatus implements Serializable {
        /**
         * serialVersionUID
         */
        private static final long serialVersionUID = 1L;
        /**
         * The ticket is in effect.
         */
        public static final TicketStatus ACTIVE = new TicketStatus("active");
        /**
         * The ticket can no longer be cancelled
         */
        public static final TicketStatus PENDING = new TicketStatus("pending");
        /**
         * The first trip has departed
         */
        public static final TicketStatus DEPARTED = new TicketStatus("departed");
        /**
         * The ticket has been cancelled due to the trip being cancelled.<br>
         * Awaiting refund or changing trip.
         */
        public static final TicketStatus CANCELLED = new TicketStatus(
                "cancelled");
        /**
         * The ticket has been moved to another trip
         */
        public static final TicketStatus MOVED = new TicketStatus("moved");
        /**
         * The ticket was cancelled, and refund is completed.
         */
        public static final TicketStatus REFUNDED = new TicketStatus("refunded");
        /**
         * The ticket was cancelled, and refund is completed.
         */
        public static final TicketStatus REFUNDED2 = new TicketStatus("refunded2");
        private final String value;

        /**
         * @param value
         */
        private TicketStatus(String value) {
            this.value = value;
        }

        public static final TicketStatus fromValue(final String value) {
            if (value == null) {
                return null;
            } else if (ACTIVE.value.equalsIgnoreCase(value)) {
                return ACTIVE;
            } else if (PENDING.value.equalsIgnoreCase(value)) {
                return PENDING;
            } else if (DEPARTED.value.equalsIgnoreCase(value)) {
                return DEPARTED;
            } else if (CANCELLED.value.equalsIgnoreCase(value)) {
                return CANCELLED;
            } else if (MOVED.value.equalsIgnoreCase(value)) {
                return MOVED;
            } else if (REFUNDED.value.equalsIgnoreCase(value)) {
                return REFUNDED;
            } else if (REFUNDED2.value.equalsIgnoreCase(value)) {
                return REFUNDED2;
            } else {
                throw new InvalidParameterException("Can not instantiate new "
                        + ReservationStatus.class.getName()
                        + " from the value \"" + value + "\"");
            }
        }

        /**
         * @return the value
         */
        public String getValue() {
            return value;
        }
    }

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private ReservationBean reservation;
    private TicketStatus status;
    private List<TripBean> trips;
    private List<SeatPositionBean> seatPositions;

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
        this.status = TicketStatus.fromValue(status);
    }

    /**
     * @return the trips
     */
    public List<TripBean> getTrips() {
        return trips;
    }

    /**
     * @param trips
     *            the trips to set
     */
    public void setTrips(List<TripBean> trips) {
        this.trips = trips;
    }

    /**
     * @return the seatPositions
     */
    public List<SeatPositionBean> getSeatPositions() {
        return seatPositions;
    }

    /**
     * @param seatPositions
     *            the seatPositions to set
     */
    public void setSeatPositions(List<SeatPositionBean> seatPositions) {
        this.seatPositions = seatPositions;
    }
}
