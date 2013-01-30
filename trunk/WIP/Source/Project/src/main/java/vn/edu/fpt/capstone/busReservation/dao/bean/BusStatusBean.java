/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.Date;
import java.util.List;

/**
 * @author Yoshimi
 *
 */
public class BusStatusBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5390911848677888911L;
	private BusBean bus;
	private String busStatus;
	private Date fromDate;
	private Date toDate;
	private List<TripBean> trips;
	private String status;
	private EmployeeBean scheduler;
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
	 * @return the busStatus
	 */
	public String getBusStatus() {
		return busStatus;
	}
	/**
	 * @param busStatus the busStatus to set
	 */
	public void setBusStatus(String busStatus) {
		this.busStatus = busStatus;
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
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @return the scheduler
	 */
	public EmployeeBean getScheduler() {
		return scheduler;
	}
	/**
	 * @param scheduler the scheduler to set
	 */
	public void setScheduler(EmployeeBean scheduler) {
		this.scheduler = scheduler;
	}
}
