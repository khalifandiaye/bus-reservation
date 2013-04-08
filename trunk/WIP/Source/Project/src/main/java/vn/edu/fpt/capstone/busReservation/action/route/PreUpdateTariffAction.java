package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

@ParentPackage("jsonPackage")
public class PreUpdateTariffAction extends BaseAction {

	private static final long serialVersionUID = 5439903464802687338L;
	private RouteDetailsDAO routeDetailsDAO;
	private SegmentDAO segmentDAO;

	private int routeId;
	private int segmentId;

	private String message = "";

	@Action(value = "getPreUpdateTariffAction", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		// get route each segment
		List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();
		SegmentBean segmentBean = new SegmentBean();
		if (routeId != 0) {
			segmentBeans = routeDetailsDAO.getAllSegmemtsByRouteId(routeId);
		} else if (segmentId != 0) {
			segmentBean = segmentDAO.getById(segmentId);
		}
		if (segmentBeans.size() != 0) {
			
			for (SegmentBean segment : segmentBeans) {
				message = "Affected route ";
				
				List<RouteBean> routeBeans = routeDetailsDAO
						.getAllRoutesBySegmentId(segment.getId());

				for (RouteBean routeBean : routeBeans) {
					if (routeBean.getId() != routeId) {
						message += routeBean.getName() + " (affected segment: "
								+ segment.getStartAt().getName() + " - "
								+ segment.getEndAt().getName() + " ) \n";
					}
				}
			}
		} else if (segmentBean != null) {
			List<RouteBean> routeBeans = routeDetailsDAO
					.getAllRoutesBySegmentId(segmentBean.getId());

			for (RouteBean routeBean : routeBeans) {
				message = "Affected route: ";
				if (routeBean.getId() != routeId) {
					message += routeBean.getName() + "\n";
				}
			}
		}
		return SUCCESS;
	}

	public void setSegmentDAO(SegmentDAO segmentDAO) {
		this.segmentDAO = segmentDAO;
	}

	public void setSegmentId(int segmentId) {
		this.segmentId = segmentId;
	}

	public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
		this.routeDetailsDAO = routeDetailsDAO;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

	public String getMessage() {
		return message;
	}

}
