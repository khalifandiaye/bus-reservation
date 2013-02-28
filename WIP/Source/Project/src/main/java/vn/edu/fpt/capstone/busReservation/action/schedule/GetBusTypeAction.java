package vn.edu.fpt.capstone.busReservation.action.schedule;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;

@ParentPackage("jsonPackage")
public class GetBusTypeAction extends BaseAction {

	private static final long serialVersionUID = -1900533216154623510L;

	private int routeId;
	private BusTypeDAO busTypeDAO;
	private List<BusTypeBean> busTypeBeans = new ArrayList<BusTypeBean>();
	
	@Action(value = "/busTypes", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		// type of bus which has defined price
		List<Object[]> busTypeObjects = busTypeDAO.getBusTypesInRoute(routeId);
		for (Object[] objects : busTypeObjects) {
			BusTypeBean busTypeBean = new BusTypeBean();
			busTypeBean.setId((Integer) objects[0]);
			busTypeBean.setName((String) objects[1]);
			busTypeBean.setNumberOfSeats((Integer) objects[2]);
			getBusTypeBeans().add(busTypeBean);
		}
		return SUCCESS;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}

	private List<BusTypeBean> getBusTypeBeans() {
		return busTypeBeans;
	}
}
