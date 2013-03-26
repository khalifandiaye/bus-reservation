package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentTravelTimeDAO;
import vn.edu.fpt.capstone.busReservation.dao.SystemSettingDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentInfo;

import com.opensymphony.xwork2.ActionSupport;

public class RouteDetailListAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	private List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();
	private List<SegmentInfo> segmentInfos = new ArrayList<SegmentInfo>();
	private List<BusTypeBean> busTypeBeans = new ArrayList<BusTypeBean>();
	private List<BusTypeBean> busTypes = new ArrayList<BusTypeBean>();

	private int routeId;

	private String routeName = "";

	private RouteDetailsDAO routeDetailsDAO;
	private BusTypeDAO busTypeDAO;
	private SegmentTravelTimeDAO segmentTravelTimeDAO;
	private SystemSettingDAO systemSettingDAO;

	public String execute() {
		segmentBeans = routeDetailsDAO.getAllSegmemtsByRouteId(routeId);
		busTypes = busTypeDAO.getAll();

		long delayTime = (long) systemSettingDAO.getStationDelayTime() * 60 * 1000;
		// list start date of each segment (required to get valid travel
		// time of each segment)
		List<Date> startDateOfSegment = new ArrayList<Date>();
		startDateOfSegment.add(Calendar.getInstance().getTime());

		long traTime = 0;
		int i = 0;

		for (SegmentBean segmentBean : segmentBeans) {
			SegmentInfo segmentInfo = new SegmentInfo();
			String name = segmentBean.getStartAt().getCity().getName() + " - "
					+ segmentBean.getEndAt().getCity().getName();
			segmentInfo.setId(segmentBean.getId());
			segmentInfo.setName(name);

			traTime = segmentTravelTimeDAO
					.getTravelTimebyDate(segmentBean.getId(),
							startDateOfSegment.get(i)).get(0).getTravelTime();

			if (i < (segmentBeans.size() - 1)) {
				Date newStartDate = new Date(startDateOfSegment.get(i)
						.getTime() + traTime + delayTime);
				startDateOfSegment.add(newStartDate);
			}
			i++;

			Long hours = traTime / (1000 * 60 * 60);
			Long minutes = (traTime % (1000 * 60 * 60)) / (1000 * 60);
			segmentInfo.setDuration((hours < 10 ? ("0" + hours.toString())
					: hours)
					+ ":"
					+ (minutes < 10 ? ("0" + minutes.toString()) : minutes));
			segmentInfos.add(segmentInfo);
		}

		List<Object[]> busTypeObjects = busTypeDAO.getBusTypesInRoute(routeId);
		for (Object[] objects : busTypeObjects) {
			if (objects[0] != null && objects[1] != null && objects[2] != null) {
				BusTypeBean busTypeBean = new BusTypeBean();
				busTypeBean.setId((Integer) objects[0]);
				busTypeBean.setName((String) objects[1]);
				busTypeBean.setNumberOfSeats((Integer) objects[2]);
				busTypeBeans.add(busTypeBean);
			}
		}
		routeName = segmentBeans.get(0).getStartAt().getCity().getName()
				+ " - "
				+ segmentBeans.get(segmentBeans.size() - 1).getEndAt()
						.getCity().getName();

		return SUCCESS;
	}

	public void setSystemSettingDAO(SystemSettingDAO systemSettingDAO) {
		this.systemSettingDAO = systemSettingDAO;
	}

	public void setSegmentTravelTimeDAO(
			SegmentTravelTimeDAO segmentTravelTimeDAO) {
		this.segmentTravelTimeDAO = segmentTravelTimeDAO;
	}

	public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
		this.routeDetailsDAO = routeDetailsDAO;
	}

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

	public int getRouteId() {
		return this.routeId;
	}

	public List<SegmentInfo> getSegmentInfos() {
		return segmentInfos;
	}

	public List<BusTypeBean> getBusTypeBeans() {
		return busTypeBeans;
	}

	public String getRouteName() {
		return routeName;
	}

	public List<SegmentBean> getSegmentBeans() {
		return segmentBeans;
	}

	public List<BusTypeBean> getBusTypes() {
		return busTypes;
	}
}
