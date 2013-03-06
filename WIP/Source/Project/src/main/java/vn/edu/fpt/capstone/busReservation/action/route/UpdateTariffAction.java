package vn.edu.fpt.capstone.busReservation.action.route;

import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDetailsDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.TariffDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;
import vn.edu.fpt.capstone.busReservation.displayModel.TariffInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.TariffUpdateInfo;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

@ParentPackage("jsonPackage")
public class UpdateTariffAction extends BaseAction {

	/**
    * 
    */
	private static final long serialVersionUID = 1L;

	private String data;
	private String message = "Update Success!";
	private static ObjectMapper mapper = new ObjectMapper();

	private TariffDAO tariffDAO;
	private BusTypeDAO busTypeDAO;
	private SegmentDAO segmentDAO;
	private RouteDAO routeDAO;
	private RouteDetailsDAO routeDetailsDAO;

	public void setRouteDetailsDAO(RouteDetailsDAO routeDetailsDAO) {
		this.routeDetailsDAO = routeDetailsDAO;
	}

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}

	public void setTariffDAO(TariffDAO tariffDAO) {
		this.tariffDAO = tariffDAO;
	}

	@Action(value = "updateTariff", results = { @Result(type = "json", name = SUCCESS, params = {
         "root", "message" }) })
   public String execute() throws JsonParseException, JsonMappingException,
         IOException, ParseException {
      TariffUpdateInfo tariffUpdateInfo = mapper.readValue(data, new TypeReference<TariffUpdateInfo>() { });
      List<TariffInfo> tariffInfos = tariffUpdateInfo.getTariffs();
      Date validDate = FormatUtils.deFormatDate(tariffUpdateInfo.getValidDate(),
            "yyyy/MM/dd - hh:mm", CommonConstant.LOCALE_US,
            CommonConstant.DEFAULT_TIME_ZONE);
      
      BusTypeBean busTypeBean = busTypeDAO.getById(tariffUpdateInfo.getBusTypeId());
      
//      List<Object[]> terminals = routeDAO.getRouteTerminal(tariffUpdateInfo.getRouteId());
//      if (terminals.size() != 0) {
//    	  int returnRouteId = (Integer) terminals.get(0)[1];
//    	  RouteBean returnRoute = routeDAO.getById(returnRouteId);
//    	  List<SegmentBean> segmentBeans = routeDetailsDAO.getAllSegmemtsByRouteId(returnRouteId);
//    	  for (int i = 0; i < segmentBeans.size(); i++) {
//    		  TariffBean tariffBean = new TariffBean();
//    	         tariffBean.setFare(tariffInfos.get(i).getFare());
//    	         tariffBean.setValidFrom(validDate);
//    	         tariffBean.setBusType(busTypeBean);
//    	         tariffBean.setSegment(segmentDAO.getById(tariffInfo.getSegmentId()));
//    	         tariffDAO.insert(tariffBean);
//		}
//      }

      for (TariffInfo tariffInfo : tariffInfos) {
         TariffBean tariffBean = new TariffBean();
         tariffBean.setFare(tariffInfo.getFare());
         tariffBean.setValidFrom(validDate);
         tariffBean.setBusType(busTypeBean);
         tariffBean.setSegment(segmentDAO.getById(tariffInfo.getSegmentId()));
         tariffDAO.insert(tariffBean);
      }
      
      return SUCCESS;
   }

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getMessage() {
		return message;
	}

	public void setBusTypeDAO(BusTypeDAO busTypeDAO) {
		this.busTypeDAO = busTypeDAO;
	}

	public void setSegmentDAO(SegmentDAO segmentDAO) {
		this.segmentDAO = segmentDAO;
	}

}
