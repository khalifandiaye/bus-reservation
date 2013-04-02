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
			Date validDate = DateUtils.string2Date(validFromTime, "dd/MM/yyyy",
					CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE);
			String[] travelTime = duration.split(":");
			long dtravelTime = DateUtils.getTime(
					Integer.parseInt(travelTime[0]),
					Integer.parseInt(travelTime[1]), 0);
			SegmentBean segmentForward = segmentDAO.getById(segmentId);
			SegmentBean segmentReturn = (segmentDAO.getDuplicatedSegment(
					segmentForward.getEndAt().getId(), segmentForward
							.getStartAt().getId())).get(0);
			List<SegmentTravelTimeBean> segmentTravelTimeBeans = new ArrayList<SegmentTravelTimeBean>();

			List<SegmentTravelTimeBean> dupTimeForwardBeans = segmentTravelTimeDAO
					.getExistDuration(segmentId, validDate);

			// update existed segment travel time with new duration
			if (dupTimeForwardBeans.size() != 0) {
				if (dupTimeForwardBeans.get(0).getTravelTime() != dtravelTime) {
					// get duplicated duration for return travel time
					List<SegmentTravelTimeBean> dupTimeReturnBeans = segmentTravelTimeDAO
							.getExistDuration(segmentReturn.getId(), validDate);
					segmentTravelTimeBeans.add(dupTimeForwardBeans.get(0));
					segmentTravelTimeBeans.add(dupTimeReturnBeans.get(0));
					for (SegmentTravelTimeBean segmentTravelTimeBean : segmentTravelTimeBeans) {
						segmentTravelTimeBean.setTravelTime(dtravelTime);
						segmentTravelTimeDAO.update(segmentTravelTimeBean);
					}
				}
			}

			// create new segment travel time bean
			else {
				SegmentTravelTimeBean segmentTravelTimeBeanForward = new SegmentTravelTimeBean();
				segmentTravelTimeBeanForward.setSegment(segmentForward);				
				// select return segment
				SegmentTravelTimeBean segmentTravelTimeBeanReturn = new SegmentTravelTimeBean();
				segmentTravelTimeBeanReturn.setSegment(segmentReturn);
				
				segmentTravelTimeBeans.add(segmentTravelTimeBeanForward);
				segmentTravelTimeBeans.add(segmentTravelTimeBeanReturn);

				for (SegmentTravelTimeBean segmentTravelTimeBean : segmentTravelTimeBeans) {
					segmentTravelTimeBean.setValidFrom(validDate);
					segmentTravelTimeBean.setTravelTime(dtravelTime);
					segmentTravelTimeDAO.insert(segmentTravelTimeBean);
				}
			}
			
			setMessage("Update travel time for Segment"
					+ segmentForward.getStartAt().getName() + " - "
					+ segmentForward.getEndAt().getName() 
					+ " success!");
			
		} catch (Exception ex) {
			setMessage("Save travel time for segment failed!");
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
