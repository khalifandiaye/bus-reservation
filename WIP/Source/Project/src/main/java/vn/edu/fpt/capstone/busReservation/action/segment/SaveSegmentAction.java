package vn.edu.fpt.capstone.busReservation.action.segment;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentTravelTimeDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentTravelTimeBean;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.DateUtils;

@ParentPackage("jsonPackage")
public class SaveSegmentAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int segmentId;
	private String validFromTime;
	private String duration;
	private String message = "Save Segment Success!";

	private SegmentTravelTimeDAO segmentTravelTimeDAO;
	private SegmentDAO segmentDAO;

	@Action(value = "/saveSegment", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		try {
			SegmentBean segmentForward = segmentDAO.getById(segmentId);
			
			List<SegmentTravelTimeBean> segmentTravelTimeBeans = new ArrayList<SegmentTravelTimeBean>();
			SegmentTravelTimeBean segmentTravelTimeBeanForward = new SegmentTravelTimeBean();
			segmentTravelTimeBeanForward.setSegment(segmentForward);
			segmentTravelTimeBeans.add(segmentTravelTimeBeanForward);
			//Add new duration for return segment
			SegmentBean segmentReturn = (segmentDAO.getDuplicatedSegment(
					segmentForward.getStartAt().getId(), segmentForward
							.getEndAt().getId())).get(0);
			SegmentTravelTimeBean segmentTravelTimeBeanReturn = new SegmentTravelTimeBean();
			segmentTravelTimeBeanReturn.setSegment(segmentReturn);
			segmentTravelTimeBeans.add(segmentTravelTimeBeanReturn);
			
			for (SegmentTravelTimeBean segmentTravelTimeBean : segmentTravelTimeBeans) {
				Date validDate = DateUtils.string2Date(validFromTime,
						"dd/MM/yyyy", CommonConstant.LOCALE_VN,
						CommonConstant.DEFAULT_TIME_ZONE);
				segmentTravelTimeBean.setValidFrom(validDate);

				String[] travelTime = duration.split(":");
				long dtravelTime = DateUtils.getTime(
						Integer.parseInt(travelTime[0]),
						Integer.parseInt(travelTime[1]), 0);
				segmentTravelTimeBean.setTravelTime(dtravelTime);
				segmentTravelTimeDAO.insert(segmentTravelTimeBean);
			}
		} catch (Exception ex) {
			setMessage("Save saveSegment failed!");
		}
		return SUCCESS;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getSegmentId() {
		return segmentId;
	}

	public void setSegmentId(int segmentId) {
		this.segmentId = segmentId;
	}

	public String getValidFromTime() {
		return validFromTime;
	}

	public void setValidFromTime(String validFromTime) {
		this.validFromTime = validFromTime;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public void setSegmentTravelTimeDAO(
			SegmentTravelTimeDAO segmentTravelTimeDAO) {
		this.segmentTravelTimeDAO = segmentTravelTimeDAO;
	}

	public void setSegmentDAO(SegmentDAO segmentDAO) {
		this.segmentDAO = segmentDAO;
	}

}
