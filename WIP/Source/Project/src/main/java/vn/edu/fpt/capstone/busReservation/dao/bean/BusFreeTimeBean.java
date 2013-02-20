package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.Date;

public class BusFreeTimeBean extends AbstractBean<BusStatusBean> {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private BusBean bus;
    private Date fromDate;
    private Date toDate;
    private StationBean station;
    /**
     * @return the bus
     */
    public BusBean getBus() {
        return bus;
    }
    /**
     * @param bus the bus to set
     */
    public void setBus(BusBean bus) {
        this.bus = bus;
    }
    /**
     * @return the fromDate
     */
    public Date getFromDate() {
        return fromDate;
    }
    /**
     * @param fromDate the fromDate to set
     */
    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }
    /**
     * @return the toDate
     */
    public Date getToDate() {
        return toDate;
    }
    /**
     * @param toDate the toDate to set
     */
    public void setToDate(Date toDate) {
        this.toDate = toDate;
    }
    /**
     * @return the station
     */
    public StationBean getStation() {
        return station;
    }
    /**
     * @param station the station to set
     */
    public void setStation(StationBean station) {
        this.station = station;
    }
}
