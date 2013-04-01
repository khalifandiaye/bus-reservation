package vn.edu.fpt.capstone.busReservation.action.schedule;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.displayModel.BusTypeInfo;

@ParentPackage("jsonPackage")
public class GetBusTypeAction extends BaseAction {

	private static final long serialVersionUID = -1900533216154623510L;

	private int routeId;
	private BusTypeDAO busTypeDAO;
	private List<BusTypeInfo> busTypeInfos = new ArrayList<BusTypeInfo>();

	@Action(value = "/busTypes", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		// type of bus which has defined price
		List<Object[]> busTypeObjects = busTypeDAO.getBusTypesInRoute(routeId);
		for (Object[] objects : busTypeObjects) {
			if (objects[0] != null && objects[1] != null) {
				BusTypeInfo busTypeInfo = new BusTypeInfo();
				busTypeInfo.setId((Integer) objects[0]);
				busTypeInfo.setType((String) objects[1]);
				busTypeInfos.add(busTypeInfo);
			}
		}
		return SUCCESS;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}

	public List<BusTypeInfo> getBusTypeInfos() {
		return busTypeInfos;
	}

	public void setBusTypeInfos(List<BusTypeInfo> busTypeInfos) {
		this.busTypeInfos = busTypeInfos;
	}

}
