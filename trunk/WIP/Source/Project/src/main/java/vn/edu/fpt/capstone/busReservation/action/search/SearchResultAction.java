/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.search;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author Monkey
 *
 */
public class SearchResultAction extends ActionSupport {
    private static final long serialVersionUID = 51L;
    //=======================Input Parameter=====================
    private String ticketType;
    private String departureCity;
    private String arrivalCity;
    private String passengerNo;
    private String departureDate;
    private String arrivalDate;
    private String busType;
	/**
	 * @param ticketType the ticketType to set
	 */
	public void setTicketType(String ticketType) {
		this.ticketType = ticketType;
	}
	/**
	 * @param departureCity the departureCity to set
	 */
	public void setDepartureCity(String departureCity) {
		this.departureCity = departureCity;
	}
	/**
	 * @param arrivalCity the arrivalCity to set
	 */
	public void setArrivalCity(String arrivalCity) {
		this.arrivalCity = arrivalCity;
	}
	/**
	 * @param passengerNo the passengerNo to set
	 */
	public void setPassengerNo(String passengerNo) {
		this.passengerNo = passengerNo;
	}
	/**
	 * @param departureDate the departureDate to set
	 */
	public void setDepartureDate(String departureDate) {
		this.departureDate = departureDate;
	}
	/**
	 * @param arrivalDate the arrivalDate to set
	 */
	public void setArrivalDate(String arrivalDate) {
		this.arrivalDate = arrivalDate;
	}
	/**
	 * @param busType the busType to set
	 */
	public void setBusType(String busType) {
		this.busType = busType;
	}
    
	public String execute() throws Exception {
		
		return SUCCESS;		
	}
}
