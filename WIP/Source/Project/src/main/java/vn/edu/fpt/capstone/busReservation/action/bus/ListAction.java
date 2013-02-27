package vn.edu.fpt.capstone.busReservation.action.bus;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;

public class ListAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private List<BusBean> busBeans = new ArrayList<BusBean>();

	private BusDAO busDAO;

	public String execute() {
		busBeans = busDAO.getAll();
		return SUCCESS;
	}

	public List<BusBean> getBusBeans() {
		return busBeans;
	}

	public void setBusBeans(List<BusBean> busBeans) {
		this.busBeans = busBeans;
	}

	public BusDAO getBusDAO() {
		return busDAO;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

}
