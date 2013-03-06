package vn.edu.fpt.capstone.busReservation.action.route;

import java.text.ParseException;
import java.util.Calendar;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.json.JSONException;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;

@ParentPackage("jsonPackage")
public class DeleteRouteAction extends BaseAction {

	private static final long serialVersionUID = -1900533216154623510L;

	private BusStatusDAO busStatusDAO;
	private RouteDAO routeDAO;
	private BusDAO busDAO;

	private int routeId;

	private String message;

	@Action(value = "/deleteRoute", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() throws ParseException, JSONException {
		List<Object[]> routeTerminals = routeDAO.getRouteTerminal(routeId);
		List<BusStatusBean> busStatusBeansForward = busStatusDAO
				.getAllAvailTripByRouteId((Integer) routeTerminals.get(0)[0],
						Calendar.getInstance().getTime());
		List<BusStatusBean> busStatusBeansReturn = busStatusDAO
				.getAllAvailTripByRouteId((Integer) routeTerminals.get(0)[1],
						Calendar.getInstance().getTime());
		if ((busStatusBeansForward.size() + busStatusBeansReturn.size()) == 0) {
			
			//unassigned buses
			List<BusBean> busBeans = busDAO.getBusByRouteId((Integer) routeTerminals.get(0)[0]);
			for (BusBean busBean : busBeans) {
				busBean.setForwardRoute(null);
				busBean.setReturnRoute(null);
				busDAO.update(busBean);
			}
			
			//delete route and its return
			RouteBean routeBeanForward = routeDAO.getById((Integer) routeTerminals.get(0)[0]);
			RouteBean routeBeanReturn = routeDAO.getById((Integer) routeTerminals.get(0)[1]);
			routeBeanForward.setStatus("inactive");
			routeBeanReturn.setStatus("inactive");
			routeDAO.update(routeBeanForward);
			routeDAO.update(routeBeanReturn);
			
			message = "Route " + routeBeanForward.getName() +" and route " + routeBeanReturn.getName() +
					" are deleted successfully! All buses belong to these routes are unassigned successfully!";
		}
		else if(busStatusBeansForward.size() > 0 || busStatusBeansReturn.size() > 0){
			message = "Cannot delete this route due to this route has " + (busStatusBeansForward.size() + busStatusBeansReturn.size()) +
					" available trip(s) depend on it";
		}
		return SUCCESS;
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
