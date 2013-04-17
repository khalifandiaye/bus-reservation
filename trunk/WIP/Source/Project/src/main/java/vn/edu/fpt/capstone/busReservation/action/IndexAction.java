package vn.edu.fpt.capstone.busReservation.action;

import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.ParentPackage;

import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.CityDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.CityBean;
import vn.edu.fpt.capstone.busReservation.displayModel.TripDetailInfo;

@ParentPackage("pay")
public class IndexAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5962554617409673584L;
	// =====================Database Access Object=====================
    private CityDAO cityDAO;
    private BusTypeDAO busTypeDAO;
    private TripDAO tripDAO;
    
    //======================Action Outputs=============================
    private List<CityBean> deptCity;
    private List<CityBean> arrCity;
    private List<BusTypeBean> busType;
    private List<TripDetailInfo> list4Info;
    
    
	/**
	 * @return the list4Info
	 */
	public List<TripDetailInfo> getList4Info() {
		return list4Info;
	}

	/**
	 * @param tripDAO the tripDAO to set
	 */
	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
	}

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
//	    List<SearchResultInfo> list4Trips;
    	deptCity = cityDAO.getDepartCity();
    	arrCity = cityDAO.getArriveCity(deptCity.get(0).getId());
	   	busType = busTypeDAO.getAllBusType();
//        list4Trips = tripDAO.getTop4Trips();
	   	// get all trip that is going to depart within 24 hours
	   	list4Info  = tripDAO.getInDateTrips(new Date(), 1);
	   	// randomize the list
	   	Collections.shuffle(list4Info);
	   	// get only the first 4 trips
	   	if (list4Info.size() > 4) {
	        list4Info.subList(4, list4Info.size()).clear();
	   	}
        // sort the list
        Collections.sort(list4Info);
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
