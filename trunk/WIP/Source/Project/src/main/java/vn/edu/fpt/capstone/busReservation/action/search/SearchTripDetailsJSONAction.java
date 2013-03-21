/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.search;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Locale;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author Monkey
 *
 */
@ParentPackage("jsonPackage")
public class SearchTripDetailsJSONAction extends ActionSupport {

	/**
	 * UID
	 */
	private static final long serialVersionUID = 63L;
	
	//=====INPUT PARAM====
	private String busStatus;
	private String departTime;
	private String arriveTime;
	
	//=====OUTPUT PARAM===
	private ArrayList tripList;
	
	//=====DAO============
	private TripDAO tripDAO;
	
	
	/**
	 * @return the tripList
	 */
	public ArrayList getTripList() {
		return tripList;
	}


	/**
	 * @param busStatus the busStatus to set
	 */
	public void setBusStatus(String busStatus) {
		this.busStatus = busStatus;
	}


	/**
	 * @param departTime the departTime to set
	 */
	public void setDepartTime(String departTime) {
		this.departTime = departTime;
	}


	/**
	 * @param arriveTime the arriveTime to set
	 */
	public void setArriveTime(String arriveTime) {
		this.arriveTime = arriveTime;
	}


	/**
	 * @param tripDAO the tripDAO to set
	 */
	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
	}


	/**
	 * 
	 * @return
	 */
	@Action(value = "/getTripDetails", results = { @Result(type = "json", name = SUCCESS) })
    public String execute(){
    	int status = Integer.parseInt(busStatus);
    	List<TripBean> returnTrip = null;
    	tripList = new ArrayList();
		returnTrip = tripDAO.getTripDetails(status, departTime, arriveTime);
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM", Locale.US);
		SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm", Locale.US);
		for(int i = 0; i < returnTrip.size(); i++){
			HashMap<String,String> tripMap = new HashMap<String,String>();
			tripMap.clear();
			tripMap.put("deptCity", returnTrip.get(i).getRouteDetails().getSegment().getStartAt().getCity().getName());
			tripMap.put("deptStat", returnTrip.get(i).getRouteDetails().getSegment().getStartAt().getName());
			tripMap.put("deptDate", dateFormat.format(returnTrip.get(i).getDepartureTime()));
			tripMap.put("deptTime", timeFormat.format(returnTrip.get(i).getDepartureTime()));
			tripMap.put("arrCity", returnTrip.get(i).getRouteDetails().getSegment().getEndAt().getCity().getName());
			tripMap.put("arrStat", returnTrip.get(i).getRouteDetails().getSegment().getEndAt().getName());
			tripMap.put("arrDate", dateFormat.format(returnTrip.get(i).getArrivalTime()));
			tripMap.put("arrTime", timeFormat.format(returnTrip.get(i).getArrivalTime()));
			tripList.add(tripMap);
		}
		return SUCCESS;
    }
}
