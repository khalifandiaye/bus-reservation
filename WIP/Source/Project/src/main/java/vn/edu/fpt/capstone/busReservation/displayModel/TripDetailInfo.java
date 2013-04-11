package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.util.Date;

public class TripDetailInfo implements Serializable{
	
	private static final long serialVersionUID = -2195287469199563262L;
	
	private int busStatusId;
	private String name;
	private String departureTime;
	private String arrivalTime;
	private String departureTimeFull;
	private String arrivalTimeFull;
	
	
	/**
	 * @return the departureTimeFull
	 */
	public String getDepartureTimeFull() {
		return departureTimeFull;
	}
	/**
	 * @param departureTimeFull the departureTimeFull to set
	 */
	public void setDepartureTimeFull(String departureTimeFull) {
		this.departureTimeFull = departureTimeFull;
	}
	/**
	 * @return the arrivalTimeFull
	 */
	public String getArrivalTimeFull() {
		return arrivalTimeFull;
	}
	/**
	 * @param arrivalTimeFull the arrivalTimeFull to set
	 */
	public void setArrivalTimeFull(String arrivalTimeFull) {
		this.arrivalTimeFull = arrivalTimeFull;
	}
	/**
	 * @return the busStatusId
	 */
	public int getBusStatusId() {
		return busStatusId;
	}
	/**
	 * @param busStatusId the busStatusId to set
	 */
	public void setBusStatusId(int busStatusId) {
		this.busStatusId = busStatusId;
	}
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
	 * @return the departureTime
	 */
	public String getDepartureTime() {
		return departureTime;
	}
	/**
	 * @param departureTime the departureTime to set
	 */
	public void setDepartureTime(String departureTime) {
		this.departureTime = departureTime;
	}
	/**
	 * @return the arrivalTime
	 */
	public String getArrivalTime() {
		return arrivalTime;
	}
	/**
	 * @param arrivalTime the arrivalTime to set
	 */
	public void setArrivalTime(String arrivalTime) {
		this.arrivalTime = arrivalTime;
	}
	public TripDetailInfo() {
		super();
	}
}
