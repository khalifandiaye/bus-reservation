/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.Date;

/**
 * @author Yoshimi
 *
 */
public class TripWithNumberOfRemainedSeatsInSubrouteBean extends
        AbstractBean<TripWithNumberOfRemainedSeatsInSubrouteKey> {

    /**
     * 
     */
    private static final long serialVersionUID = 7052956995361953538L;
    private Date departureTime;
    private Date arrivalTime;
    private int numberOfRemainedSeats;
    /**
     * @return the trip
     */
    public TripBean getTrip() {
        return getId() != null ? getId().getTrip() : null;
    }
    /**
     * @param trip the trip to set
     */
    public void setTrip(TripBean trip) {
        if (getId() == null) {
            setId(new TripWithNumberOfRemainedSeatsInSubrouteKey());
        }
        getId().setTrip(trip);
    }
    /**
     * @return the busStatus
     */
    public BusStatusBean getBusStatus() {
        return getId() != null ? getId().getBusStatus() : null;
    }
    /**
     * @param busStatus the busStatus to set
     */
    public void setBusStatus(BusStatusBean busStatus) {
        if (getId() == null) {
            setId(new TripWithNumberOfRemainedSeatsInSubrouteKey());
        }
        getId().setBusStatus(busStatus);
    }
    /**
     * @return the startCity
     */
    public CityBean getStartCity() {
        return getId() != null ? getId().getStartCity() : null;
    }
    /**
     * @param startCity the startCity to set
     */
    public void setStartCity(CityBean startCity) {
        if (getId() == null) {
            setId(new TripWithNumberOfRemainedSeatsInSubrouteKey());
        }
        getId().setStartCity(startCity);
    }
    /**
     * @return the departureTime
     */
    public Date getDepartureTime() {
        return departureTime;
    }
    /**
     * @param departureTime the departureTime to set
     */
    public void setDepartureTime(Date departureTime) {
        this.departureTime = departureTime;
    }
    /**
     * @return the endCity
     */
    public CityBean getEndCity() {
        return getId() != null ? getId().getEndCity() : null;
    }
    /**
     * @param endCity the endCity to set
     */
    public void setEndCity(CityBean endCity) {
        if (getId() == null) {
            setId(new TripWithNumberOfRemainedSeatsInSubrouteKey());
        }
        getId().setEndCity(endCity);
    }
    /**
     * @return the arrivalTime
     */
    public Date getArrivalTime() {
        return arrivalTime;
    }
    /**
     * @param arrivalTime the arrivalTime to set
     */
    public void setArrivalTime(Date arrivalTime) {
        this.arrivalTime = arrivalTime;
    }
    /**
     * @return the numberOfRemainedSeats
     */
    public int getNumberOfRemainedSeats() {
        return numberOfRemainedSeats;
    }
    /**
     * @param numberOfRemainedSeats the numberOfRemainedSeats to set
     */
    public void setNumberOfRemainedSeats(int numberOfRemainedSeats) {
        this.numberOfRemainedSeats = numberOfRemainedSeats;
    }
}
