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
import vn.edu.fpt.capstone.busReservation.dao.StationDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.DateUtils;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("jsonPackage")
public class SaveAction extends ActionSupport{
		
	private static final long serialVersionUID = 3916263183042873075L;
	private int routeBeans;
	private String tripDialogDepartureTime;
	private String message;
	//private String tripDialogArrivalTime;
	private int tripDialogBusPlate;
	private BusDAO busDAO;
	private RouteDAO routeDAO;
	private TripDAO tripDAO;
	private BusStatusDAO busStatusDAO;
	private StationDAO stationDAO;
	
	public StationDAO getStationDAO() {
		return stationDAO;
	}

	public void setStationDAO(StationDAO stationDAO) {
		this.stationDAO = stationDAO;
	}

	@Action(value = "save", results = { @Result(type = "json", name = SUCCESS, params = {
            "root", "message" }) })
	public String execute() {
		try {
			Date fromDate = FormatUtils.deFormatDate(tripDialogDepartureTime, "yyyy/MM/dd - hh:mm", CommonConstant.LOCALE_US, CommonConstant.DEFAULT_TIME_ZONE);
			
			//cannot get tripDialogArrivalTime: GUI issue
			long traTime = 0;
			List<RouteDetailsBean> routeDetailsList = routeDAO.getById(routeBeans).getRouteDetails();
			for (RouteDetailsBean routeDetailsBean : routeDetailsList) {
				traTime += DateUtils.getAbsoluteMiliseconds(routeDetailsBean.getSegment().getTravelTime());
			}
			Date toDate = new Date(fromDate.getTime() + traTime);
			
			BusStatusBean busStatusBean = new BusStatusBean();
			BusBean busBean = busDAO.getById(tripDialogBusPlate);
			busStatusBean.setBus(busBean);
			busStatusBean.setBusStatus("ontrip");
			busStatusBean.setFromDate(fromDate);
			busStatusBean.setToDate(toDate);
			busStatusBean.setStatus("active");
			busStatusBean.setEndStation(routeDetailsList.get(routeDetailsList.size() - 1)
					.getSegment().getEndAt());
			busStatusDAO.insert(busStatusBean);
			
			//time travel
			long traDate = fromDate.getTime();
			
			for (RouteDetailsBean routeDetailsBean : routeDetailsList) {
				TripBean trip = new TripBean();
				Date travelDate = new Date(traDate);
				trip.setDepartureTime(travelDate);			
				trip.setBusStatus(busStatusBean);
				//calculate arrival time for each segment
				traDate += DateUtils.getAbsoluteMiliseconds(routeDetailsBean.getSegment().getTravelTime());
				travelDate = new Date(traDate);
				trip.setArrivalTime(travelDate);
				trip.setStatus("active");
				trip.setRouteDetails(routeDetailsBean);
				List<ReservationBean> reservations = new ArrayList<ReservationBean>();
				trip.setReservations(reservations);
				tripDAO.insert(trip);
			}
		} catch (Exception ex) {
			message = "Error! Please try again!";
		}
		message = "Add schedule Success!";
		return SUCCESS;
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

	public int getRouteBeans() {
		return routeBeans;
	}

	public void setRouteBeans(int routeBeans) {
		this.routeBeans = routeBeans;
	}

	public String getTripDialogDepartureTime() {
		return tripDialogDepartureTime;
	}

	public void setTripDialogDepartureTime(String tripDialogDepartureTime) {
		this.tripDialogDepartureTime = tripDialogDepartureTime;
	}

	/* cannot get tripDialogArrivalTime: GUI issue
	public String getTripDialogArrivalTime() {
		return tripDialogArrivalTime;
	}

	public void setTripDialogArrivalTime(String tripDialogArrivalTime) {
		this.tripDialogArrivalTime = tripDialogArrivalTime;
	}
	*/

	public int getTripDialogBusPlate() {
		return tripDialogBusPlate;
	}

	public void setTripDialogBusPlate(int tripDialogBusPlate) {
		this.tripDialogBusPlate = tripDialogBusPlate;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
