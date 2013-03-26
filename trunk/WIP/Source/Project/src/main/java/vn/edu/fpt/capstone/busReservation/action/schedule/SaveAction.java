package vn.edu.fpt.capstone.busReservation.action.schedule;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentTravelTimeDAO;
import vn.edu.fpt.capstone.busReservation.dao.SystemSettingDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("jsonPackage")
public class SaveAction extends ActionSupport {

	private static final long serialVersionUID = 3916263183042873075L;
	private int routeBeans;
	private String tripDialogDepartureTime;
	private String message;
	private int tripDialogBusPlate;

	private BusDAO busDAO;
	private RouteDAO routeDAO;
	private TripDAO tripDAO;
	private BusStatusDAO busStatusDAO;
	private SystemSettingDAO systemSettingDAO;
	private SegmentTravelTimeDAO segmentTravelTimeDAO;

	@Action(value = "save", results = { @Result(type = "json", name = SUCCESS, params = {
			"root", "message" }) })
	public String execute() {
		try {
			Date fromDate = FormatUtils.deFormatDate(tripDialogDepartureTime,
					"yyyy/MM/dd - hh:mm", CommonConstant.LOCALE_US,
					CommonConstant.DEFAULT_TIME_ZONE);

			// cannot get tripDialogArrivalTime: GUI issue

			long delayTime = (long) systemSettingDAO.getStationDelayTime() * 60 * 1000;
			List<RouteDetailsBean> routeDetailsList = routeDAO.getById(
					routeBeans).getRouteDetails();
			// list start date of each segment (required to get valid travel
			// time of each segment)
			List<Date> startDateOfSegment = new ArrayList<Date>();
			startDateOfSegment.add(fromDate);
			//list endDate of each segment (startDate + traveltime)
			List<Date> endDateOfSegment = new ArrayList<Date>();

			long traTime = 0;
			int i = 0;
			for (RouteDetailsBean routeDetailsBean : routeDetailsList) {
				traTime = segmentTravelTimeDAO.getTravelTimebyDate(
								routeDetailsBean.getSegment().getId(),
								startDateOfSegment.get(i)).get(0).getTravelTime();

				Date newEndDate = new Date(startDateOfSegment.get(i).getTime()+ traTime);
				endDateOfSegment.add(newEndDate);
				if (i < (routeDetailsList.size() - 1)) {
					Date newStartDate = new Date(endDateOfSegment.get(i).getTime() + delayTime);
					startDateOfSegment.add(newStartDate);
				}
				i++;
			}

			Date toDate = endDateOfSegment.get(endDateOfSegment.size()-1);

			BusStatusBean busStatusBean = new BusStatusBean();
			BusBean busBean = busDAO.getById(tripDialogBusPlate);
			busStatusBean.setBus(busBean);
			busStatusBean.setBusStatus("ontrip");
			busStatusBean.setFromDate(fromDate);
			busStatusBean.setToDate(toDate);
			busStatusBean.setStatus("active");
			busStatusBean.setEndStation(routeDetailsList
					.get(routeDetailsList.size() - 1).getSegment().getEndAt());
			busStatusDAO.insert(busStatusBean);

			// time travel
			i = 0;
			for (RouteDetailsBean routeDetailsBean : routeDetailsList) {
				TripBean trip = new TripBean();
				trip.setDepartureTime(startDateOfSegment.get(i));
				trip.setBusStatus(busStatusBean);
				trip.setArrivalTime(endDateOfSegment.get(i));
				trip.setRouteDetails(routeDetailsBean);
				tripDAO.insert(trip);
				i++;
			}
			message = "Add schedule Success!";
		} catch (Exception ex) {
			message = "Error! Please try again!";
			ex.printStackTrace();
		}
		return SUCCESS;
	}

	public void setSegmentTravelTimeDAO(
			SegmentTravelTimeDAO segmentTravelTimeDAO) {
		this.segmentTravelTimeDAO = segmentTravelTimeDAO;
	}

	public void setSystemSettingDAO(SystemSettingDAO systemSettingDAO) {
		this.systemSettingDAO = systemSettingDAO;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}

	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
	}

	public void setBusStatusDAO(BusStatusDAO busStatusDAO) {
		this.busStatusDAO = busStatusDAO;
	}

	public void setRouteBeans(int routeBeans) {
		this.routeBeans = routeBeans;
	}

	public void setTripDialogDepartureTime(String tripDialogDepartureTime) {
		this.tripDialogDepartureTime = tripDialogDepartureTime;
	}

	public void setTripDialogBusPlate(int tripDialogBusPlate) {
		this.tripDialogBusPlate = tripDialogBusPlate;
	}

	public String getMessage() {
		return message;
	}
}
