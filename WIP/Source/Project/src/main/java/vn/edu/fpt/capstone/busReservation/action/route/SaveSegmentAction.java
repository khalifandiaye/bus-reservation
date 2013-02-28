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
	public String execute() throws JsonParseException, JsonMappingException,IOException, ParseException {
		SegmentAddInfo segmentAddInfos = mapper.readValue(data,
			new TypeReference<SegmentAddInfo>() {});
		String routeName = "";
		List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();
		List<SegmentInfo> segmentInfos = segmentAddInfos.getSegments();
		if (!segmentInfos.isEmpty()) {
			for (int i = 0; i < segmentInfos.size(); i++) {
				SegmentBean segmentBean = new SegmentBean();
				
				String stravelTime = segmentInfos.get(i).getDuration();
				DateFormat sdf = new SimpleDateFormat("hh:mm");
				Date travelTime = sdf.parse(stravelTime);

				StationBean startStation = stationDAO.getById(segmentInfos.get(i).getStationStartAt());
				StationBean endStation = stationDAO.getById(segmentInfos.get(i).getStationEndAt());
				if (i == 0) {
					routeName += startStation.getCity().getName();
				}
				if (i == segmentInfos.size() - 1) {
					routeName += " - " + endStation.getCity().getName();
				}
				segmentBean.setStartAt(startStation);
				segmentBean.setEndAt(endStation);
				segmentBean.setTravelTime(travelTime);
				segmentBean.setStatus("active");
				segmentDAO.insert(segmentBean);
				segmentBeans.add(segmentBean);

				TariffBean tariffBean = new TariffBean();
				BusTypeBean busTypeBean = busTypeDAO.getById(segmentAddInfos.getBusType());
				tariffBean.setBusType(busTypeBean);
				tariffBean.setFare(segmentInfos.get(i).getPrice());
				tariffBean.setSegment(segmentBean);
				tariffBean.setValidFrom(Calendar.getInstance().getTime());
				tariffDAO.insert(tariffBean);
			}

			RouteBean routeBean = new RouteBean();
			routeBean.setName(routeName);
			routeBean.setStatus("active");
			routeDAO.insert(routeBean);

			for (SegmentBean segmentBean : segmentBeans) {
				RouteDetailsBean routeDetailsBean = new RouteDetailsBean();
				routeDetailsBean.setSegment(segmentBean);
				routeDetailsBean.setRoute(routeBean);
				routeDetailsDAO.insert(routeDetailsBean);
			}
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
