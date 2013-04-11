package vn.edu.fpt.capstone.busReservation.action.segment;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentTravelTimeDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentTravelTimeBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentInfo;

public class ListAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();
	private List<SegmentInfo> segmentInfos = new ArrayList<SegmentInfo>();

	private SegmentDAO segmentDAO;
	private SegmentTravelTimeDAO segmentTravelTimeDAO;
	private List<BusTypeBean> busTypeBeans;

	private BusTypeDAO busTypeDAO;

	public String execute() {
		segmentBeans = segmentDAO.getAll();
		for (SegmentBean segmentBean : segmentBeans) {
			busTypeBeans = busTypeDAO.getAll();

			SegmentInfo segmentInfo = new SegmentInfo();
			segmentInfo.setId(segmentBean.getId());
			segmentInfo.setStartAtName(segmentBean.getStartAt().getName());
			segmentInfo.setEndAtName(segmentBean.getEndAt().getName());

			long time = 0;
			List<SegmentTravelTimeBean> segmentTravelTimeBeans = segmentTravelTimeDAO
					.getTravelTimebyDate(segmentBean.getId(), Calendar
							.getInstance().getTime());
			if (segmentTravelTimeBeans.size() != 0) {
				time = segmentTravelTimeBeans.get(0).getTravelTime();
			}

			Long hours = time / (1000 * 60 * 60);
			Long minutes = (time % (1000 * 60 * 60)) / (1000 * 60);
			segmentInfo.setDuration((hours < 10 ? ("0" + hours.toString())
					: hours)
					+ ":"
					+ (minutes < 10 ? ("0" + minutes.toString()) : minutes));
			
			segmentInfos.add(segmentInfo);
		}
		return SUCCESS;
	}

	public List<BusTypeBean> getBusTypeBeans() {
		return busTypeBeans;
	}

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}

	public SegmentDAO getSegmentDAO() {
		return segmentDAO;
	}

	public void setSegmentDAO(SegmentDAO segmentDAO) {
		this.segmentDAO = segmentDAO;
	}

	public List<SegmentBean> getSegmentBeans() {
		return segmentBeans;
	}

	public void setSegmentBeans(List<SegmentBean> segmentBeans) {
		this.segmentBeans = segmentBeans;
	}

	public SegmentTravelTimeDAO getSegmentTravelTimeDAO() {
		return segmentTravelTimeDAO;
	}

	public void setSegmentTravelTimeDAO(
			SegmentTravelTimeDAO segmentTravelTimeDAO) {
		this.segmentTravelTimeDAO = segmentTravelTimeDAO;
	}

	public List<SegmentInfo> getSegmentInfos() {
		return segmentInfos;
	}

	public void setSegmentInfos(List<SegmentInfo> segmentInfos) {
		this.segmentInfos = segmentInfos;
	}

}
