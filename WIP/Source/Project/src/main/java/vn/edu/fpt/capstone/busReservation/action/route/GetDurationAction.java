package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.StationDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.displayModel.StationInfo;

@ParentPackage("jsonPackage")
public class GetDurationAction extends BaseAction {

	private static final long serialVersionUID = 5439903464802687338L;

	private List<StationBean> stationBeans = new ArrayList<StationBean>();
	private List<StationInfo> stationInfos = new ArrayList<StationInfo>();

	private StationBean startStation;
	private StationBean endStation;
	private String travelTime = "";
	
	private SegmentDAO segmentDAO;

	@Action(value = "getStation", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		List<SegmentBean> segmentBeans = segmentDAO.getDupicatedSegment(startStation, endStation);
		if(segmentBeans.size()!= 0){
			Long hours = segmentBeans.get(0).getTravelTime() / (1000 * 60 * 60);
			Long minutes = (segmentBeans.get(0).getTravelTime() % (1000 * 60 * 60)) / (1000 * 60);
			travelTime =  (hours < 10 ? ("0" + hours.toString()) : hours)
		               + ":" + (minutes < 10 ? ("0" + minutes.toString()) : minutes);
		}
		return travelTime;
	}

	public void setSegmentDAO(SegmentDAO segmentDAO) {
		this.segmentDAO = segmentDAO;
	}

	public void setStartStation(StationBean startStation) {
		this.startStation = startStation;
	}

	public void setEndStation(StationBean endStation) {
		this.endStation = endStation;
	}

	public String getTravelTime() {
		return travelTime;
	}

}
