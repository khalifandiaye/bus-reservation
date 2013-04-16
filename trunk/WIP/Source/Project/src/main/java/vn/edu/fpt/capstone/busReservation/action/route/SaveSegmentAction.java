package vn.edu.fpt.capstone.busReservation.action.route;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentTravelTimeDAO;
import vn.edu.fpt.capstone.busReservation.dao.StationDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentTravelTimeBean;
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
	private SegmentTravelTimeDAO segmentTravelTimeDAO;

	private String message = "New Route saved successfully!";

	@Action(value = "saveSegment", results = { @Result(type = "json", name = SUCCESS, params = {
			"root", "message" }) })
	public String execute() {
		try {
			SegmentAddInfo segmentAddInfos = mapper.readValue(data,
					new TypeReference<SegmentAddInfo>() {
					});
			List<SegmentInfo> segmentInfosFoward = segmentAddInfos
					.getSegments();

			// Verify again, check exacly what route is duplicated, check if
			// route is disabled => enable it
			// if routeId is endabled => message route existed.
			List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();

			// check if any duplicated segment in new route
			for (SegmentInfo segmentInfo : segmentInfosFoward) {
				List<SegmentBean> segments = segmentDAO.getDuplicatedSegment(
						segmentInfo.getStationStartAt(),
						segmentInfo.getStationEndAt());

				if (segments.size() != 0) {
					segmentBeans.add(segments.get(0));
				}
			}

			if (segmentBeans.size() != 0 && segmentBeans.size()==segmentInfosFoward.size()) {
				
				List<RouteBean> routeBeans = routeDAO
						.getExistRoute(segmentBeans);
				if (routeBeans.size() != 0) {
					if (routeBeans.get(0).getStatus().equals("active")) {
						message = "Route existed! Please verify again!";
					} else {
						//add return routebean to the list
						routeBeans.add(routeDAO.getById(routeDAO
								.getRouteTerminal(routeBeans.get(0).getId())
								.get(1)));

						for (RouteBean routeBean : routeBeans) {
							routeBean.setStatus("active");
						}
						routeDAO.update(routeBeans);
						message = "Existed route is re-activated successfully!";
					}
				} else {
					insertSegment(segmentInfosFoward, false);
					Collections.reverse(segmentInfosFoward);
					insertSegment(segmentInfosFoward, true);
				}
			} else {
				insertSegment(segmentInfosFoward, false);
				Collections.reverse(segmentInfosFoward);
				insertSegment(segmentInfosFoward, true);
			}
		} catch (Exception e) {
			message = "Error! Please contact admin!";
		}
		return SUCCESS;
	}

	private void insertSegment(List<SegmentInfo> segmentInfos,
			boolean isReturnRoute) throws ParseException {
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
				segmentDAO.insert(segmentBean);
				// add recent created segment to route detail
				segmentBeans.add(segmentBean);

				// add initiation travel time of recent added segment
				SegmentTravelTimeBean segmentTravelTimeBean = new SegmentTravelTimeBean();
				segmentTravelTimeBean.setSegment(segmentBean);
				segmentTravelTimeBean.setTravelTime(dtravelTime);
				segmentTravelTimeBean.setValidFrom(Calendar.getInstance()
						.getTime());
				segmentTravelTimeDAO.insert(segmentTravelTimeBean);
				
				//add initiation tariff for this segment.
				

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

	public void setSegmentTravelTimeDAO(
			SegmentTravelTimeDAO segmentTravelTimeDAO) {
		this.segmentTravelTimeDAO = segmentTravelTimeDAO;
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
