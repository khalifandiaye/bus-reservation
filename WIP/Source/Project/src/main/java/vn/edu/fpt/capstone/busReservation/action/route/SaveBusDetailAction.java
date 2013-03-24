package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.displayModel.BusDetailInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.BusInfo;

@ParentPackage("jsonPackage")
public class SaveBusDetailAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6013335986990979597L;

	private String data;

	private static ObjectMapper mapper = new ObjectMapper();

	private String message = "Update success!";

	private BusDAO busDAO;
	private RouteDAO routeDAO;
	private BusStatusDAO busStatusDAO;

	@Action(value = "saveBusDetail", results = { @Result(type = "json", name = SUCCESS, params = {
			"root", "message" }) })
	public String execute() {
		try {
			BusDetailInfo busDetailInfo = mapper.readValue(data,
					new TypeReference<BusDetailInfo>() {
					});
			List<BusInfo> busInfos = busDetailInfo.getBus();
			List<BusInfo> unSelectBus = busDetailInfo.getUnSelectBus();
			int routeId = busDetailInfo.getRouteId();
			for (BusInfo busInfo : busInfos) {
				BusBean busBean = busDAO.getById(busInfo.getId());
				RouteBean routeBean = routeDAO.getById(routeId);
				List<Integer> routeIDs = routeDAO.getRouteTerminal(routeBean
						.getId());
				if (routeIDs.size() != 0) {
					busBean.setForwardRoute(routeDAO.getById(routeIDs.get(0)));
					busBean.setReturnRoute(routeDAO.getById(routeIDs.get(1)));

					// create initiation bus status
					busDAO.update(busBean);
					Date currentTime = Calendar.getInstance().getTime();
					BusStatusBean busStatusBean = new BusStatusBean();
					busStatusBean.setBus(busBean);
					busStatusBean.setBusStatus("initiation");
					busStatusBean.setFromDate(currentTime);
					busStatusBean.setToDate(currentTime);
					StationBean endStationBean = routeDAO.getById(routeId)
							.getRouteDetails().get(0).getSegment().getStartAt();
					busStatusBean.setEndStation(endStationBean);
					busStatusBean.setStatus("active");
					busStatusDAO.insert(busStatusBean);
				}
			}

			for (BusInfo busInfo : unSelectBus) {
				// checking available trip of this bus
				List<BusStatusBean> busStatusBeans = busStatusDAO
						.getAllTripByBusId(busInfo.getId(), Calendar
								.getInstance().getTime());
				if (busStatusBeans.size() == 0) {
					BusBean busBean = busDAO.getById(busInfo.getId());
					busBean.setForwardRoute(null);
					busBean.setReturnRoute(null);
					busDAO.update(busBean);
				}
			}
		} catch (Exception e) {
		}
		return SUCCESS;
	}

	public void setBusStatusDAO(BusStatusDAO busStatusDAO) {
		this.busStatusDAO = busStatusDAO;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getMessage() {
		return message;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}

}
