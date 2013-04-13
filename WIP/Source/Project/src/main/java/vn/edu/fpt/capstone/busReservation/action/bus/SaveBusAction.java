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
	private int resultId = 0;

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
			}
			if (busBeans.size() != 0) {
				if (busBeans.get(0).getStatus().equals("inactive")) {
					busBeans.get(0).setStatus("active");
					busDAO.update(busBeans.get(0));
				} else {
					setMessage("Bus Plate number is existed!");
					resultId = 1;
				}
			}
		} catch (Exception ex) {
			setMessage("Save bus failed!");
			resultId = 2;
		}
		return SUCCESS;
	}

	public int getResultId() {
		return resultId;
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
