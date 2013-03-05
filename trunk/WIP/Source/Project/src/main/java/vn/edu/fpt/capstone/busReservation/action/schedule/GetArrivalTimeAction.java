package vn.edu.fpt.capstone.busReservation.action.schedule;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

@ParentPackage("jsonPackage")
public class GetArrivalTimeAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	private int routeId;
	private String departureTime;
	private String arrivalTime;

	private RouteDAO routeDAO;

	@Action(value = "getArrivalTime", results = { @Result(type = "json", name = SUCCESS ) })
	public String execute() throws ParseException {
		
		Date startDate = FormatUtils.deFormatDate(departureTime, "yyyy/MM/dd - hh:mm", CommonConstant.LOCALE_US, CommonConstant.DEFAULT_TIME_ZONE);
		long traTime = 0;
		RouteBean routeBean = routeDAO.getById(routeId);
		
		List<RouteDetailsBean> routeDetailsBeans = routeBean.getRouteDetails();
		for (RouteDetailsBean routeDetailsBean: routeDetailsBeans) {
			traTime += routeDetailsBean.getSegment().getTravelTime();
		}
		
		Date endDate = new Date(startDate.getTime() + traTime);
		Calendar cal = Calendar.getInstance();
		cal.setTime(endDate);
		arrivalTime = FormatUtils.formatDate(cal.getTime(), "yyyy/MM/dd - HH:mm", CommonConstant.LOCALE_US, CommonConstant.DEFAULT_TIME_ZONE);
		
		return SUCCESS;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}
	
	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}

	public void setDepartureTime(String departureTime) {
		this.departureTime = departureTime;
	}
	
	public String getArrivalTime() {
		return arrivalTime;
	}

	public void setArrivalTime(String arrivalTime) {
		this.arrivalTime = arrivalTime;
	}
}
