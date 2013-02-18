package vn.edu.fpt.capstone.busReservation.action.trip;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;

import com.opensymphony.xwork2.ActionSupport;

public class InsertNewTripAction extends ActionSupport{
		
	private static final long serialVersionUID = 3916263183042873075L;
	private int routeSelect;
	private String departDate;
	private String arriveDate;
	private int busPlateSelect;
	private BusDAO busDAO;
//	private EmployeeDAO employeeDAO;
	private RouteDAO routeDAO;
	private RouteDetailsDAO routeDetailsDAO;
	private TripDAO tripDAO;
	private BusStatusDAO busStatusDAO;
	
	public String execute() throws ParseException{
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd hh:mm");
//		Calendar calendar = Calendar.getInstance();
//		
//		Date fromDate = sdf.parse(departDate);
//		calendar.setTime(fromDate);
//		
//		String travelTime = routeDAO.getAllSegmentByRouteId(routeSelect);
//		SimpleDateFormat travelTimeFormat = new SimpleDateFormat("hh:mm:ss");
//		Date travelDate = travelTimeFormat.parse(travelTime);
//		Calendar cal = Calendar.getInstance();
//		cal.setTime(travelDate);
//		calendar.add(Calendar.MINUTE, cal.get(Calendar.MINUTE));
//		calendar.add(Calendar.HOUR, cal.get(Calendar.HOUR));
//		Date toDate = calendar.getTime();
//		
//		BusStatusBean busStatusBean = new BusStatusBean();
//		BusBean busBean = busDAO.getById(busPlateSelect);
//		busStatusBean.setBus(busBean);
//		busStatusBean.setBusStatus("ontrip");
//		busStatusBean.setFromDate(fromDate);
//		busStatusBean.setToDate(toDate);
//		busStatusBean.setStatus("");
//		EmployeeBean employeeBean = employeeDAO.getById(1);
//		busStatusBean.setScheduler(employeeBean);
//		
//		RouteDetailsBean routeDetailsBean = routeDetailsDAO.getById(1);
//		TripBean trip = new TripBean();
//		trip.setDepartureTime(fromDate);
//		trip.setBusStatus(busStatusBean);
//		trip.setArrivalTime(toDate);
//		trip.setStatus("active");
//		trip.setRouteDetails(routeDetailsBean);
//		List<ReservationBean> reservations = new ArrayList<ReservationBean>();
//		trip.setReservations(reservations);
//		busStatusDAO.save(busStatusBean);
//		tripDAO.save(trip);
		return SUCCESS;
	}

	public int getRouteSelect() {
		return routeSelect;
	}

	public void setRouteSelect(int routeSelect) {
		this.routeSelect = routeSelect;
	}

	public String getDepartDate() {
		return departDate;
	}

	public void setDepartDate(String departDate) {
		this.departDate = departDate;
	}

	public int getBusPlateSelect() {
		return busPlateSelect;
	}

	public void setBusPlateSelect(int busPlateSelect) {
		this.busPlateSelect = busPlateSelect;
	}

	public String getArriveDate() {
		return arriveDate;
	}

	public void setArriveDate(String arriveDate) {
		this.arriveDate = arriveDate;
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

}