/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.Date;

/**
 * @author Yoshimi
 *
 */
public class SegmentBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8476937436323359378L;
	private StationBean startAt;
	private StationBean endAt;
	private Date travelTime;
	private String status;
	/**
	 * @return the startAt
	 */
	public StationBean getStartAt() {
		return startAt;
	}
	/**
	 * @param startAt the startAt to set
	 */
	public void setStartAt(StationBean startAt) {
		this.startAt = startAt;
	}
	/**
	 * @return the endAt
	 */
	public StationBean getEndAt() {
		return endAt;
	}
	/**
	 * @param endAt the endAt to set
	 */
	public void setEndAt(StationBean endAt) {
		this.endAt = endAt;
	}
	/**
	 * @return the travelTime
	 */
	public Date getTravelTime() {
		return travelTime;
	}
	/**
	 * @param travelTime the travelTime to set
	 */
	public void setTravelTime(Date travelTime) {
		this.travelTime = travelTime;
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
