package vn.edu.fpt.capstone.busReservation.action.bus;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;

public class ListAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private List<BusBean> busBeans = new ArrayList<BusBean>();
	private List<RouteBean> routeBeans = new ArrayList<RouteBean>();
   private List<BusTypeBean> busTypeBeans = new ArrayList<BusTypeBean>();

	private BusDAO busDAO;
	private RouteDAO routeDAO;
   private BusTypeDAO busTypeDAO;

	public String execute() {
		busBeans = busDAO.getBusByStatus("active");
		routeBeans = routeDAO.getAll();
      busTypeBeans = busTypeDAO.getAll();
		return SUCCESS;
	}

	public List<BusBean> getBusBeans() {
		return busBeans;
	}

	public void setBusBeans(List<BusBean> busBeans) {
		this.busBeans = busBeans;
	}

	public void setBusDAO(BusDAO busDAO) {
		this.busDAO = busDAO;
	}

   public List<RouteBean> getRouteBeans() {
      return routeBeans;
   }

   public void setRouteBeans(List<RouteBean> routeBeans) {
      this.routeBeans = routeBeans;
   }

   public List<BusTypeBean> getBusTypeBeans() {
      return busTypeBeans;
   }

   public void setBusTypeBeans(List<BusTypeBean> busTypeBeans) {
      this.busTypeBeans = busTypeBeans;
   }

   public void setRouteDAO(RouteDAO routeDAO) {
      this.routeDAO = routeDAO;
   }

   public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
      this.busTypeDAO = busTypeDAO;
   }

}
