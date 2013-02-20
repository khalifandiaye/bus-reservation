package vn.edu.fpt.capstone.busReservation.action.schedule;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.StationDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;

import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("jsonPackage")
public class SaveAction extends ActionSupport{
		
	private static final long serialVersionUID = 3916263183042873075L;
	private int routeBeans;
	private String tripDialogDepartureTime;
	private String tripDialogArrivalTime;
	private int tripDialogBusPlate;
	private BusDAO busDAO;
	private RouteDAO routeDAO;
	private RouteDetailsDAO routeDetailsDAO;
	private TripDAO tripDAO;
	private BusStatusDAO busStatusDAO;
	private StationDAO stationDAO;
	
	public StationDAO getStationDAO() {
		return stationDAO;
	}

	public void setStationDAO(StationDAO stationDAO) {
		this.stationDAO = stationDAO;
	}

	@Action(value = "/save", results = { @Result(type = "json", name = SUCCESS, params = {
            "root", "busInfos" }) })
	public String execute() throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd - hh:mm");
		Calendar calendar = Calendar.getInstance();
		
		Date fromDate = sdf.parse(tripDialogDepartureTime);
		long traTime = 0;
		calendar.setTime(fromDate);
		List<RouteDetailsBean> routeDetailsList = routeDAO.getById(routeBeans).getRouteDetails();
		for (RouteDetailsBean bean : routeDetailsList) {
			traTime += bean.getSegment().getTravelTime().getTime();
		}
		;
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(traTime);
		calendar.add(Calendar.MINUTE, cal.get(Calendar.MINUTE));
		calendar.add(Calendar.HOUR, cal.get(Calendar.HOUR));
		Date toDate = calendar.getTime();
		
		BusStatusBean busStatusBean = new BusStatusBean();
		BusBean busBean = busDAO.getById(tripDialogBusPlate);
		busStatusBean.setBus(busBean);
		busStatusBean.setBusStatus("ontrip");
		busStatusBean.setFromDate(fromDate);
		busStatusBean.setToDate(toDate);
		busStatusBean.setStatus("");
		StationBean stationBean = stationDAO.getById(1);
		busStatusBean.setEndStation(stationBean);
		
		RouteDetailsBean routeDetailsBean = routeDetailsDAO
				.getById(routeDetailsList.get(routeDetailsList.size() - 1)
						.getSegment().getId());
		TripBean trip = new TripBean();
		trip.setDepartureTime(fromDate);
		trip.setBusStatus(busStatusBean);
		trip.setArrivalTime(toDate);
		trip.setStatus("active");
		trip.setRouteDetails(routeDetailsBean);
		List<ReservationBean> reservations = new ArrayList<ReservationBean>();
		trip.setReservations(reservations);
		busStatusDAO.insert(busStatusBean);
		tripDAO.insert(trip);
		return SUCCESS;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}

	public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
		this.routeDetailsDAO = routeDetailsDAO;
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

	public String getTripDialogArrivalTime() {
		return tripDialogArrivalTime;
	}

	public void setTripDialogArrivalTime(String tripDialogArrivalTime) {
		this.tripDialogArrivalTime = tripDialogArrivalTime;
	}

	public int getTripDialogBusPlate() {
		return tripDialogBusPlate;
	}

	public void setTripDialogBusPlate(int tripDialogBusPlate) {
		this.tripDialogBusPlate = tripDialogBusPlate;
	}

}
