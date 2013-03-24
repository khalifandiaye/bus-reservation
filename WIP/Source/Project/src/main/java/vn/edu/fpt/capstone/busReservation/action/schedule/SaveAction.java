package vn.edu.fpt.capstone.busReservation.action.schedule;

import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
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

	@Action(value = "save", results = { @Result(type = "json", name = SUCCESS, params = {
			"root", "message" }) })
	public String execute() {
		try {
			Date fromDate = FormatUtils.deFormatDate(tripDialogDepartureTime,
					"yyyy/MM/dd - hh:mm", CommonConstant.LOCALE_US,
					CommonConstant.DEFAULT_TIME_ZONE);

			// cannot get tripDialogArrivalTime: GUI issue
			long traTime = 0;
			long delayTime = (long) systemSettingDAO.getStationDelayTime() * 60;
			List<RouteDetailsBean> routeDetailsList = routeDAO.getById(
					routeBeans).getRouteDetails();

			for (RouteDetailsBean routeDetailsBean : routeDetailsList) {
				traTime += routeDetailsBean.getSegment().getTravelTime();
			}
			for (int i = 0; i < (routeDetailsList.size() -1); i++) {
				traTime += delayTime;
			}
			
			Date toDate = new Date(fromDate.getTime() + traTime);

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
			long traDate = fromDate.getTime();

			int i=0;
			for (RouteDetailsBean routeDetailsBean : routeDetailsList) {
				TripBean trip = new TripBean();
				Date travelDate = new Date(traDate);
				trip.setDepartureTime(travelDate);
				trip.setBusStatus(busStatusBean);
				// calculate arrival time for each segment
				traDate += routeDetailsBean.getSegment().getTravelTime();
				if (i< (routeDetailsList.size() -1)){
					traDate += delayTime;
				}
				travelDate = new Date(traDate);
				trip.setArrivalTime(travelDate);
				trip.setRouteDetails(routeDetailsBean);
				tripDAO.insert(trip);
			}
			message = "Add schedule Success!";
		} catch (Exception ex) {
			message = "Error! Please try again!";
		}
		return SUCCESS;
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
