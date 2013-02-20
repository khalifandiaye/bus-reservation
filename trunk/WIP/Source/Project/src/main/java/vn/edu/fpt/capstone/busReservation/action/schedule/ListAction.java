package vn.edu.fpt.capstone.busReservation.action.schedule;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;

import com.opensymphony.xwork2.ActionSupport;

public class ListAction extends ActionSupport {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8867777710173565274L;

	private BusStatusDAO busStatusDAO;
	private RouteDAO routeDAO;
	private BusTypeDAO busTypeDAO;
	
	private List<BusTypeBean> busTypeBeans = new ArrayList<BusTypeBean>();
	private List<RouteBean> routeBeans = new ArrayList<RouteBean>();
	private List<BusStatusBean> busStatusBeans = new ArrayList<BusStatusBean>();

	public String execute() {
		busTypeBeans = busTypeDAO.getAll();
		busStatusBeans = busStatusDAO.getAll();
		routeBeans = routeDAO.getAll();
		return SUCCESS;
	}

	public BusStatusDAO getBusStatusDAO() {
		return busStatusDAO;
	}

	public void setBusStatusDAO(BusStatusDAO busStatusDAO) {
		this.busStatusDAO = busStatusDAO;
	}
	
	public List<BusStatusBean> getBusStatusBeans() {
		return busStatusBeans;
	}

	public void setBusStatusBeans(List<BusStatusBean> busStatusBeans) {
		this.busStatusBeans = busStatusBeans;
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
