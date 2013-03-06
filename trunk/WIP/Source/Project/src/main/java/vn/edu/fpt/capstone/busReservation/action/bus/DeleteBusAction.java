package vn.edu.fpt.capstone.busReservation.action.bus;

import java.text.ParseException;
import java.util.Calendar;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.json.JSONException;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;

@ParentPackage("jsonPackage")
public class DeleteBusAction extends BaseAction {

	private static final long serialVersionUID = -1900533216154623510L;

	private BusStatusDAO busStatusDAO;
	private BusDAO busDAO;

	private int busId;

	public void setBusId(int busId) {
		this.busId = busId;
	}

	private String message;

	@Action(value = "/deleteRoute", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() throws ParseException, JSONException {
		List<BusStatusBean> busStatusBeans = busStatusDAO
				.getAllAvailTripByBusId(busId, Calendar.getInstance().getTime());
		if (busStatusBeans.size() == 0) {
			// unassigned buses
			BusBean busBean = busDAO.getById(busId);
			busBean.setStatus("inactive");
			busDAO.update(busBean);

			message = "Bus is deleted!";
		} else {
			message = "Cannot delete this bus due to this bus has "
					+ busStatusBeans.size() + " in the future";
		}
		return SUCCESS;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

	public String getMessage() {
		return message;
	}

	public void setBusStatusDAO(BusStatusDAO busStatusDAO) {
		this.busStatusDAO = busStatusDAO;
	}
}
