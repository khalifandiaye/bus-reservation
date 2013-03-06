package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.TariffDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;
import vn.edu.fpt.capstone.busReservation.displayModel.TariffInfo;

public class EditAction extends BaseAction {

	private static final long serialVersionUID = 6692510134065137743L;

	List<TariffInfo> tariffInfos = new ArrayList<TariffInfo>();
	List<BusTypeBean> busTypeBeans = new ArrayList<BusTypeBean>();
	
   private int routeId;
	private int type;
	
	//Declaration
	private TripDAO tripDAO;
	private RouteDetailsDAO routeDetailsDAO;
	private TariffDAO tariffDAO;
	private BusTypeDAO busTypeDAO;

	public TariffDAO getTariffDAO() {
      return tariffDAO;
   }

   public void setTariffDAO(TariffDAO tariffDAO) {
      this.tariffDAO = tariffDAO;
   }

   public String execute() {
	   List<SegmentBean> segmentBeans = routeDetailsDAO.getAllSegmemtsByRouteId(routeId);
	   for (SegmentBean segmentBean : segmentBeans) {
	      List<TariffBean> resultList = tariffDAO.getPrice(segmentBean.getId(), type);
         if (!resultList.isEmpty()) {
            TariffBean tariffBean = resultList.get(0);
            TariffInfo tariffInfo = new TariffInfo();
            tariffInfo.setSegmentId(tariffBean.getSegment().getId()); 
            tariffInfo.setStartAt(tariffBean.getSegment().getStartAt().getCity().getName());
            tariffInfo.setEndAt(tariffBean.getSegment().getEndAt().getCity().getName());
            tariffInfo.setFare(tariffBean.getFare());
            tariffInfos.add(tariffInfo);
         }
      }
	   busTypeBeans = busTypeDAO.getAll();
		return SUCCESS;
	}

   public int getRouteId() {
      return routeId;
   }

   public void setRouteId(int routeId) {
      this.routeId = routeId;
   }

   public TripDAO getTripDAO() {
      return tripDAO;
   }

   public void setTripDAO(TripDAO tripDAO) {
      this.tripDAO = tripDAO;
   }

   public int getType() {
      return type;
   }

   public void setType(int type) {
      this.type = type;
   }

   public RouteDetailsDAO getRouteDetailsDAO() {
      return routeDetailsDAO;
   }

   public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
      this.routeDetailsDAO = routeDetailsDAO;
   }

   public List<BusTypeBean> getBusTypeBeans() {
      return busTypeBeans;
   }

   public void setBusTypeBeans(List<BusTypeBean> busTypeBeans) {
      this.busTypeBeans = busTypeBeans;
   }

   public List<TariffInfo> getTariffInfos() {
      return tariffInfos;
   }

   public void setTariffInfos(List<TariffInfo> tariffInfos) {
      this.tariffInfos = tariffInfos;
   }

   public BusTypeDAO getBusTypeDAO() {
      return busTypeDAO;
   }

   public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
      this.busTypeDAO = busTypeDAO;
   }
}
