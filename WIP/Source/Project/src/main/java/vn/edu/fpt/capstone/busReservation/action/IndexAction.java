package vn.edu.fpt.capstone.busReservation.action;

import java.util.List;

import org.apache.struts2.convention.annotation.ParentPackage;

import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.CityDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.CityBean;

import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("pay")
public class IndexAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5962554617409673584L;
	// =====================Database Access Object=====================
    private CityDAO cityDAO;
    private BusTypeDAO busTypeDAO;
    
    //======================Action Outputs=============================
    private List<CityBean> deptCity;
    private List<CityBean> arrCity;
    private List<BusTypeBean> busType;
       
	/**
	 * @return the city
	 */
	public List<CityBean> getDeptCity() {
		return deptCity;
	}
	
	/**
	 * @return the arrCity
	 */
	public List<CityBean> getArrCity() {
		return arrCity;
	}

	/**
	 * @return the busType
	 */
	public List<BusTypeBean> getBusType() {
		return busType;
	}

	/**
	 * execute function
	 */
	public String execute() throws Exception {
    	deptCity = cityDAO.getDepartCity();
    	arrCity = cityDAO.getArriveCity(deptCity.get(0).getId());
	   	busType = busTypeDAO.getAllBusType();
        
        return SUCCESS;
    }

	/**
	 * @param cityDAO the cityDAO to set
	 */
	public void setCityDAO(CityDAO cityDAO) {
		this.cityDAO = cityDAO;
	}

	/**
	 * @param busTypeDAO the busTypeDAO to set
	 */
	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}

}
