package vn.edu.fpt.capstone.busReservation.action.trip;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.displayModel.RouteDetailsInfo;

import com.opensymphony.xwork2.ActionSupport;

public class CreateAction extends ActionSupport {

	private static final long serialVersionUID = -3011774811591225472L;
	private RouteDAO routeDAO;
	private List<RouteDetailsInfo> routeDetailsInfos = new ArrayList<RouteDetailsInfo>();
	
	public String execute(){
		List<RouteBean> routeBeans = routeDAO.getAll();
		//get routeID & routeName into routeMap
		for (RouteBean routeBean : routeBeans) {
			if (routeBean.getStatus() != null && routeBean.getStatus().equals("active")) {
				RouteDetailsInfo routeDetailsInfo = new RouteDetailsInfo();
				int routeId = routeBean.getId();
				String travelTime = routeDAO.getAllSegmentByRouteId(routeId);
				routeDetailsInfo.setId(routeId);
				routeDetailsInfo.setRouteName(routeBean.getName());
				routeDetailsInfo.setTravelTime(travelTime);
				routeDetailsInfos.add(routeDetailsInfo);
			}
		}
		
		return SUCCESS;
	}
	
	public List<RouteDetailsInfo> getRouteDetailsInfos() {
		return routeDetailsInfos;
	}

	public void setRouteDetailsInfos(List<RouteDetailsInfo> routeDetailsInfos) {
		this.routeDetailsInfos = routeDetailsInfos;
	}
	
	public RouteDAO getRouteDAO() {
		return routeDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}
}
