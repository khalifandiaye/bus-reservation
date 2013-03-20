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
    /* (non-Javadoc)
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result
                + ((busStatus == null) ? 0 : busStatus.hashCode());
        result = prime * result + ((endCity == null) ? 0 : endCity.hashCode());
        result = prime * result
                + ((startCity == null) ? 0 : startCity.hashCode());
        result = prime * result + ((trip == null) ? 0 : trip.hashCode());
        return result;
    }
    /* (non-Javadoc)
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        TripWithNumberOfRemainedSeatsInSubrouteKey other = (TripWithNumberOfRemainedSeatsInSubrouteKey) obj;
        if (busStatus == null) {
            if (other.busStatus != null)
                return false;
        } else if (!busStatus.equals(other.busStatus))
            return false;
        if (endCity == null) {
            if (other.endCity != null)
                return false;
        } else if (!endCity.equals(other.endCity))
            return false;
        if (startCity == null) {
            if (other.startCity != null)
                return false;
        } else if (!startCity.equals(other.startCity))
            return false;
        if (trip == null) {
            if (other.trip != null)
                return false;
        } else if (!trip.equals(other.trip))
            return false;
        return true;
    }
}
