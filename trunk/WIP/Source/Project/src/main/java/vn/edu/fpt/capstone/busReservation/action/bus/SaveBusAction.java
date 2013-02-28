package vn.edu.fpt.capstone.busReservation.action.bus;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;

public class SaveBusAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String plateNumber;
	private int busTypeBeans;
	private int routeForwardBeans;
	private int routeReturnBeans;
	
	private RouteDAO routeDAO;
	private BusTypeDAO busTypeDAO;
	private BusDAO busDAO;

	@Action(results = {@Result(name="success", location="list.html" , type="redirect")})
	public String execute() {
		BusTypeBean busTypeBean = busTypeDAO.getById(busTypeBeans);
		RouteBean forwardRoute = routeDAO.getById(routeForwardBeans);
		RouteBean returnRoute = routeDAO.getById(routeReturnBeans);
		BusBean busBean = new BusBean();
		busBean.setBusType(busTypeBean);
		busBean.setForwardRoute(forwardRoute);
		busBean.setReturnRoute(returnRoute);
		busBean.setPlateNumber(plateNumber);
		busBean.setStatus("active");
		busDAO.insert(busBean);
		return SUCCESS;
	}

	public BusTypeDAO getBusTypeDAO() {
		return busTypeDAO;
	}

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}

	public RouteDAO getRouteDAO() {
		return routeDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}

	public String getPlateNumber() {
		return plateNumber;
	}

	public void setPlateNumber(String plateNumber) {
		this.plateNumber = plateNumber;
	}

	public int getBusTypeBeans() {
		return busTypeBeans;
	}

	public void setBusTypeBeans(int busTypeBeans) {
		this.busTypeBeans = busTypeBeans;
	}

	public int getRouteForwardBeans() {
		return routeForwardBeans;
	}

	public void setRouteForwardBeans(int routeForwardBeans) {
		this.routeForwardBeans = routeForwardBeans;
	}

	public int getRouteReturnBeans() {
		return routeReturnBeans;
	}

	public void setRouteReturnBeans(int routeReturnBeans) {
		this.routeReturnBeans = routeReturnBeans;
	}

	public BusDAO getBusDAO() {
		return busDAO;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}
}