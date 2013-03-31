package vn.edu.fpt.capstone.busReservation.action.route;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.BusTypeDAO;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.SegmentDAO;
import vn.edu.fpt.capstone.busReservation.dao.TariffDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;
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

	public void setRouteDAO(RouteDAO routeDAO) {
		this.routeDAO = routeDAO;
	}

	public void setTariffDAO(TariffDAO tariffDAO) {
		this.tariffDAO = tariffDAO;
	}

	@Action(value = "updateTariff", results = { @Result(type = "json", name = SUCCESS, params = {
			"root", "message" }) })
	public String execute() {
		try {
			TariffUpdateInfo tariffUpdateInfo = mapper.readValue(data,
					new TypeReference<TariffUpdateInfo>() {
					});
			List<TariffInfo> tariffInfos = tariffUpdateInfo.getTariffs();
			
			int routeId = tariffUpdateInfo.getRouteId();
			updateTarrif(tariffInfos, tariffUpdateInfo, routeId, false);
			//create tariff for reverse route
			Collections.reverse(tariffInfos);
			List<Integer> rt = routeDAO.getRouteTerminal(routeId);
			int revertRouteId = 0;
			if (rt.size() != 0) {
				if (routeId == rt.get(0)) {
					revertRouteId = rt.get(1);
				} else {
					revertRouteId = rt.get(0);
				}
				updateTarrif(tariffInfos, tariffUpdateInfo, revertRouteId, true);
			}
		} catch (Exception e) {
		}
		return SUCCESS;
	}

	private void updateTarrif(List<TariffInfo> tariffInfos,
			TariffUpdateInfo tariffUpdateInfo, int routeId,
			boolean isRevertRoute) throws ParseException {
		Date validDate = FormatUtils.deFormatDate(
				tariffUpdateInfo.getValidDate(), "dd/MM/yyyy",
				CommonConstant.LOCALE_US, CommonConstant.DEFAULT_TIME_ZONE);
		BusTypeBean busTypeBean = busTypeDAO.getById(tariffUpdateInfo.getBusTypeId());
		for (TariffInfo tariffInfo : tariffInfos) {
			SegmentBean segmentBean = segmentDAO.getById(tariffInfo.getSegmentId());
			SegmentBean segmentBeanRevert = segmentDAO.getDuplicatedSegment(
					segmentBean.getEndAt().getId(),
					segmentBean.getStartAt().getId()).get(0);
			
			// get exist tariff
			List<TariffBean> tariffBeans = tariffDAO.getExistTariff(
					segmentBean.getId(), busTypeBean.getId(), validDate);

			List<TariffBean> tariffBeansRevert = tariffDAO.getExistTariff(
					segmentBeanRevert.getId(), busTypeBean.getId(), validDate);

			if (tariffBeans.size() != 0 && tariffBeansRevert.size() != 0) {
				TariffBean tariffBean = tariffBeans.get(0);
				TariffBean revertTariffBean = tariffBeansRevert.get(0);
				// update current segment
				tariffBean.setFare(tariffInfo.getFare());
				// update revert segment
				revertTariffBean.setFare(tariffInfo.getFare());
				tariffDAO.update(tariffBean);
				tariffDAO.update(revertTariffBean);
			} else {
				List<SegmentBean> segments = new ArrayList<SegmentBean>();
				if (!isRevertRoute) {
					segments = segmentDAO.getSegmentInRouteTerminal(routeId,
							segmentBean.getStartAt().getId(), segmentBean
									.getEndAt().getId());
				} else {
					segments = segmentDAO.getSegmentInRouteTerminal(routeId,
							segmentBean.getEndAt().getId(), segmentBean
									.getStartAt().getId());
				}
				if (segments.size() != 0) {
					TariffBean tariffBean = new TariffBean();
					tariffBean.setFare(tariffInfo.getFare());
					tariffBean.setValidFrom(validDate);
					tariffBean.setBusType(busTypeBean);
					tariffBean.setSegment(segments.get(0));
					tariffDAO.insert(tariffBean);
				}
			}
		}
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
