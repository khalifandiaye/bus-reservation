package vn.edu.fpt.capstone.busReservation.action.schedule;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.json.JSONException;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;

@ParentPackage("jsonPackage")
public class deleteScheduleAction extends BaseAction {

	private static final long serialVersionUID = -1900533216154623510L;
	private BusStatusDAO busStatusDAO;
	private ReservationDAO reservationDAO;
	private int busStatusId;
	private String message;

	@Action(value = "/deleteSchedule", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() throws ParseException, JSONException {
		
		List<ReservationBean> reservationBeans = reservationDAO.getByBusStatusId(busStatusId);
		if (reservationBeans.size() == 0) {
			BusStatusBean busStatusBean = busStatusDAO.getById(busStatusId);
			busStatusBean.setStatus("inactive");
			message = "Delete trip successfully";
		}
		else {
			message = "Cannot delete trip. This trip has " + reservationBeans.size() + " on it";
		}
		return SUCCESS;
	}

	public String getMessage() {
		return message;
	}

	public void setBusStatusId(int busStatusId) {
		this.busStatusId = busStatusId;
	}

	public void setBusStatusDAO(BusStatusDAO busStatusDAO) {
		this.busStatusDAO = busStatusDAO;
	}

	public void setReservationDAO(ReservationDAO reservationDAO) {
		this.reservationDAO = reservationDAO;
	}

}
