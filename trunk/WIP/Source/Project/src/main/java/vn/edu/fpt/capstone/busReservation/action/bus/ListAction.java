package vn.edu.fpt.capstone.busReservation.action.bus;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusDAO;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.displayModel.BusStatusInfo;

public class ListAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private List<BusBean> busBeans = new ArrayList<BusBean>();
	private List<RouteBean> routeBeans = new ArrayList<RouteBean>();
	private List<BusTypeBean> busTypeBeans = new ArrayList<BusTypeBean>();
   	private List<BusStatusInfo> listBusStatusInfo;
   
	private BusDAO busDAO;
	private RouteDAO routeDAO;
	private BusTypeDAO busTypeDAO;

	public String execute() {
		busBeans = busDAO.getBusByStatus("active");
		listBusStatusInfo = new ArrayList<BusStatusInfo>();
		
		for(int i = 0; i < busBeans.size();i++){
			BusStatusInfo info = new BusStatusInfo();
			info.setBusId(busBeans.get(i).getId());
			if(busBeans.get(i).getStatusList().size() == 0){
				info.setStatus("UnAssigned");
			}else{
				for(int j = 0; j < busBeans.get(i).getStatusList().size();j++){
					Date fromDate = busBeans.get(i).getStatusList().get(j).getFromDate();
					Date toDate = busBeans.get(i).getStatusList().get(j).getToDate();
					Date now = new Date();
					if("initiation".equalsIgnoreCase(busBeans.get(i).getStatusList().get(j).getBusStatus())){
						info.setStatus("UnSchedule");
					}else if("ontrip".equalsIgnoreCase(busBeans.get(i).getStatusList().get(j).getBusStatus())){
						if(fromDate.getTime() <= now.getTime() && now.getTime() <= toDate.getTime()){
							info.setStatus("Running : " + busBeans.get(i).getForwardRoute().getName());
							break;
						}else{
							info.setStatus("Current location : " + busBeans.get(i).getForwardRoute().getRouteDetails().get(busBeans.get(i).getForwardRoute().getRouteDetails().size()-1).getSegment().getEndAt().getName());
						}
					}else{
						if(fromDate.getTime() == toDate.getTime()){
							info.setStatus("Current location : " + busBeans.get(i).getForwardRoute().getRouteDetails().get(busBeans.get(i).getForwardRoute().getRouteDetails().size()-1).getSegment().getEndAt().getName());
							break;
						}
					}
				}
			}
			listBusStatusInfo.add(info);
		}
		
		routeBeans = routeDAO.getAll();
		busTypeBeans = busTypeDAO.getAll();
		return SUCCESS;
	}
	
	/**
	 * @return the listBusStatusInfo
	 */
	public List<BusStatusInfo> getListBusStatusInfo() {
		return listBusStatusInfo;
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
