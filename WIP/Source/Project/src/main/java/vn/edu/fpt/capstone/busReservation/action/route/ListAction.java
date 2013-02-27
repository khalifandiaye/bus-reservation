package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.displayModel.RouteDetailsInfo;

import com.opensymphony.xwork2.ActionSupport;

public class ListAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private RouteDAO routeDAO;
	private List<RouteBean> routeBeans = new ArrayList<RouteBean>();
	private List<RouteDetailsInfo> routeInfos = new ArrayList<RouteDetailsInfo>();

	public String execute() {
		routeBeans = routeDAO.getAllActiveRoute();
		for (RouteBean routeBean : routeBeans) {
			RouteDetailsInfo routeDetailsInfo = new RouteDetailsInfo();
			int routeId = routeBean.getId();
			routeDetailsInfo.setId(routeId);
			routeDetailsInfo.setRouteName(routeBean.getName());
			routeDetailsInfo.setTravelTime(routeDAO.getTravelTimeByRouteId(routeId));
			routeInfos.add(routeDetailsInfo);
		}
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

	public List<RouteDetailsInfo> getRouteInfos() {
		return routeInfos;
	}

	public void setRouteInfos(List<RouteDetailsInfo> routeInfos) {
		this.routeInfos = routeInfos;
	}
}
