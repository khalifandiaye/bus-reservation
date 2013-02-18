package vn.edu.fpt.capstone.busReservation.action.trip;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.json.JSONException;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.displayModel.BusInfo;

@ParentPackage("jsonPackage")
public class AvailBusAction extends BaseAction {

	private static final long serialVersionUID = -1900533216154623510L;
	private BusDAO busDAO;

	private String departureTime;
	private int busType;
	private List<BusBean> busBeans;
	private List<BusInfo> busInfos = new ArrayList<BusInfo>();

	@Action(value = "/availBus", results = { @Result(type = "json", name = SUCCESS, params = {
            "root", "busInfos" }) })
	public String execute() throws ParseException, JSONException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd - hh:mm");
		Date date = sdf.parse(departureTime);
		setBusBeans(busDAO.getAvailBus(date, busType));
		for (BusBean busBean : busBeans) {
			BusInfo busInfo = new BusInfo(busBean.getId(), busBean.getPlateNumber());
			busInfos.add(busInfo);
		}
		session.put("busBeans", busBeans);
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

	public List<BusInfo> getBusInfos() {
		return busInfos;
	}

	public void setBusInfos(List<BusInfo> busInfos) {
		this.busInfos = busInfos;
	}
}
