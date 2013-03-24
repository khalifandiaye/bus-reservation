package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.displayModel.BusInfo;

import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("jsonPackage")
public class BusDetailAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int routeId;
	private int type;
	private List<BusInfo> busInRouteBeans = new ArrayList<BusInfo>();
	private List<BusInfo> busNotInRouteBeans = new ArrayList<BusInfo>();
	
	private BusDAO busDAO;
	private BusStatusDAO busStatusDAO;

	@Action(value = "getBusInRoute", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		List<Object[]> bir = busDAO.getBusByTypeInRoute(routeId, type, "active");
		for (Object[] objects : bir) {
			BusInfo busInfo = new BusInfo();
			busInfo.setId((Integer) objects[0]);
			busInfo.setPlateNumber((String) objects[1]);
			List<BusStatusBean> futurePlans = busStatusDAO.getAllTripByBusId((Integer) objects[0], 
					Calendar.getInstance().getTime());
			if (futurePlans.size() > 0) {
			   busInfo.setDelete("false");
			} else {
			   busInfo.setDelete("true");
			}
			busInRouteBeans.add(busInfo);
		}
		
		List<Object[]> bnir = busDAO.getBusByTypeNotInRoute(type, "active");
		for (Object[] objects : bnir) {
			BusInfo busInfo = new BusInfo();
			busInfo.setId((Integer) objects[0]);
			busInfo.setPlateNumber((String) objects[1]);
			busNotInRouteBeans.add(busInfo);
		}
		return SUCCESS;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getRouteId() {
		return routeId;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

	public List<BusInfo> getBusInRouteBeans() {
		return busInRouteBeans;
	}

	public void setBusInRouteBeans(List<BusInfo> busInRouteBeans) {
		this.busInRouteBeans = busInRouteBeans;
	}

	public List<BusInfo> getBusNotInRouteBeans() {
		return busNotInRouteBeans;
	}

	public void setBusNotInRouteBeans(List<BusInfo> busNotInRouteBeans) {
		this.busNotInRouteBeans = busNotInRouteBeans;
	}

	public void setBusStatusDAO(BusStatusDAO busStatusDAO) {
		this.busStatusDAO = busStatusDAO;
	}
	
}
