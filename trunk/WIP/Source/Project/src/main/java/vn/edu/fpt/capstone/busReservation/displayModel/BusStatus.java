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
    private final Date toDate;
    private final String endStation;
    private final String endLocation;

    /**
     * @param busId
     * @param busPlate
     * @param toDate
     * @param endStation
     * @param endLocation
     */
    public BusStatus(int busId, String busPlate, Date toDate,
            String endStation, String endLocation) {
        this.busId = busId;
        this.busPlate = busPlate;
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

    public String getDisplayStatus() {
        // TODO implement it
        return null;
    }

}
