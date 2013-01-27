package vn.edu.fpt.capstone.busReservation.action.trip;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;

import com.opensymphony.xwork2.ActionSupport;

public class CreateAction extends ActionSupport {
	private RouteDAO routeDAO;
	
	public String execute(){
		List<RouteBean> routeBeans = null;
		routeBeans = routeDAO.getAll();
		routeList = new HashMap<Integer, String>();
		
		//get routeID & routeName into routeMap
		for (RouteBean routeBean : routeBeans) {
			routeList.put(routeBean.getId(), routeBean.getName());
		}
		
		return SUCCESS;
	}
	private Map<Integer, String> routeList;
	
	public Map<Integer, String> getRouteList() {
		return routeList;
	}

	public void setRouteList(Map<Integer, String> routeList) {
		this.routeList = routeList;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}
}
