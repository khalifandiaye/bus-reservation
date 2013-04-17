package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.CityDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentTravelTimeDAO;
import vn.edu.fpt.capstone.busReservation.dao.SystemSettingDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.CityBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentTravelTimeBean;
import vn.edu.fpt.capstone.busReservation.displayModel.BusInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentInfo;

import com.opensymphony.xwork2.ActionSupport;

public class RouteDetailListAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	private List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();
	private List<SegmentInfo> segmentInfos = new ArrayList<SegmentInfo>();
	private List<BusTypeBean> busTypeBeans = new ArrayList<BusTypeBean>();
	private List<BusTypeBean> busTypes = new ArrayList<BusTypeBean>();
	private List<BusStatusBean> busStatusBeans = new ArrayList<BusStatusBean>();
	private List<BusInfo> busInfos = new ArrayList<BusInfo>();
	private List<CityBean> cityBeans = new ArrayList<CityBean>();

	private int routeId;
	private int reverseRouteId;

	private boolean active = false;
	private String routeName = "";
	private String sumaryTime = "";
	private boolean haveBus;

	private RouteDetailsDAO routeDetailsDAO;
	private BusTypeDAO busTypeDAO;
	private SegmentTravelTimeDAO segmentTravelTimeDAO;
	private SystemSettingDAO systemSettingDAO;
	private BusStatusDAO busStatusDAO;
	private RouteDAO routeDAO;
	private BusDAO busDAO;
	private CityDAO cityDAO;

	public String execute() {
	   cityBeans = cityDAO.getAll();
		List<BusBean> busBeans = busDAO.getBusByRouteId(routeId);
		if (busBeans.size() != 0) {
			haveBus = true;
		} else {
			haveBus = false;
		}
		reverseRouteId = routeDAO.getRouteTerminal(routeId).get(1);

		segmentBeans = routeDetailsDAO.getAllSegmemtsByRouteId(routeId);
		busStatusBeans = busStatusDAO.getAllAvailTripByRouteId(routeId,
				Calendar.getInstance().getTime());

		// WORK AROUND
		for (BusStatusBean busStatusBean : busStatusBeans) {
			BusInfo busInfo = new BusInfo();
			busInfo.setId(busStatusBean.getId());
			busInfo.setPlateNumber(busStatusBean.getBus().getPlateNumber());
			busInfo.setFromDate(busStatusBean.getFromDate());
			busInfo.setToDate(busStatusBean.getToDate());
			busInfo.setDelete(busStatusBean.getStatus());
			busInfos.add(busInfo);
		}

		RouteBean routeBean = routeDAO.getById(routeId);
		if (routeBean.getStatus().equals("active")) {
			active = true;
		}
		// segmentBeans = routeDetailsDAO.getAllSegmemtsByRouteId(routeId);
		busTypes = busTypeDAO.getAll();

		long delayTime = (long) systemSettingDAO.getStationDelayTime() * 60 * 1000;
		// list start date of each segment (required to get valid travel
		// time of each segment)
		List<Date> startDateOfSegment = new ArrayList<Date>();
		startDateOfSegment.add(Calendar.getInstance().getTime());

		long traTime = 0;
		long sumTraTime = 0;
		int i = 0;

		for (SegmentBean segmentBean : segmentBeans) {
			SegmentInfo segmentInfo = new SegmentInfo();
			String name = segmentBean.getStartAt().getCity().getName() + " - "
					+ segmentBean.getEndAt().getCity().getName();
			segmentInfo.setId(segmentBean.getId());
			segmentInfo.setName(name);

			List<SegmentTravelTimeBean> segmentTravelTimeBeans = segmentTravelTimeDAO
					.getTravelTimebyDate(segmentBean.getId(),
							startDateOfSegment.get(i));
			if (segmentTravelTimeBeans.size() != 0) {
				traTime = segmentTravelTimeBeans.get(0).getTravelTime();
			}

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
			sumTraTime += traTime;
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

		Long hours = sumTraTime / (1000 * 60 * 60);
		Long minutes = (sumTraTime % (1000 * 60 * 60)) / (1000 * 60);
		sumaryTime = (hours < 10 ? ("0" + hours.toString()) : hours) + ":"
				+ (minutes < 10 ? ("0" + minutes.toString()) : minutes);

		return SUCCESS;
	}

	public int getReverseRouteId() {
		return reverseRouteId;
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

	public BusStatusDAO getBusStatusDAO() {
		return busStatusDAO;
	}

	public void setBusStatusDAO(BusStatusDAO busStatusDAO) {
		this.busStatusDAO = busStatusDAO;
	}

	public List<BusStatusBean> getBusStatusBeans() {
		return busStatusBeans;
	}

	public void setBusStatusBeans(List<BusStatusBean> busStatusBeans) {
		this.busStatusBeans = busStatusBeans;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public RouteDAO getRouteDAO() {
		return routeDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}

	public String getSumaryTime() {
		return sumaryTime;
	}

	public void setSumaryTime(String sumaryTime) {
		this.sumaryTime = sumaryTime;
	}

	public List<BusInfo> getBusInfos() {
		return busInfos;
	}

	public void setBusInfos(List<BusInfo> busInfos) {
		this.busInfos = busInfos;
	}

	public boolean isHaveBus() {
		return haveBus;
	}

	public void setHaveBus(boolean haveBus) {
		this.haveBus = haveBus;
	}

	public BusDAO getBusDAO() {
		return busDAO;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

   public List<CityBean> getCityBeans() {
      return cityBeans;
   }

   public void setCityBeans(List<CityBean> cityBeans) {
      this.cityBeans = cityBeans;
   }

   public CityDAO getCityDAO() {
      return cityDAO;
   }

   public void setCityDAO(CityDAO cityDAO) {
      this.cityDAO = cityDAO;
   }
}
