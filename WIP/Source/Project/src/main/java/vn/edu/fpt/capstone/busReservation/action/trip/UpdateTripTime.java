package vn.edu.fpt.capstone.busReservation.action.trip;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

import com.opensymphony.xwork2.ActionSupport;

public class UpdateTripTime extends ActionSupport{

	private static final long serialVersionUID = -1900533216154623510L;
	private int routeId;
	private RouteDAO routeDAO;

	public String execute() {
		List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();
		segmentBeans = routeDAO.getAllSegmentByRouteId(1);
		return SUCCESS;
	}

	public int getRouteId() {
		return routeId;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

	public RouteDAO getRouteDAO() {
		return routeDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}
}
