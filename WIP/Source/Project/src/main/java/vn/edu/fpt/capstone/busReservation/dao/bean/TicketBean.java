package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.List;

public class TicketBean extends AbstractBean<Integer> {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private ReservationBean reservation;
    private List<TripBean> trips;
    private List<SeatPositionBean> seatPositions;

    /**
     * @return the reservation
     */
    public ReservationBean getReservation() {
        return reservation;
    }

    /**
     * @param reservation the reservation to set
     */
    public void setReservation(ReservationBean reservation) {
        this.reservation = reservation;
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
}
