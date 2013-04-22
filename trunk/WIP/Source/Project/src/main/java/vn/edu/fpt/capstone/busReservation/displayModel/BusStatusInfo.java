package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

public class BusStatusInfo implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int busId;
	private String status;
	/**
	 * @return the busId
	 */
	public int getBusId() {
		return busId;
	}
	/**
	 * @param busId the busId to set
	 */
	public void setBusId(int busId) {
		this.busId = busId;
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
