package vn.edu.fpt.capstone.busReservation.action.bus;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;

@ParentPackage("jsonPackage")
public class SaveBusAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String plateNumber;
	private int busTypeBeans;
	private String message = "Save Bus Success!";

	private BusTypeDAO busTypeDAO;
	private BusDAO busDAO;

	@Action(value = "/saveBus", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		try {
			List<BusBean> busBeans = busDAO.getBusByplateNumber(plateNumber);
			if (busBeans.size() == 0) {
				BusTypeBean busTypeBean = busTypeDAO.getById(busTypeBeans);
				BusBean busBean = new BusBean();
				busBean.setBusType(busTypeBean);
				busBean.setPlateNumber(plateNumber);
				busBean.setStatus("active");
				busDAO.insert(busBean);
			} else {
				setMessage("Bus Plate number is existed!");
			}
		} catch (Exception ex) {
			setMessage("Save bus failed!");
		}
		return SUCCESS;
	}

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}

	public void setPlateNumber(String plateNumber) {
		this.plateNumber = plateNumber;
	}

	public void setBusTypeBeans(int busTypeBeans) {
		this.busTypeBeans = busTypeBeans;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
