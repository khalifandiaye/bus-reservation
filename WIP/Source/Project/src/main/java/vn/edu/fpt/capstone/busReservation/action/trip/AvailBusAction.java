package vn.edu.fpt.capstone.busReservation.action.trip;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;

@ParentPackage("jsonPackage")
public class AvailBusAction extends BaseAction {

	private static final long serialVersionUID = -1900533216154623510L;
	private BusDAO busDAO;

	private String departureTime;
	private int busType;
	private List<BusBean> busBeans;

	@Action(value = "/availBus", results = { @Result(type = "json", name = SUCCESS, params = {
			"includeProperties", "busBeans"}) })
	public String execute() throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd - hh:mm");
		Date date = sdf.parse(departureTime);
		setBusBeans(busDAO.getAvailBus(date, busType));
		return SUCCESS;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}
	
	public void setBusType(int busType) {
		this.busType = busType;
	}

	public void setDepartureTime(String departureTime) {
		this.departureTime = departureTime;
	}

	public List<BusBean> getBusBeans() {
		return busBeans;
	}

	public void setBusBeans(List<BusBean> busBeans) {
		this.busBeans = busBeans;
	}
}
