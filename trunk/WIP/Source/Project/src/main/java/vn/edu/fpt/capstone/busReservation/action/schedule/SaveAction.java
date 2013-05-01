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
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentTravelTimeBean;
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
	private int tripDialogBusPlateExtends;

	private String autoReturnBus;
	private String autoReturnDepartureTime;
	private String allowBooking;
	private String avaiBusList;


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
					"HH:mm - dd/MM/yyyy", CommonConstant.LOCALE_US,
					CommonConstant.DEFAULT_TIME_ZONE);
			BusBean busBean = new BusBean();
			
			if ("busInRoute".equals(avaiBusList)) {
				busBean = busDAO.getById(tripDialogBusPlate);
			} else {
				busBean = busDAO.getById(tripDialogBusPlateExtends);
			}
			
			List<RouteDetailsBean> routeDetailsList = routeDAO.getById(
					routeBeans).getRouteDetails();
			message = avaiBusList;

			// check if bus_status is duplicated in DB
			List<BusStatusBean> busStatusBeans = busStatusDAO
					.getDuplicatedBusAndDate(busBean, fromDate,
							routeDetailsList.get(routeDetailsList.size() - 1)
									.getSegment().getEndAt());

			boolean isUpdated = false;
			for (int i = 0; i < busStatusBeans.size(); i++) {
				if (busStatusBeans.get(i).getTrips().get(0).getRouteDetails()
						.getRoute().getId() == routeBeans) {
					busStatusBeans.get(0).setStatus("active");
					busStatusDAO.update(busStatusBeans.get(0));
					message = "Add schedule Success!";
					isUpdated = true;
				}
			}
			if (!isUpdated) {
				addNewSchedule(fromDate, busBean, routeDetailsList);
			}

			if ("on".equals(autoReturnBus)) {

				Date fromDateReturn = FormatUtils.deFormatDate(
						autoReturnDepartureTime, "HH:mm - dd/MM/yyyy",
						CommonConstant.LOCALE_US,
						CommonConstant.DEFAULT_TIME_ZONE);
				RouteBean reverseRoute = routeDAO.getById(routeDAO.getRouteTerminal(routeBeans).get(1));
				List<RouteDetailsBean> reverseRouteDetails = reverseRoute.getRouteDetails();
				if ("on".equals(allowBooking)) {
					addNewSchedule(fromDateReturn, busBean, reverseRouteDetails);
				} else {
					addAutoReturnSchedule(fromDateReturn, busBean, reverseRouteDetails);
				}
			}

		} catch (Exception ex) {
			message = "Error! Please try again!";
			ex.printStackTrace();
		}
		return SUCCESS;
	}

	public void addAutoReturnSchedule(Date fromDate, BusBean busBean,
			List<RouteDetailsBean> routeDetailsList) {
		// list start date of each segment (required to get valid travel
		// time of each segment)
		long traTime = 0;
		Date startDate = fromDate;
		Date endDate = fromDate;
		for (RouteDetailsBean routeDetailsBean : routeDetailsList) {
			List<SegmentTravelTimeBean> segmentTravelTimeBeans = segmentTravelTimeDAO
					.getExistDuration(routeDetailsBean.getSegment().getId(),
							endDate);
			if (segmentTravelTimeBeans.size() != 0) {
				traTime += segmentTravelTimeBeans.get(0).getTravelTime();
				endDate = new Date(endDate.getTime() + traTime);
			} else {
				message = "Cannot get segment travel time of segment "
						+ routeDetailsBean.getSegment().getId();
			}
		}

		BusStatusBean busStatusBean = new BusStatusBean();
		busStatusBean.setBus(busBean);
		busStatusBean.setBusStatus("return");
		busStatusBean.setFromDate(startDate);
		busStatusBean.setToDate(endDate);
		busStatusBean.setStatus("active");
		busStatusBean.setEndStation(routeDetailsList
				.get(routeDetailsList.size() - 1).getSegment().getEndAt());
		busStatusDAO.insert(busStatusBean);
	}

	public void addNewSchedule(Date fromDate, BusBean busBean,
			List<RouteDetailsBean> routeDetailsList) {
		try {
			long delayTime = (long) systemSettingDAO.getStationDelayTime() * 60 * 1000;

			// list start date of each segment (required to get valid travel
			// time of each segment)
			List<Date> startDateOfSegment = new ArrayList<Date>();
			startDateOfSegment.add(fromDate);
			List<Date> endDateOfSegment = new ArrayList<Date>();

			long traTime = 0;
			int i = 0;
			for (RouteDetailsBean routeDetailsBean : routeDetailsList) {
				traTime = segmentTravelTimeDAO
						.getTravelTimebyDate(
								routeDetailsBean.getSegment().getId(),
								startDateOfSegment.get(i)).get(0)
						.getTravelTime();
				List<SegmentTravelTimeBean> segmentTravelTimeBeans = segmentTravelTimeDAO
						.getTravelTimebyDate(routeDetailsBean.getSegment()
								.getId(), startDateOfSegment.get(i));
				if (segmentTravelTimeBeans.size() != 0) {
					traTime = segmentTravelTimeBeans.get(0).getTravelTime();
				}

				Date newEndDate = new Date(startDateOfSegment.get(i).getTime()
						+ traTime);
				endDateOfSegment.add(newEndDate);
				if (i < (routeDetailsList.size() - 1)) {
					Date newStartDate = new Date(endDateOfSegment.get(i)
							.getTime() + delayTime);
					startDateOfSegment.add(newStartDate);
				}
				i++;
			}

			Date toDate = endDateOfSegment.get(endDateOfSegment.size() - 1);

			BusStatusBean busStatusBean = new BusStatusBean();
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
	}


	
	public void setAvaiBusList(String avaiBusList) {
		this.avaiBusList = avaiBusList;
	}

	public void setAutoReturnBus(String autoReturnBus) {
		this.autoReturnBus = autoReturnBus;
	}

	public void setAutoReturnDepartureTime(String autoReturnDepartureTime) {
		this.autoReturnDepartureTime = autoReturnDepartureTime;
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

	public void setTripDialogBusPlateExtends(int tripDialogBusPlateExtends) {
		this.tripDialogBusPlateExtends = tripDialogBusPlateExtends;
	}


	public String getMessage() {
		return message;
	}

	public void setAllowBooking(String allowBooking) {
		this.allowBooking = allowBooking;
	}
}
