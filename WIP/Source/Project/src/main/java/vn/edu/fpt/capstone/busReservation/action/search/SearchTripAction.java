package vn.edu.fpt.capstone.busReservation.action.search;

import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.CityDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.CityBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;

//import vn.edu.fpt.capstone.busReservation.action.BaseAction;

public class SearchTripAction extends ActionSupport {
    /**
     * 
     */
    private static final long serialVersionUID = 1062565033385325127L;
    // =====================Database Access Object=====================
    private CityDAO cityDAO;
    private BusTypeDAO busTypeDAO;
    
    //======================Action Outputs=============================
    private List<CityBean> city;
    private List<BusTypeBean> busType;
       
	/**
	 * @return the city
	 */
	public List<CityBean> getCity() {
		return city;
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
    	city = cityDAO.getAllCity();
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
