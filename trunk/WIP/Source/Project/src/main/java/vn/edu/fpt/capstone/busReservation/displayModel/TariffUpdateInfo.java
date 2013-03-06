package vn.edu.fpt.capstone.busReservation.displayModel;

import java.util.List;

public class TariffUpdateInfo {

   private String validDate;
   private int busTypeId;
   private List<TariffInfo> tariffs;

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

}
