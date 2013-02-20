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
