package vn.edu.fpt.capstone.busReservation.action.route;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentTravelTimeDAO;
import vn.edu.fpt.capstone.busReservation.dao.StationDAO;
import vn.edu.fpt.capstone.busReservation.dao.SystemSettingDAO;
import vn.edu.fpt.capstone.busReservation.dao.TariffDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentTravelTimeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentAddInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentInfo;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.DateUtils;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

@ParentPackage("jsonPackage")
public class UpdateSegmentAction extends BaseAction {

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
	private BusTypeDAO busTypeDAO;
	private TariffDAO tariffDAO;
	private SystemSettingDAO systemSettingDAO;

	private String message = "New Route saved successfully!";

	@Action(value = "updateSegment", results = { @Result(type = "json", name = SUCCESS, params = {
			"root", "message" }) })
	public String execute() {
		try {
			SegmentAddInfo segmentAddInfos = mapper.readValue(data,
					new TypeReference<SegmentAddInfo>() {
					});
			
			int routeId = segmentAddInfos.getRouteId();
			List<Integer> routeTerminals = routeDAO.getRouteTerminal(routeId);
			int terminalRouteId = 0;
			if (routeTerminals.size() != 0) {
			   terminalRouteId = routeTerminals.get(1);
			}
			
			List<SegmentInfo> segmentInfosFoward = segmentAddInfos.getSegments();
			
			routeDetailsDAO.deleteRouteDetailByRouteId(routeId);
			routeDetailsDAO.deleteRouteDetailByRouteId(terminalRouteId);

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

			if (segmentBeans.size() != 0 && segmentBeans.size() == segmentInfosFoward.size()) {
				List<RouteBean> routeBeans = routeDAO.getExistRoute(segmentBeans);
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
						
						RouteBean currentRouteForward = routeDAO.getById(routeId);
						currentRouteForward.setStatus("inactive");
						RouteBean currentRouteReturn = routeDAO.getById(terminalRouteId);
						currentRouteReturn.setStatus("inactive");
						
						routeBeans.add(currentRouteReturn);
						routeBeans.add(currentRouteForward);
						
						routeDAO.update(routeBeans);
						

						
						message = "Existed route is re-activated successfully!";
					}
				} else {
					updateSegment(segmentInfosFoward, false, routeId);
					Collections.reverse(segmentInfosFoward);
					if (terminalRouteId != 0) {
					   updateSegment(segmentInfosFoward, true, terminalRouteId);
					}
				}
			} else {
				updateSegment(segmentInfosFoward, false, routeId);
				Collections.reverse(segmentInfosFoward);
				if (terminalRouteId != 0) {
					updateSegment(segmentInfosFoward, true, terminalRouteId);
				}
			}
			
		} catch (Exception e) {
			message = "Error! Please contact admin!";
		}
		return SUCCESS;
	}

	private void updateSegment(List<SegmentInfo> segmentInfos, boolean isReturnRoute, int routeId) throws ParseException {
		List<BusTypeBean> busTypeBeans = busTypeDAO.getAll();
		Double price = Double.parseDouble(systemSettingDAO.getSegmentDefaultPrice().toString());
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
				long dtravelTime = DateUtils.getTime(Integer.parseInt(travelTime[0]), 
				      Integer.parseInt(travelTime[1]), 0);

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
				
				List<TariffBean> tariffBeans = new ArrayList<TariffBean>();
				DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
				String date = dateFormat.format(Calendar.getInstance().getTime());
				Date validDate = FormatUtils.deFormatDate(date,
						"yyyy/MM/dd", CommonConstant.LOCALE_US,
						CommonConstant.DEFAULT_TIME_ZONE);
				//add initiation tariff for this segment.
				for (BusTypeBean busTypeBean : busTypeBeans) {
					TariffBean tariffBean = new TariffBean();
					tariffBean.setSegment(segmentBean);
					tariffBean.setBusType(busTypeBean);
					tariffBean.setFare(price);
					tariffBean.setValidFrom(validDate);
					tariffBeans.add(tariffBean);
				}
				tariffDAO.insert(tariffBeans);
				
			} else {
				if (i == 0) {
					routeName += duplicatedSegmentBeans.get(0).getStartAt().getCity().getName();
				}
				if (i == segmentInfos.size() - 1) {
					routeName += " - " + duplicatedSegmentBeans.get(0).getEndAt().getCity().getName();
				}
				// add segment to route detail
				segmentBeans.add(duplicatedSegmentBeans.get(0));
			}
		}

		RouteBean routeBeanReturn = routeDAO.getById(routeId);
		routeBeanReturn.setName(routeName);
		routeBeanReturn.setStatus("active");
		routeDAO.update(routeBeanReturn);

		for (SegmentBean segmentBean : segmentBeans) {
			RouteDetailsBean routeDetailsBean = new RouteDetailsBean();
			routeDetailsBean.setSegment(segmentBean);
			routeDetailsBean.setRoute(routeBeanReturn);
			routeDetailsDAO.insert(routeDetailsBean);
		}
	}

	public void setTariffDAO(TariffDAO tariffDAO) {
		this.tariffDAO = tariffDAO;
	}

	public void setSystemSettingDAO(SystemSettingDAO systemSettingDAO) {
		this.systemSettingDAO = systemSettingDAO;
	}

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
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
