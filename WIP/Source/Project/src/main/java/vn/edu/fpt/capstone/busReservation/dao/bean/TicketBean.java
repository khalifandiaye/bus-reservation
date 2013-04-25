package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.List;

public class TicketBean extends AbstractBean<Integer> {
    public static enum TicketStatus {
        /**
         * The ticket is in effect.
         */
        ACTIVE("active"),
        /**
         * The ticket can no longer be cancelled
         */
        PENDING("pending"),
        /**
         * The first trip has departed
         */
        DEPARTED("departed"),
        /**
         * The ticket has been cancelled due to the trip being cancelled.<br>
         * Awaiting refund or changing trip.
         */
        CANCELLED("cancelled"),
        /**
         * The ticket has been moved to another trip
         */
        MOVED("moved"),
        /**
         * The ticket was cancelled, and refund is completed.
         */
        REFUNDED("refunded"),
        /**
         * The ticket was cancelled, and refund is completed.
         */
        REFUNDED2("refunded2");
        private final String value;

        /**
         * @param value
         */
        private TicketStatus(String value) {
            this.value = value;
        }

        public static final TicketStatus fromValue(final String value) {
            for (TicketStatus c : values()) {
                if (c.value.equals(value)) {
                    return c;
                }
            }
            throw new IllegalArgumentException(value);
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
    private List<PaymentBean> payments;

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
        this.status = status != null ? TicketStatus.fromValue(status) : null;
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

    /**
     * @return the payments
     */
    public List<PaymentBean> getPayments() {
        return payments;
    }

    /**
     * @param payments
     *            the payments to set
     */
    public void setPayments(List<PaymentBean> payments) {
        this.payments = payments;
    }
}
