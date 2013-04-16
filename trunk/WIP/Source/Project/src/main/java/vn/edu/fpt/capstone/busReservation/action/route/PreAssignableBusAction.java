package vn.edu.fpt.capstone.busReservation.action.route;


import java.util.Calendar;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.TariffDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;

@ParentPackage("jsonPackage")
public class PreAssignableBusAction extends BaseAction {

	private static final long serialVersionUID = 5439903464802687338L;
	private TariffDAO tariffDAO;
	private RouteDetailsDAO routeDetailsDAO;
	private RouteDAO routeDAO;
	
	private int routeId;
	private int busType;

	private String message = "";
	private boolean isAssignable = false;

	@Action(value = "getPreAssignableBus", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		int routeReturnId = routeDAO.getRouteTerminal(routeId).get(1);

		if(!isHasTariff(routeId, busType)){
			message = "Please add tariff for this type of bus in current date before assign bus! ";
		}
		else if (!isHasTariff(routeReturnId, busType)){
			message = "Please add tariff of returned route for this type of bus in current time before assign bus! ";
		} else {
			isAssignable = true;
		}

		return SUCCESS;
	}
	
	public boolean isHasTariff(int routeId, int busType) {
		List<SegmentBean> segmentBeans = routeDetailsDAO.getAllSegmemtsByRouteId(routeId);
		for (SegmentBean segmentBean : segmentBeans) {
			List<TariffBean> tariffBeans = tariffDAO.getPrice(
					segmentBean.getId(), busType, Calendar.getInstance()
							.getTime());
			if((tariffBeans.size() == 0) || (tariffBeans.get(0).getFare() == 0)){
				return false;
			} 
		}
		return true;
	}


	public boolean isAssignable() {
		return isAssignable;
	}

	public void setTariffDAO(TariffDAO tariffDAO) {
		this.tariffDAO = tariffDAO;
	}

	public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
		this.routeDetailsDAO = routeDetailsDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

	public void setBusType(int busType) {
		this.busType = busType;
	}

	public String getMessage() {
		return message;
	}

}
