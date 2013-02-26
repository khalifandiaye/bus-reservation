package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.CityDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.CityBean;

public class AddAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6692510134065137743L;
	
	private List<CityBean> cityBeans = new ArrayList<CityBean>();
	private List<BusTypeBean> busTypeBeans = new ArrayList<BusTypeBean>();
	
	private CityDAO cityDAO;
	private BusTypeDAO busTypeDAO;

	public String execute() {
		cityBeans = cityDAO.getAll();
		busTypeBeans = busTypeDAO.getAll();
		return SUCCESS;
	}

	public List<CityBean> getCityBeans() {
		return cityBeans;
	}

	public void setCityBeans(List<CityBean> cityBeans) {
		this.cityBeans = cityBeans;
	}

	public CityDAO getCityDAO() {
		return cityDAO;
	}

	public void setCityDAO(CityDAO cityDAO) {
		this.cityDAO = cityDAO;
	}

	public BusTypeDAO getBusTypeDAO() {
		return busTypeDAO;
	}

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}

	public List<BusTypeBean> getBusTypeBeans() {
		return busTypeBeans;
	}

	public void setBusTypeBeans(List<BusTypeBean> busTypeBeans) {
		this.busTypeBeans = busTypeBeans;
	}

}
