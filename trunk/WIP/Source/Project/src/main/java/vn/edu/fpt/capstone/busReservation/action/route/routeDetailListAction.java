package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

import com.opensymphony.xwork2.ActionSupport;

public class routeDetailListAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private RouteDetailsDAO routeDetailsDAO;
	private List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();
	private int routeId;
	
	public String execute() {
		segmentBeans = routeDetailsDAO.getAllSegmemtsByRouteId(routeId);
		return SUCCESS;
	}

	public RouteDetailsDAO getRouteDetailsDAO() {
		return routeDetailsDAO;
	}

	public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
		this.routeDetailsDAO = routeDetailsDAO;
	}

	public List<SegmentBean> getSegmentBeans() {
		return segmentBeans;
	}

	public void setSegmentBeans(List<SegmentBean> segmentBeans) {
		this.segmentBeans = segmentBeans;
	}

	public int getRouteId() {
		return routeId;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}
}
