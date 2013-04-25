package vn.edu.fpt.capstone.busReservation.logic;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.displayModel.SearchResultInfo;
import vn.edu.fpt.capstone.busReservation.util.DateUtils;

/**
 * 
 * @author Monkey
 *
 */
public class SearchResultLogic extends BaseLogic {
	
	 private static final long serialVersionUID = 902L;
	 
	 //===DAO==
	 private TripDAO tripDAO;

	/**
	 * @param tripDAO the tripDAO to set
	 */
	@Autowired
	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
	}
	 
	/**
	 * 
	 * @param deptCity
	 * @param arrvCity
	 * @param deptDate
	 * @param pssgrNo
	 * @param minDate
	 * @return
	 */
	public Map<String, Map<String, List<SearchResultInfo>>> searchTripGroupByDate
		(int deptCity, int arrvCity, String deptDate, int pssgrNo, String minDate){

		List<SearchResultInfo> searchResultList = null;
		
		//Hashmap for result filter by date
		Map<String, Map<String, List<SearchResultInfo>>> resultDate = 
			new LinkedHashMap<String, Map<String,List<SearchResultInfo>>>();
		//HM for result filter by Bus type
		Map<String, List<SearchResultInfo>> resultBusType = null;
		//List to add -> result bus type HM
		List<SearchResultInfo> currList = null;
		
		String date = null;
		String bType = null;
		
		searchResultList = tripDAO.searchAvailableTrips(deptCity, arrvCity, deptDate, pssgrNo, minDate);
	
		if(searchResultList.size() > 0) {
			//loop on each result
			for(SearchResultInfo info : searchResultList){
				date = DateUtils.getMonthDay(info.getDepartureTime());
				LOG.debug(date);
				if(resultDate.containsKey(date)) {
					resultBusType = resultDate.get(date);
				} else {
					resultBusType = new LinkedHashMap<String, List<SearchResultInfo>>();
					resultDate.put(date, resultBusType);
				}
				bType = info.getBusType();
				if(resultBusType.containsKey(bType)) {
					currList = resultBusType.get(bType);
				} else {
					currList = new ArrayList<SearchResultInfo>();
					resultBusType.put(bType, currList);
				}
				currList.add(info);
			}
		}
		return resultDate;
	}
	 
}
