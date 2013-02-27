package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentInfo;

import com.opensymphony.xwork2.ActionSupport;

public class RouteDetailListAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private RouteDetailsDAO routeDetailsDAO;
	private SegmentDAO segmentDAO;
	private BusTypeDAO busTypeDAO;
	
	private List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();
	private List<SegmentInfo> segmentInfos = new ArrayList<SegmentInfo>();
	private List<BusTypeBean> busTypeBeans = new ArrayList<BusTypeBean>();
	private int routeId;
	
	public String execute() {
		segmentBeans = routeDetailsDAO.getAllSegmemtsByRouteId(routeId);
		for (SegmentBean segmentBean : segmentBeans) {
			SegmentInfo segmentInfo = new SegmentInfo();
			String name = segmentBean.getStartAt().getCity().getName() + " - " 
							+ segmentBean.getEndAt().getCity().getName(); 
			segmentInfo.setId(segmentBean.getId());
			segmentInfo.setName(name);
			segmentInfo.setDuration(segmentDAO.getTravelTime(segmentBean.getId()));
			segmentInfos.add(segmentInfo);
		}
		
		List<Object[]> busTypeObjects = busTypeDAO.getBusTypesInRoute(routeId);
		for (Object[] objects : busTypeObjects) {
			BusTypeBean busTypeBean = new BusTypeBean();
			busTypeBean.setId((Integer) objects[0]);
			busTypeBean.setName((String) objects[1]);
			busTypeBean.setNumberOfSeats((Integer) objects[2]);
			busTypeBeans.add(busTypeBean);
		}
		
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

	public SegmentDAO getSegmentDAO() {
		return segmentDAO;
	}

	public void setSegmentDAO(SegmentDAO segmentDAO) {
		this.segmentDAO = segmentDAO;
	}

	public List<SegmentInfo> getSegmentInfos() {
		return segmentInfos;
	}

	public void setSegmentInfos(List<SegmentInfo> segmentInfos) {
		this.segmentInfos = segmentInfos;
	}

	public List<BusTypeBean> getBusTypeBeans() {
		return busTypeBeans;
	}

	public void setBusTypeBeans(List<BusTypeBean> busTypeBeans) {
		this.busTypeBeans = busTypeBeans;
	}

	public BusTypeDAO getBusTypeDAO() {
		return busTypeDAO;
	}

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}
}
