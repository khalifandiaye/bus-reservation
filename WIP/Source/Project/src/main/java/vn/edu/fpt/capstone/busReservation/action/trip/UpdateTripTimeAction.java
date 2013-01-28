package vn.edu.fpt.capstone.busReservation.action.trip;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;

import com.opensymphony.xwork2.ActionSupport;

public class UpdateTripTimeAction extends ActionSupport {

	private static final long serialVersionUID = -1900533216154623510L;
	private BusDAO busDAO;
	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

	private List<BusBean> busBeans = new ArrayList<BusBean>();

	public String execute() throws ParseException {
//		List<SegmentBean> segmentBeans = new ArrayList<SegmentBean>();
		HttpServletRequest request = ServletActionContext.getRequest();
		String dateString = request.getParameter("date");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd hh:mm");
		Date date = sdf.parse(dateString);
		List<Integer> busyBusIds = busDAO.getBusyBus(date);
		busBeans = busDAO.getAvailBus(busyBusIds);

//		segmentBeans = routeDAO.getAllSegmentByRouteId(routeId);
//		for (SegmentBean segmentBean : segmentBeans) {
//			
//		}
//		System.out.println(segmentBeans.toString());
		return SUCCESS;
	}

	public List<BusBean> getBusBeans() {
		return busBeans;
	}

	public void setBusBeans(List<BusBean> busBeans) {
		this.busBeans = busBeans;
	}
}
