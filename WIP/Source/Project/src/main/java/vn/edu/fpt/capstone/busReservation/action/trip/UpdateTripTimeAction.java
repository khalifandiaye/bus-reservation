package vn.edu.fpt.capstone.busReservation.action.trip;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.ParentPackage;

import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;

import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("transactionalPackage")
public class UpdateTripTimeAction extends ActionSupport {

	private static final long serialVersionUID = -1900533216154623510L;
	private BusDAO busDAO;
	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

	private List<BusBean> busBeans = new ArrayList<BusBean>();

	public String execute() throws ParseException {
		HttpServletRequest request = ServletActionContext.getRequest();
		String dateString = request.getParameter("date");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd hh:mm");
		Date date = sdf.parse(dateString);
		List<Integer> busyBusIds = busDAO.getBusyBus(date);
		return SUCCESS;
	}

	public List<BusBean> getBusBeans() {
		return busBeans;
	}

	public void setBusBeans(List<BusBean> busBeans) {
		this.busBeans = busBeans;
	}
}
