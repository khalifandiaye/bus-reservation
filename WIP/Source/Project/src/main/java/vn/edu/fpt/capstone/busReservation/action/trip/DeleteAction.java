package vn.edu.fpt.capstone.busReservation.action.trip;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;

import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("jsonPackage")
public class DeleteAction extends ActionSupport {

	private static final long serialVersionUID = -268527492772036231L;
	private TripDAO tripDAO;
	public TripDAO getTripDAO() {
		return tripDAO;
	}

	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
	}

	public TripBean getTripBean() {
		return tripBean;
	}

	public void setTripBean(TripBean tripBean) {
		this.tripBean = tripBean;
	}

	private TripBean tripBean;
	private int id; 

	@Action(value = "/delete", results = { @Result(type = "json", name = SUCCESS, params = {
            "includeProperties", "reservationInfo, errorMessage" }) })
	public String execute() {
		tripBean =  tripDAO.getById(id);
		tripBean.setStatus("inactive");
		tripDAO.update(tripBean);
		return SUCCESS;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
}
