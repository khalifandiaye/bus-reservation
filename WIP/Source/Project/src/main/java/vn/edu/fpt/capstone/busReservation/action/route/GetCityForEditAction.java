package vn.edu.fpt.capstone.busReservation.action.route;


import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.CityDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.CityBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

@ParentPackage("jsonPackage")
public class GetCityForEditAction extends BaseAction {

	private static final long serialVersionUID = 5439903464802687338L;
	private RouteDetailsDAO routeDetailsDAO;
	private CityDAO cityDAO;

	private int routeId;
	
	private List<CityBean> cityBeans;
	private CityBean firstCityBean;
	private CityBean lastCityBean;

	@Action(value = "getCityForEdit", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		List<SegmentBean> segmentBeans = routeDetailsDAO.getAllSegmemtsByRouteId(routeId);
		if (segmentBeans.size() != 0) {
			int i = 0;
			List<CityBean> cityInRoutes = new ArrayList<CityBean>();
			for (SegmentBean segmentBean : segmentBeans) {
				cityInRoutes.add(segmentBean.getStartAt().getCity());
				if (i == 0) {
					firstCityBean = segmentBean.getStartAt().getCity();
				} else if (i == (segmentBeans.size() - 1)) {
					lastCityBean = segmentBean.getEndAt().getCity();
				}
				i++;
			}
			
			cityBeans = cityDAO.getAll();
			for (CityBean cityInRoute : cityInRoutes) {
				i = 0;
				for (CityBean cityBean : cityBeans) {
					if (cityInRoute.getId() == cityBean.getId()){
						cityBeans.remove(i);
					}
					i++;
				}
			}
		}
		return SUCCESS;
	}

	public void setCityDAO(CityDAO cityDAO) {
		this.cityDAO = cityDAO;
	}

	public List<CityBean> getCityBeans() {
		return cityBeans;
	}

	public CityBean getFirstCityBean() {
		return firstCityBean;
	}

	public CityBean getLastCityBean() {
		return lastCityBean;
	}
	public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
		this.routeDetailsDAO = routeDetailsDAO;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

}
