package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.TariffDAO;

@ParentPackage("jsonPackage")
public class GetPriceAction extends BaseAction {

   private static final long serialVersionUID = 1L;
   private int segmentId;
	private int busTypeId;

	private TariffDAO tariffDAO;
	private Double currentFare;

	@Action(value = "getPrice", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		Date validDate = Calendar.getInstance().getTime();
		List<Double> currentFares = tariffDAO.getCurrentFares(segmentId,
				busTypeId, validDate);
		if (currentFares.size() != 0) {
			currentFare = currentFares.get(0);
		} else {
			currentFare = (double) 0;
		}
		return SUCCESS;
	}

	public void setBusTypeId(int busTypeId) {
		this.busTypeId = busTypeId;
	}

	public void setSegmentId(int segmentId) {
		this.segmentId = segmentId;
	}

	public void setTariffDAO(TariffDAO tariffDAO) {
		this.tariffDAO = tariffDAO;
	}

	public Double getCurrentFare() {
		return currentFare;
	}
}
