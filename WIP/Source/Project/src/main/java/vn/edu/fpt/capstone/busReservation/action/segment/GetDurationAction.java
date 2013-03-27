package vn.edu.fpt.capstone.busReservation.action.segment;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentTravelTimeDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentTravelTimeBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentAddInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentInfo;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

@ParentPackage("jsonPackage")
public class GetDurationAction extends BaseAction {

   private static final long serialVersionUID = 1L;

   private String data;
   private static ObjectMapper mapper = new ObjectMapper();
   private List<SegmentInfo> segmentInfos = new ArrayList<SegmentInfo>();

   private SegmentDAO segmentDAO;
   private SegmentTravelTimeDAO segmentTravelTimeDAO;

   public void setSegmentTravelTimeDAO(SegmentTravelTimeDAO segmentTravelTimeDAO) {
      this.segmentTravelTimeDAO = segmentTravelTimeDAO;
   }

   @Action(value = "getSegmentDur", results = { @Result(type = "json", name = SUCCESS) })
   public String execute() {
      try {
         SegmentAddInfo segmentAddInfo = mapper.readValue(data,
               new TypeReference<SegmentAddInfo>() {
               });
         Date validDate = FormatUtils.deFormatDate(
               segmentAddInfo.getValidDate(), "dd/MM/yyyy - hh:mm",
               CommonConstant.LOCALE_US, CommonConstant.DEFAULT_TIME_ZONE);
         List<SegmentBean> segmentBeans = segmentDAO.getAll();
         for (SegmentBean segmentBean : segmentBeans) {
            long traTime = 0;
            List<SegmentTravelTimeBean> segmentTravelTimeBeans = segmentTravelTimeDAO
                  .getTravelTimebyDate(segmentBean.getId(), validDate);
            if (segmentTravelTimeBeans.size() != 0) {
               traTime = segmentTravelTimeBeans.get(0).getTravelTime();
            }
            
            SegmentInfo segmentInfo = new SegmentInfo();
            Long hours = traTime / (1000 * 60 * 60);
            Long minutes = (traTime % (1000 * 60 * 60)) / (1000 * 60);
            segmentInfo.setDuration((hours < 10 ? ("0" + hours.toString()) : hours)
                        + ":"
                        + (minutes < 10 ? ("0" + minutes.toString()) : minutes));
            segmentInfos.add(segmentInfo);
         }
      } catch (Exception e) {
         System.out.println("failed");
      }
      return SUCCESS;
   }

   public void setData(String data) {
      this.data = data;
   }

   public void setSegmentDAO(SegmentDAO segmentDAO) {
      this.segmentDAO = segmentDAO;
   }

   public List<SegmentInfo> getSegmentInfos() {
      return segmentInfos;
   }

   public void setSegmentInfos(List<SegmentInfo> segmentInfos) {
      this.segmentInfos = segmentInfos;
   }

}