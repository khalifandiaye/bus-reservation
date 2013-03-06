package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

public class EditAction extends BaseAction {

	private static final long serialVersionUID = 6692510134065137743L;

	List<BusTypeBean> busTypeBeans = new ArrayList<BusTypeBean>();
	List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();
	
   public List<SegmentBean> getSegmentBeans() {
      return segmentBeans;
   }

   public void setSegmentBeans(List<SegmentBean> segmentBeans) {
      this.segmentBeans = segmentBeans;
   }

   private int routeId;
	
	//Declaration
	private RouteDetailsDAO routeDetailsDAO;
	private BusTypeDAO busTypeDAO;

   public String execute() {
      segmentBeans = routeDetailsDAO.getAllSegmemtsByRouteId(routeId);
	   busTypeBeans = busTypeDAO.getAll();
		return SUCCESS;
	}

   public int getRouteId() {
      return routeId;
   }

   public void setRouteId(int routeId) {
      this.routeId = routeId;
   }

   public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
      this.routeDetailsDAO = routeDetailsDAO;
   }

   public List<BusTypeBean> getBusTypeBeans() {
      return busTypeBeans;
   }

   public void setBusTypeBeans(List<BusTypeBean> busTypeBeans) {
      this.busTypeBeans = busTypeBeans;
   }

   public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
      this.busTypeDAO = busTypeDAO;
   }
}
