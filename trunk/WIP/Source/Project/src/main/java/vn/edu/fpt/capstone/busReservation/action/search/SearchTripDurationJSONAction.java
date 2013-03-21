/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.search;

import java.util.HashMap;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.dao.CityDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.CityBean;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author Monkey
 *
 */
@ParentPackage("jsonPackage")
public class SearchTripDurationJSONAction extends ActionSupport {
	//INPUT
	private String deptCity;
	private String arrCity;
	//DAO
	private TripDAO tripDAO;
	//OUTPUT
	private int duration;
		
	/**
	 * @return the duration
	 */
	public int getDuration() {
		return duration;
	}


	/**
	 * @param deptCity the deptCity to set
	 */
	public void setDeptCity(String deptCity) {
		this.deptCity = deptCity;
	}


	/**
	 * @param arrCity the arrCity to set
	 */
	public void setArrCity(String arrCity) {
		this.arrCity = arrCity;
	}


	/**
	 * @param tripDAO the tripDAO to set
	 */
	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
	}


	@Action(value = "/getTravelTime", results = { @Result(type = "json", name = SUCCESS) })
    public String execute(){
    	int day = tripDAO.getMinDuration(Integer.parseInt(deptCity), Integer.parseInt(arrCity));
    	duration = day;
    	return SUCCESS;	
    }
}
