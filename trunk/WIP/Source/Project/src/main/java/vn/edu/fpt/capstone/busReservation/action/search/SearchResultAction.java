/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.search;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.CityDAO;
import vn.edu.fpt.capstone.busReservation.displayModel.SearchParamsInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.SearchResultInfo;
import vn.edu.fpt.capstone.busReservation.util.DateUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

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
	private int passengerNo;
	private String departureDate;
	private String returnDate;
	private int busType;
	// =======================Output Parameter====================
	private List<SearchResultInfo> searchResult;
	// HashMap<String,List<SearchResultInfo>> searchResultMap;

	// Onward
	ArrayList<SearchResultInfo> resultNo1;
	ArrayList<SearchResultInfo> resultNo2;
	ArrayList<SearchResultInfo> resultNo3;
	ArrayList<SearchResultInfo> resultNo4;
	ArrayList<SearchResultInfo> resultNo5;
	ArrayList<SearchResultInfo> resultNo6;
	ArrayList<SearchResultInfo> resultNo7;

	// Return
	ArrayList<SearchResultInfo> rtnResultNo1;
	ArrayList<SearchResultInfo> rtnResultNo2;
	ArrayList<SearchResultInfo> rtnResultNo3;
	ArrayList<SearchResultInfo> rtnResultNo4;
	ArrayList<SearchResultInfo> rtnResultNo5;
	ArrayList<SearchResultInfo> rtnResultNo6;
	ArrayList<SearchResultInfo> rtnResultNo7;

	// Commons
	private String deptCity;
	private String arrCity;
	private String message;
	private String searchMessage;
	private String rtnExistResultFlag;
	// =======================Data Access Object==================
	private TripDAO tripDAO;
	private CityDAO cityDAO;

	/**
	 * @return the rtnExistResultFlag
	 */
	public String getRtnExistResultFlag() {
		return rtnExistResultFlag;
	}

	/**
	 * @return the searchMessage
	 */
	public String getSearchMessage() {
		return searchMessage;
	}

	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @param tripDAO
	 *            the tripDAO to set
	 */
	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
	}

	/**
	 * @param cityDAO
	 *            the cityDAO to set
	 */
	public void setCityDAO(CityDAO cityDAO) {
		this.cityDAO = cityDAO;
	}

	/**
	 * @return the rtnResultNo1
	 */
	public ArrayList<SearchResultInfo> getRtnResultNo1() {
		return rtnResultNo1;
	}

	/**
	 * @return the rtnResultNo2
	 */
	public ArrayList<SearchResultInfo> getRtnResultNo2() {
		return rtnResultNo2;
	}

	/**
	 * @return the rtnResultNo3
	 */
	public ArrayList<SearchResultInfo> getRtnResultNo3() {
		return rtnResultNo3;
	}

	/**
	 * @return the rtnResultNo4
	 */
	public ArrayList<SearchResultInfo> getRtnResultNo4() {
		return rtnResultNo4;
	}

	/**
	 * @return the rtnResultNo5
	 */
	public ArrayList<SearchResultInfo> getRtnResultNo5() {
		return rtnResultNo5;
	}

	/**
	 * @return the rtnResultNo6
	 */
	public ArrayList<SearchResultInfo> getRtnResultNo6() {
		return rtnResultNo6;
	}

	/**
	 * @return the rtnResultNo7
	 */
	public ArrayList<SearchResultInfo> getRtnResultNo7() {
		return rtnResultNo7;
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
	 * @return the resultNo1
	 */
	public ArrayList<SearchResultInfo> getResultNo1() {
		return resultNo1;
	}

	/**
	 * @return the resultNo2
	 */
	public ArrayList<SearchResultInfo> getResultNo2() {
		return resultNo2;
	}

	/**
	 * @return the resultNo3
	 */
	public ArrayList<SearchResultInfo> getResultNo3() {
		return resultNo3;
	}

	/**
	 * @return the resultNo4
	 */
	public ArrayList<SearchResultInfo> getResultNo4() {
		return resultNo4;
	}

	/**
	 * @return the resultNo5
	 */
	public ArrayList<SearchResultInfo> getResultNo5() {
		return resultNo5;
	}

	/**
	 * @return the resultNo6
	 */
	public ArrayList<SearchResultInfo> getResultNo6() {
		return resultNo6;
	}

	/**
	 * @return the resultNo7
	 */
	public ArrayList<SearchResultInfo> getResultNo7() {
		return resultNo7;
	}

	/**
	 * @return the searchResult
	 */
	public List<SearchResultInfo> getSearchResult() {
		return searchResult;
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
	 * @param passengerNo
	 *            the passengerNo to set
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
	 * @param busType
	 *            the busType to set
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
				this.passengerNo = searchParam.getPassengerNo();
				this.busType = searchParam.getBusType();
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
			searchResult = tripDAO.searchAvailableTrips(departureCity,
					arrivalCity, deptDate, passengerNo, minDate);
			if (searchResult.size() != 0) {
				// searchResultMap = filterByDate(searchResult);
				filterResultByDate(searchResult);
				searchMessage = "exist";
			} else {
				searchMessage = "";
			}

			// round-trip
			if (CommonConstant.TICKET_ROUND_TRIP.equals(ticketType)) {
				if(searchResult.size()!=0){
					Calendar arrvTime = Calendar.getInstance();;
					arrvTime.setTime(searchResult.get(0).getArrivalTime());
					arrvTime.add(Calendar.MINUTE, CommonConstant.MIN_TIME_BEFORE_DEPART);
					minDate = dateTimeFormat.format(arrvTime.getTime());
				}
				// return journey
				String retDate = toFormat.format(fromFormat.parse(returnDate));
				searchResult = tripDAO.searchAvailableTrips(arrivalCity,
						departureCity, retDate, passengerNo, minDate);
				if (searchResult.size() != 0) {
					// searchResultMap = filterByDate(searchResult);
					filterReturnResultByDate(searchResult);
					rtnExistResultFlag = "exist";
				} else {
					rtnExistResultFlag = "";
				}
			}

			deptCity = cityDAO.getById(this.departureCity).getName();
			arrCity = cityDAO.getById(this.arrivalCity).getName();
			// String fromDate = DateUtils.addDay(departureDate, -3,
			// "dd-MM-yyyy", Locale.US);
			// String toDate = DateUtils.addDay(departureDate, 3, "dd-MM-yyyy",
			// Locale.US);
		} catch (Exception e) {
		}
		return SUCCESS;
	}

	/*
	 * private HashMap<String,List<SearchResultInfo>>
	 * filterByDate(List<SearchResultInfo> searchResult) throws Exception{
	 * HashMap<String,List<SearchResultInfo>> resultMap = new
	 * HashMap<String,List<SearchResultInfo>>(); ArrayList<SearchResultInfo>
	 * resultInf = new ArrayList<SearchResultInfo>(); SimpleDateFormat
	 * fromFormat = new SimpleDateFormat("dd-MM-yyyy", Locale.US); String myDate
	 * = fromFormat.format(searchResult.get(0).getDepartureTime()); String
	 * compareDate; for(int i = 0; i < searchResult.size(); i++){ compareDate =
	 * fromFormat.format(searchResult.get(i).getDepartureTime());
	 * if(!myDate.equals(compareDate)){ resultMap.put(myDate, resultInf);
	 * resultInf.clear(); myDate =
	 * fromFormat.format(searchResult.get(i).getDepartureTime()); } else {
	 * resultInf.add(searchResult.get(i)); } } resultMap.put(myDate, resultInf);
	 * return resultMap; }
	 */

	/**
	 * Filter result of onward journey by date (7 days) to 7 different lists
	 * 
	 * @param searchResult
	 *            List of search result
	 * @throws Exception
	 */
	private void filterResultByDate(List<SearchResultInfo> searchResult)
			throws Exception {
		resultNo1 = new ArrayList<SearchResultInfo>();
		resultNo2 = new ArrayList<SearchResultInfo>();
		resultNo3 = new ArrayList<SearchResultInfo>();
		resultNo4 = new ArrayList<SearchResultInfo>();
		resultNo5 = new ArrayList<SearchResultInfo>();
		resultNo6 = new ArrayList<SearchResultInfo>();
		resultNo7 = new ArrayList<SearchResultInfo>();
		String compareDate;
		SimpleDateFormat fromFormat = new SimpleDateFormat("dd-MM-yyyy",
				Locale.US);

		HashMap<Integer, String> dateList = new HashMap<Integer, String>();
		for (int i = -3; i <= 3; i++) {
			compareDate = DateUtils.addDay(departureDate, i, "dd-MM-yyyy",
					Locale.US);
			dateList.put(i, compareDate);
		}
		for (int i = 0; i < searchResult.size(); i++) {
			compareDate = fromFormat.format(searchResult.get(i)
					.getDepartureTime());
			if (dateList.get(-3).equals(compareDate)) {
				resultNo1.add(searchResult.get(i));
			} else if (dateList.get(-2).equals(compareDate)) {
				resultNo2.add(searchResult.get(i));
			} else if (dateList.get(-1).equals(compareDate)) {
				resultNo3.add(searchResult.get(i));
			} else if (dateList.get(0).equals(compareDate)) {
				resultNo4.add(searchResult.get(i));
			} else if (dateList.get(1).equals(compareDate)) {
				resultNo5.add(searchResult.get(i));
			} else if (dateList.get(2).equals(compareDate)) {
				resultNo6.add(searchResult.get(i));
			} else if (dateList.get(3).equals(compareDate)) {
				resultNo7.add(searchResult.get(i));
			}
		}

	}

	/**
	 * Filter result of return journey by date (7 days) to 7 different lists
	 * 
	 * @param searchResult
	 *            List of search result
	 * @throws Exception
	 */
	private void filterReturnResultByDate(List<SearchResultInfo> searchResult)
			throws Exception {
		rtnResultNo1 = new ArrayList<SearchResultInfo>();
		rtnResultNo2 = new ArrayList<SearchResultInfo>();
		rtnResultNo3 = new ArrayList<SearchResultInfo>();
		rtnResultNo4 = new ArrayList<SearchResultInfo>();
		rtnResultNo5 = new ArrayList<SearchResultInfo>();
		rtnResultNo6 = new ArrayList<SearchResultInfo>();
		rtnResultNo7 = new ArrayList<SearchResultInfo>();
		String compareDate;
		SimpleDateFormat fromFormat = new SimpleDateFormat("dd-MM-yyyy",
				Locale.US);

		HashMap<Integer, String> dateList = new HashMap<Integer, String>();
		for (int i = -3; i <= 3; i++) {
			compareDate = DateUtils.addDay(returnDate, i, "dd-MM-yyyy",
					Locale.US);
			dateList.put(i, compareDate);
		}
		for (int i = 0; i < searchResult.size(); i++) {
			compareDate = fromFormat.format(searchResult.get(i)
					.getDepartureTime());
			if (dateList.get(-3).equals(compareDate)) {
				rtnResultNo1.add(searchResult.get(i));
			} else if (dateList.get(-2).equals(compareDate)) {
				rtnResultNo2.add(searchResult.get(i));
			} else if (dateList.get(-1).equals(compareDate)) {
				rtnResultNo3.add(searchResult.get(i));
			} else if (dateList.get(0).equals(compareDate)) {
				rtnResultNo4.add(searchResult.get(i));
			} else if (dateList.get(1).equals(compareDate)) {
				rtnResultNo5.add(searchResult.get(i));
			} else if (dateList.get(2).equals(compareDate)) {
				rtnResultNo6.add(searchResult.get(i));
			} else if (dateList.get(3).equals(compareDate)) {
				rtnResultNo7.add(searchResult.get(i));
			}
		}

	}

}
