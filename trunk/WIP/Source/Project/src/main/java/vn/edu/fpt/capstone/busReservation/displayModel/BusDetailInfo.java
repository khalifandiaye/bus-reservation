package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.util.List;

public class BusDetailInfo implements Serializable {

   private static final long serialVersionUID = 1L;
   /**
	 * 
	 */
   private int routeId;
   private List<BusInfo> bus;
   private List<BusInfo> unSelectBus;

   public int getRouteId() {
      return routeId;
   }

   public void setRouteId(int routeId) {
      this.routeId = routeId;
   }

   public List<BusInfo> getBus() {
      return bus;
   }

   public void setBus(List<BusInfo> bus) {
      this.bus = bus;
   }

   public List<BusInfo> getUnSelectBus() {
      return unSelectBus;
   }

   public void setUnSelectBus(List<BusInfo> unSelectBus) {
      this.unSelectBus = unSelectBus;
   }

}
