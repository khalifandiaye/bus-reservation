/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.search;

import com.opensymphony.xwork2.ActionSupport;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.displayModel.SearchParamsInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.SearchResultInfo;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;
/**
 * @author Monkey
 *
 */
public class SearchResultAction extends BaseAction implements SessionAware {
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
		LOG.info("search result action passengerNo = " + passengerNo);
	}
	/**
	 * @return the passengerNo
	 */
	public int getPassengerNo() {
		return passengerNo;
	}
	/**
	 * @param departureDate the departureDate to set
	 */
	public void setDepartureDate(String departureDate) {
		this.departureDate = departureDate;
	}
	
	
	/**
	 * @return the departureDate
	 */
	public String getDepartureDate() {
		return departureDate;
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
		
		if(session != null && session.containsKey("searchAnother")){
			SearchParamsInfo searchParam = (SearchParamsInfo)session.get("searchAnother");
			this.departureDate = searchParam.getDepartureDate();
			this.departureCity = searchParam.getDepartureCity();
			this.arrivalCity = searchParam.getArrivalCity();
			this.passengerNo = searchParam.getPassengerNo();
			this.busType = searchParam.getBusType();
			session.remove("searchAnother");
		}
		
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
