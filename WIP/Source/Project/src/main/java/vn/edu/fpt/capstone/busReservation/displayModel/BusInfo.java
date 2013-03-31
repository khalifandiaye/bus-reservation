package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.util.Date;

public class BusInfo implements Serializable {
   /**
	 * 
	 */
   private static final long serialVersionUID = -2195287469199563262L;
   private int id;
   private String plateNumber;
   private String delete;
   private Date fromDate;
   private Date toDate;

   public int getId() {
      return id;
   }

   public void setId(int id) {
      this.id = id;
   }

   public String getPlateNumber() {
      return plateNumber;
   }

   public void setPlateNumber(String plateNumber) {
      this.plateNumber = plateNumber;
   }

   public String getDelete() {
      return delete;
   }

   public void setDelete(String delete) {
      this.delete = delete;
   }

   public Date getFromDate() {
      return fromDate;
   }

   public void setFromDate(Date fromDate) {
      this.fromDate = fromDate;
   }

   public Date getToDate() {
      return toDate;
   }

   public void setToDate(Date toDate) {
      this.toDate = toDate;
   }

}
