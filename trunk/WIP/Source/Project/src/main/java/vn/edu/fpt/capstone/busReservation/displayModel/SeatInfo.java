package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

public class SeatInfo implements Serializable {
	/**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String name;
	private String status;
	
	public SeatInfo(String name, String status) {
		super();
		this.name = name;
		this.status = status;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
