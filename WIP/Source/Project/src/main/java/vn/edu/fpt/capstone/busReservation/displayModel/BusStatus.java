/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.util.Date;

import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.DateUtils;

/**
 * @author Yoshimi
 * 
 */
public final class BusStatus implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private final int busId;
    private final String busPlate;
    private final boolean assigned;
    private final String busStatus;
    private final Date toDate;
    private final String endStation;
    private final String endLocation;
    private final String status;

    public BusStatus(Integer busId, String busPlate, String status,
            Integer forwardRouteId, Integer returnRouteId, String busStatus,
            Date toDate, String endStation, String endLocation) {
        this.busId = busId;
        this.busPlate = busPlate;
        this.status = status;
        if (forwardRouteId != null && returnRouteId != null) {
            assigned = true;
        } else {
            assigned = false;
        }
        this.busStatus = busStatus;
        this.toDate = toDate;
        this.endStation = endStation;
        this.endLocation = endLocation;
    }

    /**
     * @return the busId
     */
    public int getBusId() {
        return busId;
    }

    /**
     * @return the busPlate
     */
    public String getBusPlate() {
        return busPlate;
    }

    /**
     * @return the assigned
     */
    public boolean isAssigned() {
        return assigned;
    }

    /**
     * @return the busStatus
     */
    public String getBusStatus() {
        return busStatus;
    }

    /**
     * @return the toDate
     */
    public Date getToDate() {
        return new Date(toDate.getTime());
    }

    /**
     * @return the toDate
     */
    public String getToDateString() {
        return DateUtils.date2String(getToDate(),
                CommonConstant.PATTERN_DATE_TIME_LONG,
                CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE);
    }

    /**
     * @return the endStation
     */
    public String getEndStation() {
        return endStation;
    }

    /**
     * @return the endLocation
     */
    public String getEndLocation() {
        return endLocation;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    public String getDisplayStatus() {
    	if(!this.isAssigned()){
    		return "UnAssigned";
    	}else{
    		if(this.getEndLocation() == ""){
    			return "UnSchedule";
    		}else{
    			Date now = new Date();
    			if(this.getToDate().getTime() <= now.getTime()){
//    				if(!last){
    					return "Current Location : "+ this.getEndLocation();
//    				}else{
//    					return "Last Location : " + this.getEndLocation();
//    				}
    			}else{
					return "Running to :" + this.getEndLocation();
    			}
    		}
    	}
    }

}
