package vn.edu.fpt.capstone.busReservation.action.bus;

import java.util.Calendar;
import java.util.Date;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

@ParentPackage("jsonPackage")
public class SaveMaintainScheduleAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private BusStatusDAO busStatusDAO;
	private BusDAO busDAO;

	private int busId;
	private long maintainDuration;

	private String message;

	@Action(value = "/saveMaintainSchedule", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		try {

			Date dfromDate = busStatusDAO.getMaintainFromDate(busId).get(0);
			if (dfromDate == null) {
				Calendar cal = Calendar.getInstance();
				dfromDate = cal.getTime();
			}

			Long calToDate = dfromDate.getTime() + maintainDuration * 24 * 60
					* 60;

			Date dtoDate = new Date(calToDate);

			BusStatusBean busStatusBean = new BusStatusBean();
			BusBean busBean = busDAO.getById(busId);
			busStatusBean.setBus(busBean);
			busStatusBean.setStatus("maintain");

			busStatusBean.setFromDate(dfromDate);
			busStatusBean.setToDate(dtoDate);
			busStatusBean.setStatus("active");

			// get end station by date
			StationBean stationBean = busStatusDAO.getCurrentStation(dfromDate)
					.get(0);
			busStatusBean.setEndStation(stationBean);
			busStatusDAO.insert(busStatusBean);

			Calendar cal = Calendar.getInstance();

			// set toString fromDate
			cal.setTime(dfromDate);
			String sfromDate = FormatUtils.formatDate(cal.getTime(),
					"yyyy/MM/dd - HH:mm", CommonConstant.LOCALE_US,
					CommonConstant.DEFAULT_TIME_ZONE);

			// set toString endDate
			cal.setTime(dtoDate);
			String stoDate = FormatUtils.formatDate(cal.getTime(),
					"yyyy/MM/dd - HH:mm", CommonConstant.LOCALE_US,
					CommonConstant.DEFAULT_TIME_ZONE);
			message = "Bus maintain schedule from " + sfromDate + " to "
					+ stoDate + " is added successfully!";
		} catch (Exception ex) {
			message = "Add maintain schedule failed!";
		}
		return SUCCESS;
	}

	public long getMaintainDuration() {
		return maintainDuration;
	}

	public void setMaintainDuration(long maintainDuration) {
		this.maintainDuration = maintainDuration;
	}

	public int getBusId() {
		return busId;
	}

	public void setMessage(String message) {
		this.message = message;
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

	public void setBusId(int busId) {
		this.busId = busId;
	}
}
