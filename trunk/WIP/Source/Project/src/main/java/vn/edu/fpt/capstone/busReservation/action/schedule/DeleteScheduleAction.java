package vn.edu.fpt.capstone.busReservation.action.schedule;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.TicketDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;

@ParentPackage("jsonPackage")
public class DeleteScheduleAction extends BaseAction {

	private static final long serialVersionUID = -1900533216154623510L;
	private BusStatusDAO busStatusDAO;
	private TicketDAO ticketDAO;

	private int busStatusId;
	private String message;

	@Action(value = "/deleteSchedule", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		List<TicketBean> reservationBeans = ticketDAO.getTicketByBusStatusId(busStatusId);
		boolean isHaveReservation = false;
		int countReservation = 0;
		for (TicketBean ticketBean : reservationBeans) {
			if (ticketBean.getReservation() != null
					&& ticketBean.getReservation().getStatus().equals("paid")) {
				isHaveReservation = false;
				countReservation++;
			}
		}

		if (!isHaveReservation) {
			BusStatusBean busStatusBean = busStatusDAO.getById(busStatusId);
			busStatusBean.setStatus("inactive");
			busStatusDAO.update(busStatusBean);
			message = "Delete trip successfully!";
		} else {
			message = "Cannot delete trip. This trip has " + countReservation
					+ "reservation on it";
		}
		return SUCCESS;
	}

	public void setTicketDAO(TicketDAO ticketDAO) {
		this.ticketDAO = ticketDAO;
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

}
