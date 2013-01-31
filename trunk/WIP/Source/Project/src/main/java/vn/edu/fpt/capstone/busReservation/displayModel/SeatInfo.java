package vn.edu.fpt.capstone.busReservation.displayModel;

public class SeatInfo {
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
