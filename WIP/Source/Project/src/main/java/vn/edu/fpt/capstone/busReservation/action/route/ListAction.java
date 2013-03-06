package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.displayModel.RouteDetailsInfo;

import com.opensymphony.xwork2.ActionSupport;

public class ListAction extends ActionSupport {

   /**
	 * 
	 */
   private static final long serialVersionUID = 1L;

   private RouteDAO routeDAO;
   private RouteDetailsDAO routeDetailsDAO;

   public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
      this.routeDetailsDAO = routeDetailsDAO;
   }

   private List<RouteBean> routeBeans = new ArrayList<RouteBean>();
   private List<RouteDetailsInfo> routeInfos = new ArrayList<RouteDetailsInfo>();

   public String execute() {
      routeBeans = routeDAO.getAllActiveRoute();
      for (RouteBean routeBean : routeBeans) {
         RouteDetailsInfo routeDetailsInfo = new RouteDetailsInfo();
         int routeId = routeBean.getId();
         long travelTime = 0;
         routeDetailsInfo.setId(routeId);
         routeDetailsInfo.setRouteName(routeBean.getName());
         List<SegmentBean> segments = routeDetailsDAO.getAllSegmemtsByRouteId(routeId);
         for (SegmentBean segmentBean : segments) {
            travelTime += segmentBean.getTravelTime();
         }

         Long hours = travelTime / (1000 * 60 * 60);
         Long minutes = (travelTime % (1000 * 60 * 60)) / (1000 * 60);

         routeDetailsInfo.setTravelTime((hours < 10 ? ("0" + hours.toString()) : hours)
               + ":" + (minutes < 10 ? ("0" + minutes.toString()) : minutes));
         routeInfos.add(routeDetailsInfo);
      }
      return SUCCESS;
   }

   public List<RouteBean> getRouteBeans() {
      return routeBeans;
   }

   public RouteDAO getRouteDAO() {
      return routeDAO;
   }

   public void setRouteDAO(RouteDAO routeDAO) {
      this.routeDAO = routeDAO;
   }

   public List<RouteDetailsInfo> getRouteInfos() {
      return routeInfos;
   }

   public void setRouteInfos(List<RouteDetailsInfo> routeInfos) {
      this.routeInfos = routeInfos;
   }
}
