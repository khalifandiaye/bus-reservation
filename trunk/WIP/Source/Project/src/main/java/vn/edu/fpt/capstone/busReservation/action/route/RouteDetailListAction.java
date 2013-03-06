package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentInfo;

import com.opensymphony.xwork2.ActionSupport;

public class RouteDetailListAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	
	private String routeName = "";
	
	private RouteDetailsDAO routeDetailsDAO;
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
			
         long travelTime = segmentBean.getTravelTime();
         Long hours = travelTime / (1000 * 60 * 60);
         Long minutes = (travelTime % (1000 * 60 * 60)) / (1000 * 60);
			segmentInfo.setDuration((hours < 10 ? ("0" + hours.toString()) : hours)
               + ":" + (minutes < 10 ? ("0" + minutes.toString()) : minutes));
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
		
		routeName = segmentBeans.get(0).getStartAt().getCity().getName() 
		      + " - " + segmentBeans.get(segmentBeans.size() - 1).getEndAt().getCity().getName();
		
		return SUCCESS;
	}

	public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
		this.routeDetailsDAO = routeDetailsDAO;
	}

	public int getRouteId() {
		return routeId;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

	public List<SegmentInfo> getSegmentInfos() {
		return segmentInfos;
	}

	public List<BusTypeBean> getBusTypeBeans() {
		return busTypeBeans;
	}

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}

   public String getRouteName() {
      return routeName;
   }

   public void setRouteName(String routeName) {
      this.routeName = routeName;
   }
}
