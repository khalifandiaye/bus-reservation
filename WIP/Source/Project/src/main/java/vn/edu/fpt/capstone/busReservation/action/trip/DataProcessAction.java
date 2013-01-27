package vn.edu.fpt.capstone.busReservation.action.trip;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.web.HttpRequestHandler;

import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;

import com.opensymphony.xwork2.ActionSupport;

public class DataProcessAction extends ActionSupport{
		
	private TripBean trip = new TripBean();
	
	public String execute(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String action = request.getParameter("createTrip");
		return SUCCESS;
	}

	public TripBean getTrip() {
		return trip;
	}

	public void setTrip(TripBean trip) {
		this.trip = trip;
	}

}
