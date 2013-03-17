/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.search;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.CityDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.CityBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;

/**
 * @author Monkey
 *
 */
@ParentPackage("jsonPackage")
public class SearchJSONAction extends BaseAction {

	 /**
     * 
     */
    private static final long serialVersionUID = 60L;

    //======INPUT====
    private String deptCity;
/*    private String busStatus;
    private String departTime;
    private String arriveTime;*/
    
    //======OUPUT====
    private HashMap<Integer, String> cityList;
/*    private ArrayList tripList;*/
    
    //======DAO======
    private CityDAO cityDAO;
/*    private TripDAO tripDAO;*/
    
    /**
	 * @return the arrCityList
	 */
	public HashMap<Integer, String> getCityList() {
		return cityList;
	}
	
/*	*//**
	 * @return the tripList
	 *//*
	public ArrayList getTripList() {
		return tripList;
	}
*/
	/**
	 * @param cityDAO the cityDAO to set
	 */
	public void setCityDAO(CityDAO cityDAO) {
		this.cityDAO = cityDAO;
	}
/*	
	*//**
	 * @param tripDAO the tripDAO to set
	 *//*
	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
	}*/
	/**
	 * @param deptCity the deptCity to set
	 */
	public void setDeptCity(String deptCity) {
		this.deptCity = deptCity;
	}
    
/*    *//**
	 * @param busStatus the busStatus to set
	 *//*
	public void setBusStatus(String busStatus) {
		this.busStatus = busStatus;
	}
	*//**
	 * @param departTime the departTime to set
	 *//*
	public void setDepartTime(String departTime) {
		this.departTime = departTime;
	}
	*//**
	 * @param arriveTime the arriveTime to set
	 *//*
	public void setArriveTime(String arriveTime) {
		this.arriveTime = arriveTime;
	}*/
	
	@Action(value = "/getArriveCity", results = { @Result(type = "json", name = SUCCESS, params = {
            "excludeProperties", "tripList" }) })
    public String getArriveCity(){
    	List<CityBean> arrCityList = null;
    	this.cityList = new HashMap<Integer,String>();
    	int dept = Integer.parseInt(this.deptCity);
       	arrCityList = cityDAO.getArriveCity(dept);
    	for(int i = 0; i < arrCityList.size(); i++) {
        	cityList.put(arrCityList.get(i).getId(), arrCityList.get(i).getName());  		
    	}
    	return SUCCESS;	
    }
    
/*    @Action(value = "/getTravelTime", results = { @Result(type = "json", name = SUCCESS) })
    public String getArriveDate(){
    	List<CityBean> arrCityList = null;
    	this.cityList = new HashMap<Integer,String>();
    	int dept = Integer.parseInt(this.deptCity);
       	arrCityList = cityDAO.getArriveCity(dept);
    	for(int i = 0; i < arrCityList.size(); i++) {
        	cityList.put(arrCityList.get(i).getId(), arrCityList.get(i).getName());  		
    	}
    	return SUCCESS;	
    }*/
/*    @Action(value = "/getTripDetails", results = { @Result(type = "json", name = SUCCESS) })
    public String getTripDetails(){
    	int status = Integer.parseInt(busStatus);
    	List<TripBean> returnTrip = null;
    	HashMap<String,String> tripMap = new HashMap<String,String>();
    	tripList = new ArrayList();
		returnTrip = tripDAO.getTripDetails(status, departTime, arriveTime);
		for(int i = 0; i < returnTrip.size(); i++){
			tripMap.clear();
			tripMap.put("deptCity", returnTrip.get(i).getRouteDetails().getSegment().getStartAt().getCity().getName());
			tripMap.put("deptStat", returnTrip.get(i).getRouteDetails().getSegment().getStartAt().getName());
			tripMap.put("deptTime", returnTrip.get(i).getDepartureTime().toString());
			tripMap.put("arrCity", returnTrip.get(i).getRouteDetails().getSegment().getEndAt().getCity().getName());
			tripMap.put("arrStat", returnTrip.get(i).getRouteDetails().getSegment().getEndAt().getName());
			tripMap.put("arrTime", returnTrip.get(i).getArrivalTime().toString());
			tripList.add(tripMap);
		}
		return SUCCESS;
    }*/
}
