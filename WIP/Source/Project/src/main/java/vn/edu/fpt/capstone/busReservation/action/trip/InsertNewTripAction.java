package vn.edu.fpt.capstone.busReservation.action.trip;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.web.HttpRequestHandler;

import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;

import com.opensymphony.xwork2.ActionSupport;

public class InsertNewTripAction extends ActionSupport{
		
	private static final long serialVersionUID = 3916263183042873075L;
	private int routeSelect;
	private String departDate;
	private String busPlateSelect;
	
	public String execute(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String action = request.getParameter("createTrip");
		return SUCCESS;
	}

	public int getRouteSelect() {
		return routeSelect;
	}

	public void setRouteSelect(int routeSelect) {
		this.routeSelect = routeSelect;
	}

	public String getDepartDate() {
		return departDate;
	}

	public void setDepartDate(String departDate) {
		this.departDate = departDate;
	}

	public String getBusPlateSelect() {
		return busPlateSelect;
	}

	public void setBusPlateSelect(String busPlateSelect) {
		this.busPlateSelect = busPlateSelect;
	}

}
