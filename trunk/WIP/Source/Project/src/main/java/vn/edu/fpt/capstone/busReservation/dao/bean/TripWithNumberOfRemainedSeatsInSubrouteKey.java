/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.io.Serializable;

/**
 * @author Yoshimi
 *
 */
public class TripWithNumberOfRemainedSeatsInSubrouteKey implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = -205826065262139522L;
    private TripBean trip;
    private BusStatusBean busStatus;
    private CityBean startCity;
    private CityBean endCity;
    /**
     * @return the trip
     */
    public TripBean getTrip() {
        return trip;
    }
    /**
     * @param trip the trip to set
     */
    public void setTrip(TripBean trip) {
        this.trip = trip;
    }
    /**
     * @return the busStatus
     */
    public BusStatusBean getBusStatus() {
        return busStatus;
    }
    /**
     * @param busStatus the busStatus to set
     */
    public void setBusStatus(BusStatusBean busStatus) {
        this.busStatus = busStatus;
    }
    /**
     * @return the startCity
     */
    public CityBean getStartCity() {
        return startCity;
    }
    /**
     * @param startCity the startCity to set
     */
    public void setStartCity(CityBean startCity) {
        this.startCity = startCity;
    }
    /**
     * @return the endCity
     */
    public CityBean getEndCity() {
        return endCity;
    }
    /**
     * @param endCity the endCity to set
     */
    public void setEndCity(CityBean endCity) {
        this.endCity = endCity;
    }
}
