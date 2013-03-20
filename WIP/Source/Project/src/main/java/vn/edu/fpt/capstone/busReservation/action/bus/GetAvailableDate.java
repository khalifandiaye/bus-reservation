package vn.edu.fpt.capstone.busReservation.action.bus;

import java.util.Date;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

@ParentPackage("jsonPackage")
public class GetAvailableDate extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private BusStatusDAO busStatusDAO;

	private int busId;
	private long maintainDuration;

	private String fromDate;
	private String toDate;

	@Action(value = "/getAvailableDate", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {

		// get max todate in schedule of the bus
		fromDate = FormatUtils.formatDate(
				busStatusDAO.getMaintainFromDate(busId).get(0),
				"yyyy/MM/dd - HH:mm", CommonConstant.LOCALE_US,
				CommonConstant.DEFAULT_TIME_ZONE);
		// calculate toDate
		Long calToDate = busStatusDAO.getMaintainFromDate(busId).get(0)
				.getTime()
				+ (Long) maintainDuration * 24 * 60 * 60;

		Date dtoDate = new Date(calToDate);
		toDate = FormatUtils.formatDate(dtoDate, "yyyy/MM/dd - HH:mm",
				CommonConstant.LOCALE_US, CommonConstant.DEFAULT_TIME_ZONE);

		return SUCCESS;
	}

	public void setBusStatusDAO(BusStatusDAO busStatusDAO) {
		this.busStatusDAO = busStatusDAO;
	}

	public String getFromDate() {
		return fromDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setBusId(int busId) {
		this.busId = busId;
	}

	public void setMaintainDuration(long maintainDuration) {
		this.maintainDuration = maintainDuration;
	}
}
