package vn.edu.fpt.capstone.busReservation.action;

import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.convention.annotation.ParentPackage;

import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.CityDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.CityBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SearchResultInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.TripDetailInfo;

import com.opensymphony.xwork2.ActionSupport;

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
    private List<SearchResultInfo> list4Trips;
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
    	deptCity = cityDAO.getDepartCity();
    	arrCity = cityDAO.getArriveCity(deptCity.get(0).getId());
	   	busType = busTypeDAO.getAllBusType();
        list4Trips = tripDAO.getTop4Trips();
	   	list4Info  = new ArrayList<TripDetailInfo>();
        Format formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm a");
        Format formatterFull = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	   	
	   	
        for(int i = 0; i < list4Trips.size(); i++){
        	TripDetailInfo info = new TripDetailInfo();
        	info.setBusStatusId(list4Trips.get(i).getBusStatusId());
        	info.setDepartureTime(formatter.format(list4Trips.get(i).getDepartureTime()));
        	info.setArrivalTime(formatter.format(list4Trips.get(i).getArrivalTime()));
        	info.setDepartureTimeFull(formatterFull.format(list4Trips.get(i).getDepartureTime()));
        	info.setArrivalTimeFull(formatterFull.format(list4Trips.get(i).getArrivalTime()));
        	
        	info.setName(list4Trips.get(i).getDepartureCity()+ " - " + list4Trips.get(i).getArrivalCity());
        	
        	list4Info.add(info);
        }
        
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
