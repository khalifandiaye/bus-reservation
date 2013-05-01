package vn.edu.fpt.capstone.busReservation.action.schedule;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentTravelTimeDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentTravelTimeBean;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

@ParentPackage("jsonPackage")
public class GetAutoReturnArrivalTimeAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private int routeId;
	private String departureTime;
	private String arrivalTime;

	private RouteDAO routeDAO;
	private SegmentTravelTimeDAO segmentTravelTimeDAO;

	@Action(value = "getAutoReturnArrivalTime", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		try {
			Date fromDate = FormatUtils.deFormatDate(departureTime,
					"HH:mm - dd/MM/yyyy", CommonConstant.LOCALE_US,
					CommonConstant.DEFAULT_TIME_ZONE);
			List<RouteDetailsBean> routeDetailsList = routeDAO.getById(routeId).getRouteDetails();
			
			long traTime = 0;
			
			for (RouteDetailsBean routeDetailsBean : routeDetailsList) {
				List<SegmentTravelTimeBean> segmentTravelTimeBeans = segmentTravelTimeDAO
						.getExistDuration(routeDetailsBean.getSegment().getId(),
								fromDate);
				if (segmentTravelTimeBeans.size() != 0) {
					traTime += segmentTravelTimeBeans.get(0).getTravelTime();
					fromDate = new Date(fromDate.getTime() + traTime);
				}
			}
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(fromDate);
			arrivalTime = FormatUtils.formatDate(cal.getTime(),
					"HH:mm - dd/MM/yyyy", CommonConstant.LOCALE_US,
					CommonConstant.DEFAULT_TIME_ZONE);
		} catch (Exception e) {
		}
		return SUCCESS;
	}

	public void setSegmentTravelTimeDAO(
			SegmentTravelTimeDAO segmentTravelTimeDAO) {
		this.segmentTravelTimeDAO = segmentTravelTimeDAO;
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
}
