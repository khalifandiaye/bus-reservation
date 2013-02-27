package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.StationDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.displayModel.StationInfo;

@ParentPackage("jsonPackage")
public class GetStationAction extends BaseAction {

	private static final long serialVersionUID = 5439903464802687338L;
	
	private List<StationBean> stationBeans = new ArrayList<StationBean>();
	private List<StationInfo> stationInfos = new ArrayList<StationInfo>();

	private int cityId;
	
	private StationDAO stationDAO;

	@Action(value = "getStation", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		stationBeans = stationDAO.getStationsByCity(cityId);
		for (StationBean stationBean : stationBeans) {
			StationInfo stationInfo = new StationInfo(stationBean.getId(), stationBean.getName());
			stationInfos.add(stationInfo);
		}
		return SUCCESS;
	}

	public void setStationBeans(List<StationBean> stationBeans) {
		this.stationBeans = stationBeans;
	}

	public void setStationDAO(StationDAO stationDAO) {
		this.stationDAO = stationDAO;
	}

	public void setCityId(int cityId) {
		this.cityId = cityId;
	}

	public List<StationInfo> getStationInfos() {
		return stationInfos;
	}
}
