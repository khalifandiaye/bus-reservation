package vn.edu.fpt.capstone.busReservation.action.route;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.StationDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentAddInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentInfo;
import vn.edu.fpt.capstone.busReservation.util.DateUtils;

@ParentPackage("jsonPackage")
public class SaveSegmentAction extends BaseAction {

   /**
	 * 
	 */
   private static final long serialVersionUID = -6013335986990979597L;

   private String data;

   private static ObjectMapper mapper = new ObjectMapper();

   // Declare dao object
   private StationDAO stationDAO;
   private SegmentDAO segmentDAO;
   private RouteDAO routeDAO;
   private RouteDetailsDAO routeDetailsDAO;

   private String message = "New Route saved successfully!";

   @Action(value = "saveSegment", results = { @Result(type = "json", name = SUCCESS, params = {
         "root", "message" }) })
   public String execute() throws JsonParseException, JsonMappingException,
         IOException, ParseException {
      SegmentAddInfo segmentAddInfos = mapper.readValue(data,
            new TypeReference<SegmentAddInfo>() {
            });
      List<SegmentInfo> segmentInfosFoward = segmentAddInfos.getSegments();

      if (!segmentInfosFoward.isEmpty()) {
         insertSegment(segmentInfosFoward, segmentAddInfos, false);

         Collections.reverse(segmentInfosFoward);
         insertSegment(segmentInfosFoward, segmentAddInfos, true);
      }
      return SUCCESS;
   }

   private void insertSegment(List<SegmentInfo> segmentInfos,
         SegmentAddInfo segmentAddInfos, boolean isReturnRoute)
         throws ParseException {
      String routeName = "";
      List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();

		//
		// for (int i = 0; i < segmentInfos.size(); i++) {
		// StationBean startStation = new StationBean();
		// StationBean endStation = new StationBean();
		//
		// List<SegmentBean> duplicatedSegments = segmentDAO
		// .getDupicatedSegment(startStation, endStation);
		// SegmentBean segmentBean = new SegmentBean();
		// if (duplicatedSegments.size() > 0) {
		// String stravelTime = segmentInfos.get(i).getDuration();
		// String[] travelTime = stravelTime.split(":");
		// long dtravelTime = DateUtils.getTime(
		// Integer.parseInt(travelTime[0]),
		// Integer.parseInt(travelTime[1]), 0);
		//
		// if (!isReturnRoute) {
		// startStation = stationDAO.getById(segmentInfos.get(i)
		// .getStationStartAt());
		// endStation = stationDAO.getById(segmentInfos.get(i)
		// .getStationEndAt());
		// } else {
		// endStation = stationDAO.getById(segmentInfos.get(i)
		// .getStationStartAt());
		// startStation = stationDAO.getById(segmentInfos.get(i)
		// .getStationEndAt());
		// }
		//
		// if (i == 0) {
		// routeName += startStation.getCity().getName();
		// }
		// if (i == segmentInfos.size() - 1) {
		// routeName += " - " + endStation.getCity().getName();
		// }
		//
		// segmentBean.setStartAt(startStation);
		// segmentBean.setEndAt(endStation);
		// segmentBean.setTravelTime(dtravelTime);
		// segmentBean.setStatus("active");
		// segmentDAO.insert(segmentBean);
		// } else {
		// segmentBean = duplicatedSegments.get(0);
		// }
		// segmentBeans.add(segmentBean);
		// }
      
      for (int i = 0; i < segmentInfos.size(); i++) {
         SegmentBean segmentBean = new SegmentBean();
         String stravelTime = segmentInfos.get(i).getDuration();
         String[] travelTime = stravelTime.split(":");
         long dtravelTime = DateUtils.getTime(Integer.parseInt(travelTime[0]),
               Integer.parseInt(travelTime[1]), 0);

         StationBean startStation = new StationBean();
         StationBean endStation = new StationBean();
         
         if (!isReturnRoute) {
            startStation = stationDAO.getById(segmentInfos.get(i).getStationStartAt());
            endStation = stationDAO.getById(segmentInfos.get(i).getStationEndAt());
         } else {
            endStation = stationDAO.getById(segmentInfos.get(i).getStationStartAt());
            startStation = stationDAO.getById(segmentInfos.get(i).getStationEndAt());
         }
         
         if (i == 0) {
            routeName += startStation.getCity().getName();
         }
         if (i == segmentInfos.size() - 1) {
            routeName += " - " + endStation.getCity().getName();
         }
         
         segmentBean.setStartAt(startStation);
         segmentBean.setEndAt(endStation);
         segmentBean.setTravelTime(dtravelTime);
         segmentBean.setStatus("active");
         segmentDAO.insert(segmentBean);
         segmentBeans.add(segmentBean);
      }

      RouteBean routeBeanReturn = new RouteBean();
      routeBeanReturn.setName(routeName);
      routeBeanReturn.setStatus("active");
      routeDAO.insert(routeBeanReturn);

      for (SegmentBean segmentBean : segmentBeans) {
         RouteDetailsBean routeDetailsBean = new RouteDetailsBean();
         routeDetailsBean.setSegment(segmentBean);
         routeDetailsBean.setRoute(routeBeanReturn);
         routeDetailsDAO.insert(routeDetailsBean);
      }
   }

   public String getData() {
      return data;
   }

   public void setData(String data) {
      this.data = data;
   }

   public void setStationDAO(StationDAO stationDAO) {
      this.stationDAO = stationDAO;
   }

   public void setSegmentDAO(SegmentDAO segmentDAO) {
      this.segmentDAO = segmentDAO;
   }

   public void setRouteDAO(RouteDAO routeDAO) {
      this.routeDAO = routeDAO;
   }

   public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
      this.routeDetailsDAO = routeDetailsDAO;
   }

   public String getMessage() {
      return message;
   }
}
