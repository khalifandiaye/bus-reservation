package vn.edu.fpt.capstone.busReservation.action.bus;


import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;

public class SaveBusAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String plateNumber;
	private int busTypeBeans;

	private BusTypeDAO busTypeDAO;
	private BusDAO busDAO;
	private BusStatusDAO busStatusDAO;

	@Action(results = { @Result(name = "success", location = "list.html", type = "redirect") })
	public String execute() {
		BusTypeBean busTypeBean = busTypeDAO.getById(busTypeBeans);
		BusBean busBean = new BusBean();
		busBean.setBusType(busTypeBean);
		busBean.setPlateNumber(plateNumber);
		busBean.setStatus("active");
		busDAO.insert(busBean);
		return SUCCESS;
	}

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}

	public String getPlateNumber() {
		return plateNumber;
	}

	public void setPlateNumber(String plateNumber) {
		this.plateNumber = plateNumber;
	}

	public int getBusTypeBeans() {
		return busTypeBeans;
	}

	public void setBusTypeBeans(int busTypeBeans) {
		this.busTypeBeans = busTypeBeans;
	}

	public BusDAO getBusDAO() {
		return busDAO;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

	public BusStatusDAO getBusStatusDAO() {
		return busStatusDAO;
	}

	public void setBusStatusDAO(BusStatusDAO busStatusDAO) {
		this.busStatusDAO = busStatusDAO;
	}
}
