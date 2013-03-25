package vn.edu.fpt.capstone.busReservation.action.route;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
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
	public String execute() {
		try {
			SegmentAddInfo segmentAddInfos = mapper.readValue(data, new TypeReference<SegmentAddInfo>() { });
			List<SegmentInfo> segmentInfosFoward = segmentAddInfos.getSegments();
			
         if (!isRouteExist(segmentInfosFoward)) {
            if (!segmentInfosFoward.isEmpty()) {
               insertSegment(segmentInfosFoward, false);
               Collections.reverse(segmentInfosFoward);
               insertSegment(segmentInfosFoward, true);
            }
         } else {
            message = "Route existed! Please verify again!";
         }
		} catch (Exception e) {
		   message = "Error! Please contact admin!";
		}
		return SUCCESS;
	}

	private boolean isRouteExist(List<SegmentInfo> segmentInfos) {
      Set<Integer> newStations = new HashSet<Integer>();
      
      for (SegmentInfo segmentInfo : segmentInfos) {
         newStations.add(segmentInfo.getStartAt());
         newStations.add(segmentInfo.getEndAt());
      }
      
      List<RouteBean> routeBeans = routeDAO.getAll();
      for (RouteBean routeBean : routeBeans) {
         List<RouteDetailsBean> segmentBeans = routeBean.getRouteDetails();
         Set<Integer> stations = new HashSet<Integer>();
         for (RouteDetailsBean routeDetailsBean : segmentBeans) {
            SegmentBean segmentBean = routeDetailsBean.getSegment();
            stations.add(segmentBean.getStartAt().getCity().getId());
            stations.add(segmentBean.getEndAt().getCity().getId());
         }
         if (stations.size() == newStations.size() && stations.containsAll(newStations)) {
            return true;
         }
      }
	   
	   return false;
	}
	
	private void insertSegment(List<SegmentInfo> segmentInfos, boolean isReturnRoute)
			throws ParseException {
		String routeName = "";
		List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();

		for (int i = 0; i < segmentInfos.size(); i++) {

			// Check if segment exist
			StationBean startStation = new StationBean();
			StationBean endStation = new StationBean();

			List<SegmentBean> duplicatedSegmentBeans = new ArrayList<SegmentBean>();
			if (!isReturnRoute) {
				duplicatedSegmentBeans = segmentDAO.getDuplicatedSegment(
						segmentInfos.get(i).getStationStartAt(), segmentInfos
								.get(i).getStationEndAt());
			} else {
				duplicatedSegmentBeans = segmentDAO.getDuplicatedSegment(
						segmentInfos.get(i).getStationEndAt(), segmentInfos
								.get(i).getStationStartAt());
			}

			// add new segment
			if (duplicatedSegmentBeans.size() == 0) {
				SegmentBean segmentBean = new SegmentBean();
				String stravelTime = segmentInfos.get(i).getDuration();
				String[] travelTime = stravelTime.split(":");
				long dtravelTime = DateUtils.getTime(
						Integer.parseInt(travelTime[0]),
						Integer.parseInt(travelTime[1]), 0);

				if (!isReturnRoute) {
					startStation = stationDAO.getById(segmentInfos.get(i)
							.getStationStartAt());
					endStation = stationDAO.getById(segmentInfos.get(i)
							.getStationEndAt());

				} else {
					endStation = stationDAO.getById(segmentInfos.get(i)
							.getStationStartAt());
					startStation = stationDAO.getById(segmentInfos.get(i)
							.getStationEndAt());
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
				segmentDAO.insert(segmentBean);
				// add recent created segment to route detail
				segmentBeans.add(segmentBean);
			} else {
				if (i == 0) {
					routeName += duplicatedSegmentBeans.get(0).getStartAt()
							.getCity().getName();
				}
				if (i == segmentInfos.size() - 1) {
					routeName += " - "
							+ duplicatedSegmentBeans.get(0).getEndAt()
									.getCity().getName();
				}
				// add segment to route detail
				segmentBeans.add(duplicatedSegmentBeans.get(0));
			}
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
