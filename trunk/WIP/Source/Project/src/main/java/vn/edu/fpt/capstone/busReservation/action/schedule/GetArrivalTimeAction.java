package vn.edu.fpt.capstone.busReservation.action.schedule;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentTravelTimeDAO;
import vn.edu.fpt.capstone.busReservation.dao.SystemSettingDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentTravelTimeBean;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

@ParentPackage("jsonPackage")
public class GetArrivalTimeAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private int routeId;
	private String departureTime;
	private String arrivalTime;

	private RouteDAO routeDAO;
	private SegmentTravelTimeDAO segmentTravelTimeDAO;
	private SystemSettingDAO systemSettingDAO;

	@Action(value = "getArrivalTime", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		try {
			Date startDate = FormatUtils.deFormatDate(departureTime,
					"HH:mm - dd/MM/yyyy", CommonConstant.LOCALE_US,
					CommonConstant.DEFAULT_TIME_ZONE);
			long delayTime = (long) systemSettingDAO.getStationDelayTime() * 60;
			
			long traTime = 0;
			RouteBean routeBean = routeDAO.getById(routeId);

			List<RouteDetailsBean> routeDetailsBeans = routeBean
					.getRouteDetails();
			// list start date of each segment (required to get valid travel
			// time of each segment)
			List<Date> startDateOfSegment = new ArrayList<Date>();
			startDateOfSegment.add(startDate);
			// list endDate of each segment (startDate + traveltime)
			List<Date> endDateOfSegment = new ArrayList<Date>();

			int i = 0;
			for (RouteDetailsBean routeDetailsBean : routeDetailsBeans) {
			   List<SegmentTravelTimeBean> segmentTravelTimeBeans = segmentTravelTimeDAO.getTravelTimebyDate(
                  routeDetailsBean.getSegment().getId(),
                  startDateOfSegment.get(i));
			   if (segmentTravelTimeBeans.size() != 0) {
			      traTime = segmentTravelTimeBeans.get(0).getTravelTime();
			   }

				Date newEndDate = new Date(startDateOfSegment.get(i).getTime() + traTime);
				endDateOfSegment.add(newEndDate);
				if (i < (routeDetailsBeans.size() - 1)) {
					Date newStartDate = new Date(endDateOfSegment.get(i).getTime() + delayTime);
					startDateOfSegment.add(newStartDate);
				}
				i++;
			}

			Date endDate = endDateOfSegment.get(endDateOfSegment.size()-1);
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(endDate);
			arrivalTime = FormatUtils.formatDate(cal.getTime(),
					"HH:mm - dd/MM/yyyy", CommonConstant.LOCALE_US,
					CommonConstant.DEFAULT_TIME_ZONE);
		} catch (Exception e) {
		}
		return SUCCESS;
	}

	public void setSystemSettingDAO(SystemSettingDAO systemSettingDAO) {
		this.systemSettingDAO = systemSettingDAO;
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
