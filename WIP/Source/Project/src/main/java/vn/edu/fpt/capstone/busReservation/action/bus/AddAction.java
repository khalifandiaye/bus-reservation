package vn.edu.fpt.capstone.busReservation.action.bus;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;

public class AddAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private List<RouteBean> routeBeans = new ArrayList<RouteBean>();
	private List<BusTypeBean> busTypeBeans = new ArrayList<BusTypeBean>();
	
	private RouteDAO routeDAO;
	private BusTypeDAO busTypeDAO;

	public String execute() {
		routeBeans = routeDAO.getAll();
		busTypeBeans = busTypeDAO.getAll();
		return SUCCESS;
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

	public RouteDAO getRouteDAO() {
		return routeDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}

	public List<RouteBean> getRouteBeans() {
		return routeBeans;
	}

	public void setRouteBeans(List<RouteBean> routeBeans) {
		this.routeBeans = routeBeans;
	}
}
