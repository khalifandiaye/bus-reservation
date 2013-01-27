package vn.edu.fpt.capstone.busReservation.action.trip;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

import com.opensymphony.xwork2.ActionSupport;

public class CreateAction extends ActionSupport {

	private static final long serialVersionUID = -3011774811591225472L;
	private RouteDAO routeDAO;
	private Map<Integer, String> routeList = new LinkedHashMap<Integer, String>();
	
	public String execute(){
		List<RouteBean> routeBeans = routeDAO.getAll();
		List<SegmentBean> segmentBeans = routeDAO.getAllSegmentByRouteId(1);
		
		//get routeID & routeName into routeMap
		for (RouteBean routeBean : routeBeans) {
			if (routeBean.getStatus() != null
					&& routeBean.getStatus().equals("active"))
			routeList.put(routeBean.getId(), routeBean.getName());
		}
		
		return SUCCESS;
	}
	
	public Map<Integer, String> getRouteList() {
		return routeList;
	}

	public void setRouteList(Map<Integer, String> routeList) {
		this.routeList = routeList;
	}

	public RouteDAO getRouteDAO() {
		return routeDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}
}
