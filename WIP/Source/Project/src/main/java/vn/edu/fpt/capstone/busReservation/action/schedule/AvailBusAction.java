package vn.edu.fpt.capstone.busReservation.action.schedule;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.displayModel.BusInfo;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

@ParentPackage("jsonPackage")
public class AvailBusAction extends BaseAction {

	private static final long serialVersionUID = -1900533216154623510L;

	private BusDAO busDAO;
	private RouteDAO routeDAO;

	private String departureTime;

	private int busType;
	private int routeId;
	private List<BusInfo> busInfos = new ArrayList<BusInfo>();

	@Action(value = "/availBus", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		try {
			Date startDate = FormatUtils.deFormatDate(departureTime,
					"yyyy/MM/dd - hh:mm", CommonConstant.LOCALE_US,
					CommonConstant.DEFAULT_TIME_ZONE);

			RouteBean routeBean = routeDAO.getById(routeId);
			List<RouteDetailsBean> routeDetailsBeans = routeBean
					.getRouteDetails();

			int startStationId = routeDetailsBeans.get(0).getSegment()
					.getStartAt().getId();

			// get available bus
			List<Object[]> bus = busDAO.getAvailBus(startDate, routeId,
					startStationId, busType);
			for (Object b[] : bus) {
				BusInfo busInfo = new BusInfo();
				busInfo.setId((Integer) b[0]);
				busInfo.setPlateNumber((String) b[1]);
				busInfos.add(busInfo);
			}
		} catch (Exception e) {
		}
		return SUCCESS;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

	public void setBusType(int busType) {
		this.busType = busType;
	}

	public void setDepartureTime(String departureTime) {
		this.departureTime = departureTime;
	}

	public List<BusInfo> getBusInfos() {
		return busInfos;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}
}
