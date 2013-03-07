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
import vn.edu.fpt.capstone.busReservation.dao.bean.CityBean;

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
    //======OUPUT====
    private HashMap<Integer, String> cityList;
    //======DAO======
    private CityDAO cityDAO;
	/**
	 * @return the arrCityList
	 */
	public HashMap<Integer, String> getCityList() {
		return cityList;
	}
	/**
	 * @param cityDAO the cityDAO to set
	 */
	public void setCityDAO(CityDAO cityDAO) {
		this.cityDAO = cityDAO;
	}
	/**
	 * @param deptCity the deptCity to set
	 */
	public void setDeptCity(String deptCity) {
		this.deptCity = deptCity;
	}
    
    @Action(value = "/getArriveCity", results = { @Result(type = "json", name = SUCCESS) })
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
    
}
