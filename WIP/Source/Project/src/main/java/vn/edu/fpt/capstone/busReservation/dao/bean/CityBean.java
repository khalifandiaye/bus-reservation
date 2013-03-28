/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.List;

/**
 * @author Yoshimi
 *
 */
public class CityBean extends AbstractBean<Integer> {
    /**
     * 
     */
    private static final long serialVersionUID = 3460926919404121200L;
    private String name;
    private Double latitude;
    private Double longitude;
    private List<StationBean> stations;
    
	/**
     * @return the name
     */
    public String getName() {
        return name;
    }
    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }
    /**
     * @return the latitude
     */
    public Double getLatitude() {
        return latitude;
    }
    /**
     * @param latitude the latitude to set
     */
    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }
    /**
     * @return the longitude
     */
    public Double getLongitude() {
        return longitude;
    }
    /**
     * @param longitude the longitude to set
     */
    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }
    /**
     * @return the stations
     */
    public List<StationBean> getStations() {
        return stations;
    }
    /**
     * @param stations the stations to set
     */
    public void setStations(List<StationBean> stations) {
        this.stations = stations;
    }

}
