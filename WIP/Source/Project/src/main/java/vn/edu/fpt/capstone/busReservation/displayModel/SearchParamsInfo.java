package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.util.Date;

public class SearchParamsInfo implements Serializable{
	private static final long serialVersionUID = 52L;
	private String ticketType;
	private int departureCity;
	private int arrivalCity;
	private int passengerNo;
	private String departureDate;
	private String returnDate;
	private int busType;
	/**
	 * @return the ticketType
	 */
	public String getTicketType() {
		return ticketType;
	}
	/**
	 * @param ticketType the ticketType to set
	 */
	public void setTicketType(String ticketType) {
		this.ticketType = ticketType;
	}
	/**
	 * @return the departureCity
	 */
	public int getDepartureCity() {
		return departureCity;
	}
	/**
	 * @param departureCity the departureCity to set
	 */
	public void setDepartureCity(int departureCity) {
		this.departureCity = departureCity;
	}
	/**
	 * @return the arrivalCity
	 */
	public int getArrivalCity() {
		return arrivalCity;
	}
	/**
	 * @param arrivalCity the arrivalCity to set
	 */
	public void setArrivalCity(int arrivalCity) {
		this.arrivalCity = arrivalCity;
	}
	/**
	 * @return the passengerNo
	 */
	public int getPassengerNo() {
		return passengerNo;
	}
	/**
	 * @param passengerNo the passengerNo to set
	 */
	public void setPassengerNo(int passengerNo) {
		this.passengerNo = passengerNo;
	}
	/**
	 * @return the departureDate
	 */
	public String getDepartureDate() {
		return departureDate;
	}
	/**
	 * @param departureDate the departureDate to set
	 */
	public void setDepartureDate(String departureDate) {
		this.departureDate = departureDate;
	}
	/**
	 * @return the returnDate
	 */
	public String getReturnDate() {
		return returnDate;
	}
	/**
	 * @param returnDate the returnDate to set
	 */
	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}
	/**
	 * @return the busType
	 */
	public int getBusType() {
		return busType;
	}
	/**
	 * @param busType the busType to set
	 */
	public void setBusType(int busType) {
		this.busType = busType;
	}
	
	
}
