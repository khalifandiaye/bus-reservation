package vn.edu.fpt.capstone.busReservation.action.trip;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

import com.opensymphony.xwork2.ActionSupport;

public class UpdateTripTimeAction extends ActionSupport {

	private static final long serialVersionUID = -1900533216154623510L;
	private int routeId = 0;
	private Date departDate = new Date();
	private RouteDAO routeDAO;

	public String execute() {
//		List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();
//		HttpServletRequest request = ServletActionContext.getRequest();
//		segmentBeans = routeDAO.getAllSegmentByRouteId(routeId);
//		for (SegmentBean segmentBean : segmentBeans) {
//			
//		}
//		System.out.println(segmentBeans.toString());
		return SUCCESS;
	}

	public RouteDAO getRouteDAO() {
		return routeDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}

	public int getRouteId() {
		return routeId;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

	public Date getDepartDate() {
		return departDate;
	}

	public void setDepartDate(Date departDate) {
		this.departDate = departDate;
	}
}
