package vn.edu.fpt.capstone.busReservation.action.busStatus;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;

import com.opensymphony.xwork2.ActionSupport;

public class ListAction extends ActionSupport {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8867777710173565274L;

	private BusStatusDAO busStatusDAO;
	
	private List<BusStatusBean> busStatusBeans = new ArrayList<BusStatusBean>();

	public String execute() {
		busStatusBeans = busStatusDAO.getAll();
		return SUCCESS;
	}

	public List<BusStatusBean> getBusStatusBeans() {
		return busStatusBeans;
	}

	public void setBusStatusBeans(List<BusStatusBean> busStatusBeans) {
		this.busStatusBeans = busStatusBeans;
	}
}
