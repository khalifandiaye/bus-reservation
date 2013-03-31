/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.search;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
public class SearchLatitudeJSONAction extends ActionSupport {

	/**
	 * UID
	 */
	private static final long serialVersionUID = 70L;

	// =====INPUT PARAM====
	private String busStatus;
	private String departTime;
	private String arriveTime;

	// =====OUTPUT PARAM===
	private ArrayList latitudeList;

	// =====DAO============
	private TripDAO tripDAO;

	
	/**
	 * @return the latitudeList
	 */
	public ArrayList getLatitudeList() {
		return latitudeList;
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
	 * Get latitude of route location
	 */
	@Action(value = "/getRouteLatitude", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		try {
			int status = Integer.parseInt(busStatus);
			List<TripBean> returnTrip = null;
			latitudeList = new ArrayList();
			returnTrip = tripDAO.getTripDetails(status, departTime, arriveTime);
			for (int i = 0; i < returnTrip.size(); i++) {
				HashMap<String, String> tripMap = new HashMap<String, String>();
				tripMap.clear();
				tripMap.put("city", returnTrip.get(i).getRouteDetails()
						.getSegment().getStartAt().getCity().getName());
				tripMap.put("latitude", returnTrip.get(i).getRouteDetails()
						.getSegment().getStartAt().getCity().getLatitude().toString());
				tripMap.put("longitude", returnTrip.get(i).getRouteDetails()
						.getSegment().getStartAt().getCity().getLongitude().toString());
				latitudeList.add(tripMap);
				if(i == (returnTrip.size() - 1)) {
					tripMap = new HashMap<String, String>();
					tripMap.put("city", returnTrip.get(i).getRouteDetails()
							.getSegment().getEndAt().getCity().getName());
					tripMap.put("latitude", returnTrip.get(i).getRouteDetails()
							.getSegment().getEndAt().getCity().getLatitude().toString());
					tripMap.put("longitude", returnTrip.get(i).getRouteDetails()
							.getSegment().getEndAt().getCity().getLongitude().toString());
					latitudeList.add(tripMap);
				}
			}
		} catch (NumberFormatException ne) {
			ne.printStackTrace();
		}
		return SUCCESS;
	}
}
