/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action;

import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.StationDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author Yoshimi
 * 
 */
public class TestAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -154282814097763674L;
	private List<StationBean> stationList;
	private StationDAO stationDAO;

	/**
	 * @return the stationList
	 */
	public List<StationBean> getStationList() {
		return stationList;
	}

	/**
	 * @param stationDAO
	 *            the stationDAO to set
	 */
	public void setStationDAO(StationDAO stationDAO) {
		this.stationDAO = stationDAO;
	}

	public String execute() {
		stationList = stationDAO.getAll();
		return SUCCESS;
	}
}
