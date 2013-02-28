package vn.edu.fpt.capstone.busReservation.action.route;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.StationDAO;
import vn.edu.fpt.capstone.busReservation.dao.TariffDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;
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
	private TariffDAO tariffDAO;
	private BusTypeDAO busTypeDAO;

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}

	private String message = "Save Success!";

	@Action(value = "saveSegment", results = { @Result(type = "json", name = SUCCESS, params = {
			"root", "message" }) })
	public String execute() throws JsonParseException, JsonMappingException,
			IOException, ParseException {
		SegmentAddInfo segmentAddInfos = mapper.readValue(data,new TypeReference<SegmentAddInfo>() {});
		String routeNameForward = "";
		String routeNameReturn = "";
		List<SegmentBean> segmentBeansForward = new ArrayList<SegmentBean>();
		List<SegmentInfo> segmentInfosFoward = segmentAddInfos.getSegments();

		List<SegmentBean> segmentBeansReturn = new ArrayList<SegmentBean>();
		List<SegmentInfo> segmentInfosReturn = new ArrayList<SegmentInfo>();

		// add data for segmentBeanReturn segmentInfosReturn
		for (int i = 0; i < segmentBeansReturn.size(); i++) {
			segmentBeansReturn.add(segmentBeansForward.get(segmentBeansForward.size() - 1 - i));
		}
		for (int i = 0; i < segmentInfosFoward.size(); i++) {
			segmentInfosReturn.add(segmentInfosFoward.get(segmentInfosFoward
					.size() - 1 - i));
		}

		if (!segmentInfosFoward.isEmpty()) {
			for (int i = 0; i < segmentInfosFoward.size(); i++) {
				SegmentBean segmentBean = new SegmentBean();

				String stravelTime = segmentInfosFoward.get(i).getDuration();
				String[] travelTime = stravelTime.split(":");
				Date dtravelTime = DateUtils.getTime(Integer.parseInt(travelTime[0]), 
						Integer.parseInt(travelTime[1]), Integer.parseInt(travelTime[2]));

				StationBean startStation = stationDAO.getById(segmentInfosFoward.get(i).getStationStartAt());
				StationBean endStation = stationDAO.getById(segmentInfosFoward.get(i).getStationEndAt());
				if (i == 0) {
					routeNameForward += startStation.getCity().getName();
				}
				if (i == segmentInfosFoward.size() - 1) {
					routeNameForward += " - " + endStation.getCity().getName();
				}
				segmentBean.setStartAt(startStation);
				segmentBean.setEndAt(endStation);
				segmentBean.setTravelTime(dtravelTime);
				segmentBean.setStatus("active");
				segmentDAO.insert(segmentBean);
				segmentBeansForward.add(segmentBean);

				TariffBean tariffBean = new TariffBean();
				BusTypeBean busTypeBean = busTypeDAO.getById(segmentAddInfos
						.getBusType());
				tariffBean.setBusType(busTypeBean);
				tariffBean.setFare(segmentInfosFoward.get(i).getPrice());
				tariffBean.setSegment(segmentBean);
				tariffBean.setValidFrom(Calendar.getInstance().getTime());
				tariffDAO.insert(tariffBean);
			}

			RouteBean routeBeanForward = new RouteBean();
			routeBeanForward.setName(routeNameForward);
			routeBeanForward.setStatus("active");
			routeDAO.insert(routeBeanForward);

			for (SegmentBean segmentBean : segmentBeansForward) {
				RouteDetailsBean routeDetailsBean = new RouteDetailsBean();
				routeDetailsBean.setSegment(segmentBean);
				routeDetailsBean.setRoute(routeBeanForward);
				routeDetailsDAO.insert(routeDetailsBean);
			}
			
			routeNameReturn = "";
			//Add return route
			for (int i = 0; i < segmentInfosReturn.size(); i++) {
				SegmentBean segmentBean = new SegmentBean();

				String stravelTime = segmentInfosFoward.get(i).getDuration();
				String[] travelTime = stravelTime.split(":");
				Date dtravelTime = DateUtils.getTime(Integer.parseInt(travelTime[0]), 
						Integer.parseInt(travelTime[1]), Integer.parseInt(travelTime[2]));

				StationBean startStation = stationDAO.getById(segmentInfosReturn.get(i).getStationEndAt());
				StationBean endStation = stationDAO.getById(segmentInfosReturn.get(i).getStationStartAt());
				if (i == 0) {
					routeNameReturn += startStation.getCity().getName();
				}
				if (i == segmentInfosReturn.size() - 1) {
					routeNameReturn += " - " + endStation.getCity().getName();
				}
				segmentBean.setStartAt(startStation);
				segmentBean.setEndAt(endStation);
				segmentBean.setTravelTime(dtravelTime);
				segmentBean.setStatus("active");
				segmentDAO.insert(segmentBean);
				segmentBeansReturn.add(segmentBean);

				TariffBean tariffBean = new TariffBean();
				BusTypeBean busTypeBean = busTypeDAO.getById(segmentAddInfos
						.getBusType());
				tariffBean.setBusType(busTypeBean);
				tariffBean.setFare(segmentInfosReturn.get(i).getPrice());
				tariffBean.setSegment(segmentBean);
				tariffBean.setValidFrom(Calendar.getInstance().getTime());
				tariffDAO.insert(tariffBean);
			}

			RouteBean routeBeanReturn = new RouteBean();
			routeBeanReturn.setName(routeNameReturn);
			routeBeanReturn.setStatus("active");
			routeDAO.insert(routeBeanReturn);

			for (SegmentBean segmentBean : segmentBeansReturn) {
				RouteDetailsBean routeDetailsBean = new RouteDetailsBean();
				routeDetailsBean.setSegment(segmentBean);
				routeDetailsBean.setRoute(routeBeanReturn);
				routeDetailsDAO.insert(routeDetailsBean);
			}
			//Finish add return route

		}
		return SUCCESS;
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

	public void setTariffDAO(TariffDAO tariffDAO) {
		this.tariffDAO = tariffDAO;
	}

	public String getMessage() {
		return message;
	}
}
