package vn.edu.fpt.capstone.busReservation.displayModel;

import java.util.List;

public class TariffUpdateInfo {

	private int routeId;
	private String validDate;
	private int busTypeId;
	private List<TariffInfo> tariffs;
	private boolean addRevert;

	public String getValidDate() {
		return validDate;
	}

	public void setValidDate(String validDate) {
		this.validDate = validDate;
	}

	public List<TariffInfo> getTariffs() {
		return tariffs;
	}

	public void setTariffs(List<TariffInfo> tariffs) {
		this.tariffs = tariffs;
	}

	public int getBusTypeId() {
		return busTypeId;
	}

	public void setBusTypeId(int busTypeId) {
		this.busTypeId = busTypeId;
	}

	public int getRouteId() {
		return routeId;
	}

	public void setRouteId(int routeId) {
		this.routeId = routeId;
	}

   public boolean isAddRevert() {
      return addRevert;
   }

   public void setAddRevert(boolean addRevert) {
      this.addRevert = addRevert;
   }

}
