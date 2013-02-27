package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;

import com.opensymphony.xwork2.ActionSupport;

public class ListAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private RouteDAO routeDAO;
	private List<RouteBean> routeBeans = new ArrayList<RouteBean>();

	public String execute() {
		routeBeans = routeDAO.getAllActiveRoute();
		return SUCCESS;
	}

	public List<RouteBean> getRouteBeans() {
		return routeBeans;
	}

	public RouteDAO getRouteDAO() {
		return routeDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}
}
