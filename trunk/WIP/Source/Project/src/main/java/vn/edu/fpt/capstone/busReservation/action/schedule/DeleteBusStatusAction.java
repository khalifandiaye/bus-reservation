package vn.edu.fpt.capstone.busReservation.action.schedule;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;

import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("jsonPackage")
public class DeleteBusStatusAction extends ActionSupport {

	private static final long serialVersionUID = -268527492772036231L;
	private BusStatusDAO busStatusDAO;
	private BusStatusBean busStatusBean;
	private ReservationDAO reservationDAO;
	private int numberOfReservations;
	private int busStatusId;

	@Action(value = "/deleteBusStatus", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		// check of the bus_status has any reservation
		List<ReservationBean> reservations = reservationDAO.getByBusStatusId(busStatusId);
		numberOfReservations = reservations.size();

		// set status inactive for bus_status
		if (numberOfReservations > 0) {
			busStatusBean = busStatusDAO.getById(busStatusId);
			busStatusBean.setStatus("inactive");
			busStatusDAO.update(busStatusBean);
		}
		return SUCCESS;
	}

	public int getNumberOfReservations() {
		return numberOfReservations;
	}

	private void setBusStatusId(int busStatusId) {
		this.busStatusId = busStatusId;
	}

}
