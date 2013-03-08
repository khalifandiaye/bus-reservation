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

	@Action(value = "/deleteBus", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() throws ParseException, JSONException {
		List<BusStatusBean> busStatusBeans = busStatusDAO
				.getAllAvailTripByBusId(busId, Calendar.getInstance().getTime());
		BusBean busBean = busDAO.getById(busId);
		if (busStatusBeans.size() == 0 && busBean.getForwardRoute() == null) {
			// unassigned buses
			busBean.setStatus("inactive");
			busDAO.update(busBean);

			message = "Bus is deleted succesfully!";
		} else if (busStatusBeans.size() != 0) {
			message = "Cannot delete this bus due to this bus has "
					+ busStatusBeans.size() + " trips in the future";
		} else if (busBean.getForwardRoute() != null) {
			message = "Cannot delete this bus due to this bus is being assigned to route "
					+ busBean.getForwardRoute().getName()+ ". Please unassign this bus and try again!";
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
