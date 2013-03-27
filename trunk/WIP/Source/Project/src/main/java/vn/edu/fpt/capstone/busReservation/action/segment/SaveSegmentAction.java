package vn.edu.fpt.capstone.busReservation.action.segment;

import java.util.Date;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentTravelTimeDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentTravelTimeBean;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.DateUtils;

@ParentPackage("jsonPackage")
public class SaveSegmentAction extends BaseAction {

   /**
	 * 
	 */
   private static final long serialVersionUID = 1L;

   private int segmentId;
   private String validFromTime;
   private String duration;
   private String message = "Save Segment Success!";

   private SegmentTravelTimeDAO segmentTravelTimeDAO;
   private SegmentDAO segmentDAO;

   @Action(value = "/saveSegment", results = { @Result(type = "json", name = SUCCESS) })
   public String execute() {
      try {
         SegmentTravelTimeBean segmentTravelTimeBean = new SegmentTravelTimeBean();
         segmentTravelTimeBean.setSegment(segmentDAO.getById(segmentId));
         
         Date validDate = DateUtils.string2Date(validFromTime, "dd/mm/yyyy - hh:mm", CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE);
         segmentTravelTimeBean.setValidFrom(validDate);
         
         String[] travelTime = duration.split(":");
         long dtravelTime = DateUtils.getTime(
               Integer.parseInt(travelTime[0]),
               Integer.parseInt(travelTime[1]), 0);
         segmentTravelTimeBean.setTravelTime(dtravelTime);
         segmentTravelTimeDAO.insert(segmentTravelTimeBean);
      } catch (Exception ex) {
         setMessage("Save saveSegment failed!");
      }
      return SUCCESS;
   }

   public String getMessage() {
      return message;
   }

   public void setMessage(String message) {
      this.message = message;
   }

   public int getSegmentId() {
      return segmentId;
   }

   public void setSegmentId(int segmentId) {
      this.segmentId = segmentId;
   }

   public String getValidFromTime() {
      return validFromTime;
   }

   public void setValidFromTime(String validFromTime) {
      this.validFromTime = validFromTime;
   }

   public String getDuration() {
      return duration;
   }

   public void setDuration(String duration) {
      this.duration = duration;
   }

   public void setSegmentTravelTimeDAO(SegmentTravelTimeDAO segmentTravelTimeDAO) {
      this.segmentTravelTimeDAO = segmentTravelTimeDAO;
   }

   public void setSegmentDAO(SegmentDAO segmentDAO) {
      this.segmentDAO = segmentDAO;
   }

}
