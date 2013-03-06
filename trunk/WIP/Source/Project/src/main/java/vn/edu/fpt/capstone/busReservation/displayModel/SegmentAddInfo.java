package vn.edu.fpt.capstone.busReservation.displayModel;

import java.util.List;

public class SegmentAddInfo {

   private int busType;
   private List<SegmentInfo> segments;
   private String validDate;

   public int getBusType() {
      return busType;
   }

   public void setBusType(int busType) {
      this.busType = busType;
   }

   public List<SegmentInfo> getSegments() {
      return segments;
   }

   public void setSegments(List<SegmentInfo> segments) {
      this.segments = segments;
   }

   public String getValidDate() {
      return validDate;
   }

   public void setValidDate(String validDate) {
      this.validDate = validDate;
   }

}
