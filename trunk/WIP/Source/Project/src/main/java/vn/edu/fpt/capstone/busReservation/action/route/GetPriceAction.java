package vn.edu.fpt.capstone.busReservation.action.route;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.TariffDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentAddInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.TariffInfo;

@ParentPackage("jsonPackage")
public class GetPriceAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	private String data;
	private static ObjectMapper mapper = new ObjectMapper();
	private List<TariffInfo> tariffInfos = new ArrayList<TariffInfo>();

	private TariffDAO tariffDAO;

	@Action(value = "getPrice", results = { @Result(type = "json", name = SUCCESS ) })
	public String execute() throws JsonParseException, JsonMappingException,IOException, ParseException {
		SegmentAddInfo segmentAddInfos = mapper.readValue(data, new TypeReference<SegmentAddInfo>() {});
		List<SegmentInfo> segmentInfos = segmentAddInfos.getSegments();
		for (SegmentInfo segmentInfo : segmentInfos) {
			List<TariffBean> resultList = tariffDAO.getPrice(segmentInfo.getId(), segmentAddInfos.getBusType());
			if (!resultList.isEmpty()) {
				TariffBean tariffBean = resultList.get(0);
				TariffInfo tariffInfo = new TariffInfo(tariffBean.getSegment().getId(), 
					tariffBean.getSegment().getStartAt().getCity().getName(),
					tariffBean.getSegment().getEndAt().getCity().getName(),
					tariffBean.getFare());
				tariffInfos.add(tariffInfo);
			}
		}
		return SUCCESS;
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
