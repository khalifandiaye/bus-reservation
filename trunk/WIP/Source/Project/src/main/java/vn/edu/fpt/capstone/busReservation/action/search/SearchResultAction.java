/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.search;

import com.opensymphony.xwork2.ActionSupport;

import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.displayModel.SearchResultInfo;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
/**
 * @author Monkey
 *
 */
public class SearchResultAction extends ActionSupport {
    private static final long serialVersionUID = 51L;
    //=======================Input Parameter=====================
    private String ticketType;
    private int departureCity;
    private int arrivalCity;
    private int passengerNo;
    private String departureDate;
    private int busType;
    //=======================Output Parameter====================
    private List<SearchResultInfo> searchResult;
    private String deptCity;
    private String arrCity;
    //=======================Data Access Object==================
    private TripDAO tripDAO;
        
	/**
	 * @param tripDAO the tripDAO to set
	 */
	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
	}
	/**
	 * @return the searchResult
	 */
	public List<SearchResultInfo> getSearchResult() {
		return searchResult;
	}
	/**
	 * @param ticketType the ticketType to set
	 */
	public void setTicketType(String ticketType) {
		this.ticketType = ticketType;
	}
	/**
	 * @param departureCity the departureCity to set
	 */
	public void setDepartureCity(int departureCity) {
		this.departureCity = departureCity;
	}
	/**
	 * @param arrivalCity the arrivalCity to set
	 */
	public void setArrivalCity(int arrivalCity) {
		this.arrivalCity = arrivalCity;
	}
	/**
	 * @param passengerNo the passengerNo to set
	 */
	public void setPassengerNo(int passengerNo) {
		this.passengerNo = passengerNo;
	}
	/**
	 * @param departureDate the departureDate to set
	 */
	public void setDepartureDate(String departureDate) {
		this.departureDate = departureDate;
	}
	/**
	 * @param busType the busType to set
	 */
	public void setBusType(int busType) {
		this.busType = busType;
	}
    
	
	/**
	 * @return the departureCity
	 */
	public String getDeptCity() {
		return deptCity;
	}
	/**
	 * @return the arrivalCity
	 */
	public String getArrCity() {
		return arrCity;
	}
	public String execute() throws Exception {
		SimpleDateFormat fromFormat = new SimpleDateFormat("dd-MM-yyyy", Locale.US);
		SimpleDateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
		String deptDate = toFormat.format(fromFormat.parse(departureDate));
		searchResult = tripDAO.searchAvailableTrips(departureCity, arrivalCity, deptDate, passengerNo, busType);
		if(searchResult.size() == 0){
			deptCity = "";
			arrCity = "";
		} else {
			deptCity = searchResult.get(0).getDepartureCity();
			arrCity = searchResult.get(0).getArrivalCity();
		}
		return SUCCESS;		
	}
}
