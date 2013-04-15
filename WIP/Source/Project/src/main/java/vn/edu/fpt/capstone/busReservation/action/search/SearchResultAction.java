/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.search;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.CityDAO;
import vn.edu.fpt.capstone.busReservation.displayModel.SearchParamsInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.SearchResultInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.SearchResultLogic;
import vn.edu.fpt.capstone.busReservation.util.DateUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
	// =======================Input Parameter=====================
	private String ticketType;
	private int departureCity;
	private int arrivalCity;
	private String departureDate;
	private String returnDate;

	// =======================Output Parameter====================
	private Map<String, Map<String, List<SearchResultInfo>>> onwardMap;
	private Map<String, Map<String, List<SearchResultInfo>>> returnMap;

	// Commons
	private String deptCity;
	private String arrCity;
	private String message;
	
	// =======================Data Access Object==================
	private CityDAO cityDAO;

	//========================Logic===============================
	private SearchResultLogic searchResultLogic;
	   
	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @param cityDAO
	 *            the cityDAO to set
	 */
	public void setCityDAO(CityDAO cityDAO) {
		this.cityDAO = cityDAO;
	}

	/**
	 * @param returnDate
	 *            the returnDate to set
	 */
	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}

	/**
	 * @return the returnDate
	 */
	public String getReturnDate() {
		return returnDate;
	}


	/**
	 * @return the ticketType
	 */
	public String getTicketType() {
		return ticketType;
	}

	/**
	 * @param ticketType
	 *            the ticketType to set
	 */
	public void setTicketType(String ticketType) {
		this.ticketType = ticketType;
	}

	/**
	 * @param departureCity
	 *            the departureCity to set
	 */
	public void setDepartureCity(int departureCity) {
		this.departureCity = departureCity;
	}

	/**
	 * @param arrivalCity
	 *            the arrivalCity to set
	 */
	public void setArrivalCity(int arrivalCity) {
		this.arrivalCity = arrivalCity;
	}

	/**
	 * @param departureDate
	 *            the departureDate to set
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

	
	/**
	 * @return the onwardMap
	 */
	public Map<String, Map<String, List<SearchResultInfo>>> getOnwardMap() {
		return onwardMap;
	}

	/**
	 * @return the returnMap
	 */
	public Map<String, Map<String, List<SearchResultInfo>>> getReturnMap() {
		return returnMap;
	}

	/**
	 * @param searchResultLogic the searchResultLogic to set
	 */
	public void setSearchResultLogic(SearchResultLogic searchResultLogic) {
		this.searchResultLogic = searchResultLogic;
	}

	/**
	 * Execute action
	 */
	public String execute() {
		try {
			if (session != null && session.containsKey("searchAnother")) {
				SearchParamsInfo searchParam = (SearchParamsInfo) session
						.get("searchAnother");
				this.departureDate = searchParam.getDepartureDate();
				this.departureCity = searchParam.getDepartureCity();
				this.arrivalCity = searchParam.getArrivalCity();
				this.message = (String) session.get("message");

				session.remove("message");
				session.remove("searchAnother");
			}		
			
			// Format date
			SimpleDateFormat fromFormat = new SimpleDateFormat("dd-MM-yyyy",
					Locale.US);
			SimpleDateFormat toFormat = new SimpleDateFormat("yyyy-MM-dd",
					Locale.US);
			SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// Departure date for onward journey
			String deptDate = toFormat.format(fromFormat.parse(departureDate));
			Calendar now = Calendar.getInstance();
			now.add(Calendar.MINUTE, CommonConstant.MIN_TIME_BEFORE_DEPART);
			String minDate = dateTimeFormat.format(now.getTime());
		 	this.onwardMap = searchResultLogic.searchTripGroupByDate(this.departureCity, 
		 			this.arrivalCity, deptDate, CommonConstant.PASSENGER_MIN_NO, minDate);
			
			// round-trip
			if (CommonConstant.TICKET_ROUND_TRIP.equals(ticketType)) {
				if(onwardMap.size()!=0){
					Calendar arrvTime = Calendar.getInstance();
					//get day of first trip in result list
					arrvTime.setTime(onwardMap.values().iterator().next().values().iterator().next().get(0).getArrivalTime());
					arrvTime.add(Calendar.MINUTE, CommonConstant.MIN_TIME_BEFORE_DEPART);
					minDate = dateTimeFormat.format(arrvTime.getTime());
				}
				// return journey
				String retDate = toFormat.format(fromFormat.parse(returnDate));
				this.returnMap = searchResultLogic.searchTripGroupByDate(this.arrivalCity, 
			 			this.departureCity, retDate, CommonConstant.PASSENGER_MIN_NO, minDate);
			} 
			
			deptCity = cityDAO.getById(this.departureCity).getName();
			arrCity = cityDAO.getById(this.arrivalCity).getName();

		} catch (Exception e) {
			//errorProcessing(e);
			//return ERROR;
			e.printStackTrace();
		}
		return SUCCESS;
	}



}
