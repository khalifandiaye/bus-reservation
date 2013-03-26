package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.Calendar;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentTravelTimeDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

@ParentPackage("jsonPackage")
public class GetDurationAction extends BaseAction {

	/**
    * 
    */
	private static final long serialVersionUID = 1L;

	private SegmentDAO segmentDAO;
	private SegmentTravelTimeDAO segmentTravelTimeDAO;

	private int startStation;
	private int endStation;
	private String travelTime = "";

	@Action(value = "getSegmentDuration", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		List<SegmentBean> segmentBeans = segmentDAO.getDuplicatedSegment(
				startStation, endStation);
		if (segmentBeans.size() != 0) {
			Long ltravelTime = segmentTravelTimeDAO.getTravelTimebyDate(segmentBeans.get(0).getId(),
							Calendar.getInstance().getTime()).get(0).getTravelTime();
			Long hours = ltravelTime / (1000 * 60 * 60);
			Long minutes = (ltravelTime % (1000 * 60 * 60))
					/ (1000 * 60);
			travelTime = (hours < 10 ? ("0" + hours.toString()) : hours) + ":"
					+ (minutes < 10 ? ("0" + minutes.toString()) : minutes);
		}
		return SUCCESS;
	}

	public void setSegmentDAO(SegmentDAO segmentDAO) {
		this.segmentDAO = segmentDAO;
	}

	public void setSegmentTravelTimeDAO(
			SegmentTravelTimeDAO segmentTravelTimeDAO) {
		this.segmentTravelTimeDAO = segmentTravelTimeDAO;
	}

	public void setStartStation(int startStation) {
		this.startStation = startStation;
	}

	public void setTravelTime(String travelTime) {
		this.travelTime = travelTime;
	}

	public void setEndStation(int endStation) {
		this.endStation = endStation;
	}

	public String getTravelTime() {
		return travelTime;
	}

}
