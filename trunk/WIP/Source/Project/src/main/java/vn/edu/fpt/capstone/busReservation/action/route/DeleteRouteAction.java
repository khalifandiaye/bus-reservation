package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.Calendar;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;

@ParentPackage("jsonPackage")
public class DeleteRouteAction extends BaseAction {

	private static final long serialVersionUID = -1900533216154623510L;

	private BusStatusDAO busStatusDAO;
	private RouteDAO routeDAO;
	private RouteDetailsDAO routeDetailsDAO;

	private BusDAO busDAO;

	private int routeId;

	private String message;

	@Action(value = "/deleteRoute", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		List<Integer> routeTerminals = routeDAO.getRouteTerminal(routeId);
		List<BusStatusBean> busStatusBeansForward = busStatusDAO
				.getAllAvailTripByRouteId(routeTerminals.get(0), Calendar
						.getInstance().getTime());
		List<BusStatusBean> busStatusBeansReturn = busStatusDAO
				.getAllAvailTripByRouteId(routeTerminals.get(1), Calendar
						.getInstance().getTime());
		if ((busStatusBeansForward.size() + busStatusBeansReturn.size()) == 0) {

			// unassigned buses
			List<BusBean> busBeans = busDAO.getBusByRouteId(routeTerminals
					.get(0));
			for (BusBean busBean : busBeans) {
				busBean.setForwardRoute(null);
				busBean.setReturnRoute(null);
				busDAO.update(busBean);
			}

			// delete route and its return

			RouteBean routeBeanForward = routeDAO
					.getById(routeTerminals.get(0));
			RouteBean routeBeanReturn = routeDAO.getById(routeTerminals.get(1));

			// check if routes has any trips
			List<BusStatusBean> busStatusBeansAllForward = busStatusDAO
					.getAllTripsByRouteId(routeBeanForward.getId());
			List<BusStatusBean> busStatusBeansAllReturn = busStatusDAO
					.getAllTripsByRouteId(routeBeanReturn.getId());

			// check if route has any busStatus
			if ((busStatusBeansAllForward.size() + busStatusBeansAllReturn
					.size()) == 0) {
				// delete if has no busStatus (ontrip)
				// remove routeDetail
				int deleteRouteDetailsResultForward = 0;
				deleteRouteDetailsResultForward = routeDetailsDAO
						.deleteRouteDetailByRouteId(routeBeanForward.getId());
				int deleteRouteDetailsResultReturn = 0;
				deleteRouteDetailsResultReturn = routeDetailsDAO
						.deleteRouteDetailByRouteId(routeBeanReturn.getId());
				if (deleteRouteDetailsResultForward != 0
						&& deleteRouteDetailsResultReturn != 0
						&& deleteRouteDetailsResultForward == deleteRouteDetailsResultReturn) {
					int deleteRouteResultForward = 0;
					int deleteRouteResultReturn = 0;
					deleteRouteResultForward = routeDAO.deleteRouteByRouteId(routeBeanForward.getId());
					deleteRouteResultReturn = routeDAO.deleteRouteByRouteId(routeBeanReturn.getId());			
					if(deleteRouteResultForward != 0
						&& deleteRouteResultReturn != 0
						&& deleteRouteResultForward == deleteRouteResultReturn){
						message = "Delete route success ";
					}						
				}
			} else {
				// disable if has at least 1 busStatus (ontrip)
				routeBeanForward.setStatus("inactive");
				routeBeanReturn.setStatus("inactive");
				routeDAO.update(routeBeanForward);
				routeDAO.update(routeBeanReturn);
				message = "Route "
						+ routeBeanForward.getName()
						+ " and route "
						+ routeBeanReturn.getName()
						+ " are deleted successfully! All buses belong to these routes are unassigned successfully!";
			}
		} else if (busStatusBeansForward.size() > 0
				|| busStatusBeansReturn.size() > 0) {
			message = "Cannot delete this route due to this route has "
					+ (busStatusBeansForward.size() + busStatusBeansReturn
							.size()) + " available trip(s) depend on it";
		}
		return SUCCESS;
	}

	public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
		this.routeDetailsDAO = routeDetailsDAO;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

	public String getMessage() {
		return message;
	}

	public void setBusStatusDAO(BusStatusDAO busStatusDAO) {
		this.busStatusDAO = busStatusDAO;
	}
}
