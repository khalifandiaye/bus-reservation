package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

@ParentPackage("jsonPackage")
public class PreUpdateTariffAction extends BaseAction {

	private static final long serialVersionUID = 5439903464802687338L;
	private RouteDetailsDAO routeDetailsDAO;

	private List<SegmentBean> segmentBeans;
	private String message;

	@Action(value = "getPreUpdateTariffAction", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		//get route each segment
		message = "";
		for (SegmentBean segmentBean : segmentBeans){
			List<RouteBean> routeBeans = routeDetailsDAO.getAllRoutesBySegmentId(segmentBean.getId());
			for (RouteBean routeBean : routeBeans){
				message = routeBean.getName() + " (affected segment: " + segmentBean.getStartAt().getName() +  
						" - " + segmentBean.getEndAt().getName() + " ) <\br>";
			}
		}
		return SUCCESS;
	}

	public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
		this.routeDetailsDAO = routeDetailsDAO;
	}

	public void setSegmentBeans(List<SegmentBean> segmentBeans) {
		this.segmentBeans = segmentBeans;
	}

	public String getMessage() {
		return message;
	}

}
