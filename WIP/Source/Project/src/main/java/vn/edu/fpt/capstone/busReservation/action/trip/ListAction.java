package vn.edu.fpt.capstone.busReservation.action.trip;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;

import com.opensymphony.xwork2.ActionSupport;


public class ListAction extends ActionSupport {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5899749334637098391L;
	
	private TripDAO tripDAO;
	private BusTypeDAO busTypeDAO;
	private RouteDAO routeDAO;
	
	// BusStatus ID
	private int id;
	
	private List<BusTypeBean> busTypeBeans = new ArrayList<BusTypeBean>();
	private List<TripBean> tripBeans = new ArrayList<TripBean>();
	private List<RouteBean> routeBeans = new ArrayList<RouteBean>();

	public String execute() {
		busTypeBeans = busTypeDAO.getAll();
		tripBeans = tripDAO.getTripsByBusStatus(id);
		routeBeans = routeDAO.getAll();
		return SUCCESS;
	}

	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
	}

	public List<TripBean> getTripBeans() {
		return tripBeans;
	}

	public void setTripBeans(List<TripBean> tripBeans) {
		this.tripBeans = tripBeans;
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

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

}
