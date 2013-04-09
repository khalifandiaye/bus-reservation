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
import vn.edu.fpt.capstone.busReservation.dao.TariffDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentAddInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.TariffInfo;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

@ParentPackage("jsonPackage")
public class GetPriceAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private String data;
	private static ObjectMapper mapper = new ObjectMapper();
	private List<TariffInfo> tariffInfos = new ArrayList<TariffInfo>();

	private TariffDAO tariffDAO;
	private SegmentDAO segmentDAO;


	@Action(value = "getPrice", results = { @Result(type = "json", name = SUCCESS) })
	public String execute() {
		try {
			SegmentAddInfo segmentAddInfo = mapper.readValue(data,
					new TypeReference<SegmentAddInfo>() {
					});
			List<SegmentBean> segmentBeans = segmentDAO.getAll();

			Date validDate = FormatUtils.deFormatDate(
					segmentAddInfo.getValidDate(), "dd/MM/yyyy",
					CommonConstant.LOCALE_US, CommonConstant.DEFAULT_TIME_ZONE);
			for (SegmentBean segmentBean : segmentBeans) {
				TariffInfo tariffInfo = new TariffInfo();
				tariffInfo.setId(segmentBean.getId());
				List<TariffBean> resultList = tariffDAO.getPrice(
						segmentBean.getId(), segmentAddInfo.getBusType(),
						validDate);
				if (!resultList.isEmpty()) {
					TariffBean tariffBean = resultList.get(0);					
					tariffInfo.setFare(tariffBean.getFare());
				} else {
					tariffInfo.setFare(0.0);
				}
				tariffInfos.add(tariffInfo);
			}
		} catch (Exception e) {
		}
		return SUCCESS;
	}

	public void setSegmentDAO(SegmentDAO segmentDAO) {
		this.segmentDAO = segmentDAO;
	}
	public void setData(String data) {
		this.data = data;
	}

	public void setTariffDAO(TariffDAO tariffDAO) {
		this.tariffDAO = tariffDAO;
	}

	public List<TariffInfo> getTariffInfos() {
		return tariffInfos;
	}

	public void setTariffInfos(List<TariffInfo> tariffInfos) {
		this.tariffInfos = tariffInfos;
	}

}