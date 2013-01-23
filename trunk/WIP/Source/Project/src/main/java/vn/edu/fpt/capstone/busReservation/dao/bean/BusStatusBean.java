/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.Date;

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
	private String status;
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
}
