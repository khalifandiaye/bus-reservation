package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.CityDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentTravelTimeDAO;
import vn.edu.fpt.capstone.busReservation.dao.SystemSettingDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.CityBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.displayModel.RouteDetailsInfo;

import com.opensymphony.xwork2.ActionSupport;

public class ListAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private List<CityBean> cityBeans = new ArrayList<CityBean>();
	private List<BusTypeBean> busTypeBeans = new ArrayList<BusTypeBean>();
	private List<RouteBean> routeBeans = new ArrayList<RouteBean>();
	private List<RouteDetailsInfo> routeInfos = new ArrayList<RouteDetailsInfo>();

	private RouteDAO routeDAO;
	private RouteDetailsDAO routeDetailsDAO;
	private CityDAO cityDAO;
	private BusTypeDAO busTypeDAO;
	private SegmentTravelTimeDAO segmentTravelTimeDAO;
	private SystemSettingDAO systemSettingDAO;

	public String execute() {
		routeBeans = routeDAO.getAll();
		cityBeans = cityDAO.getAll();
		busTypeBeans = busTypeDAO.getAll();

		for (RouteBean routeBean : routeBeans) {
			RouteDetailsInfo routeDetailsInfo = new RouteDetailsInfo();
			int routeId = routeBean.getId();
			long delayTime = (long) systemSettingDAO.getStationDelayTime() * 60 * 1000;
			// list start date of each segment (required to get valid travel
			// time of each segment)
			List<Date> startDateOfSegment = new ArrayList<Date>();
			startDateOfSegment.add(Calendar.getInstance().getTime());

			long traTime = 0;
			int i = 0;
			routeDetailsInfo.setId(routeId);
			routeDetailsInfo.setRouteName(routeBean.getName());
			routeDetailsInfo.setActive(routeBean.getStatus());
			List<SegmentBean> segmentBeans = routeDetailsDAO
					.getAllSegmemtsByRouteId(routeId);
			for (SegmentBean segmentBean : segmentBeans) {
				traTime += segmentTravelTimeDAO
						.getTravelTimebyDate(segmentBean.getId(),
								startDateOfSegment.get(i)).get(0)
						.getTravelTime();

				if (i < (segmentBeans.size() - 1)) {
					Date newStartDate = new Date(startDateOfSegment.get(i)
							.getTime() + traTime + delayTime);
					startDateOfSegment.add(newStartDate);
				}
				i++;
			}

			Long hours = traTime / (1000 * 60 * 60);
			Long minutes = (traTime % (1000 * 60 * 60)) / (1000 * 60);

			routeDetailsInfo.setTravelTime((hours < 10 ? ("0" + hours
					.toString()) : hours)
					+ ":"
					+ (minutes < 10 ? ("0" + minutes.toString()) : minutes));
			routeInfos.add(routeDetailsInfo);
		}
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

	public List<RouteBean> getRouteBeans() {
		return routeBeans;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}

	public List<RouteDetailsInfo> getRouteInfos() {
		return routeInfos;
	}

	public void setRouteInfos(List<RouteDetailsInfo> routeInfos) {
		this.routeInfos = routeInfos;
	}

	public List<CityBean> getCityBeans() {
		return cityBeans;
	}

	public void setCityBeans(List<CityBean> cityBeans) {
		this.cityBeans = cityBeans;
	}

	public List<BusTypeBean> getBusTypeBeans() {
		return busTypeBeans;
	}

	public void setBusTypeBeans(List<BusTypeBean> busTypeBeans) {
		this.busTypeBeans = busTypeBeans;
	}

	public void setCityDAO(CityDAO cityDAO) {
		this.cityDAO = cityDAO;
	}

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}
}
