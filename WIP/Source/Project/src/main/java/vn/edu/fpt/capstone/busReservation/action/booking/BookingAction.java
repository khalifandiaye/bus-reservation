/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.booking;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import org.apache.struts2.interceptor.SessionAware;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.SeatPositionDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SearchResultInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.SeatInfo;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

import com.opensymphony.xwork2.ActionChainResult;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author NoName
 *
 */

public class BookingAction extends BaseAction implements SessionAware {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5962554617409673584L;
	
	//=============================input parameter====================
	private String tripData;
	private String outBusStatus;
	private String passengerNo;
	private String outDepartTime;
	private String outArriveTime;
	private String outFare;
	private TripDAO tripDAO;
	private SeatInfo[][] seatMap;
	private String selectedSeat;
	private SeatPositionDAO seatPositionDAO;
	
	
	/**
	 * @return the passengerNo
	 */
	public String getPassengerNo() {
		return passengerNo;
	}

	/**
	 * @param outDepartTime the outDepartTime to set
	 */
	public void setOutDepartTime(String outDepartTime) {
		this.outDepartTime = outDepartTime;
	}

	/**
	 * @param outArriveTime the outArriveTime to set
	 */
	public void setOutArriveTime(String outArriveTime) {
		this.outArriveTime = outArriveTime;
	}

	/**
	 * @param outFare the outFare to set
	 */
	public void setOutFare(String outFare) {
		this.outFare = outFare;
	}

	/**
	 * @param passengerNo the passengerNo to set
	 */
	public void setPassengerNo(String passengerNo) {
		this.passengerNo = passengerNo;
	}

	/**
	 * @param busStatus the busStatus to set
	 */
	public void setOutBusStatus(String outBusStatus) {
		this.outBusStatus = outBusStatus;
	}

	/**
	 * @return the tripData
	 */
	public String getTripData() {
		return tripData;
	}

	public void setSeatPositionDAO(SeatPositionDAO seatPositionDAO) {
		this.seatPositionDAO = seatPositionDAO;
	}

	public String getSelectedSeat() {
		return selectedSeat;
	}

	public SeatInfo[][] getSeatMap() {
		return seatMap;
	}

	Map<String,Object> session = null;	

	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
	}

	@SuppressWarnings("unchecked")
	private List<TripBean> getListTripBean() {
		List<TripBean> listTripBean = null;
		if(!CheckUtils.isNullOrBlank(outBusStatus)){
			int busStatus = Integer.parseInt(outBusStatus);
			listTripBean = tripDAO.getBookingTrips(busStatus, outDepartTime, outArriveTime);
			session.put("listTripBean", listTripBean);	
		}else if(session.containsKey("listTripBean")){
			//redirect from some where
			listTripBean = (List<TripBean>)session.get("listTripBean");
		}
		return listTripBean;
	}
	
	private List<SeatInfo> getSeatsList(List<TripBean> listTripBean){
		List<SeatInfo> seats = new ArrayList<SeatInfo>();		
		List<String> listSoldSeat = seatPositionDAO.getSoldSeats(listTripBean);
		
		for (String string : listSoldSeat) {
			SeatInfo tmp = new SeatInfo(string, "1");
			seats.add(tmp);
		}
		
		return seats;
	}
	
	private SeatInfo[][] buildSeatMap(List<TripBean> listTripBean){
		
		List<SeatInfo> seats = getSeatsList(listTripBean);
		
		String[] bigText = {"A","B","C","D","E"}; 
		
		SeatInfo[][] tmpSeatMap = new SeatInfo[5][11];
		
		for(int i = 0; i < 5; i++){
			if(i != 2){
				for(int j = 0; j < 11;j++ ){
					String seatNum = bigText[i] + Integer.toString(j+1);
					String status = "0";
					for(int k = 0; k < seats.size(); k++){
						if(seats.get(k).getName().equals(seatNum)){
							status = "1";
						}
					}
					tmpSeatMap[i][j] = new SeatInfo(seatNum, status);
				}
			}else{
				//Bonus seat
				String seatNum = bigText[i] + Integer.toString(1);
				String status = "0";
				for(int k = 0; k < seats.size(); k++){
					if(seats.get(k).getName().equals(seatNum)){
						status = "1";
					}
				}
				tmpSeatMap[i][0] = new SeatInfo(seatNum, status);
			}
		}
		return tmpSeatMap;
	}
	
	@SuppressWarnings("unchecked")
	public String execute(){
		List<TripBean> listTripBeans = getListTripBean();
		if(listTripBeans == null){
			return ERROR;
		}
		
		if(request.get("backFrom") != null){
			//remove doubleSeat and build new seletedSeat
			List<String> doubleSeats = (List<String>)request.get("doubleSeat");
			String selSeat = (String)session.get("selectedSeats");
			String[] list = selSeat.split(";");
			
			this.passengerNo = list.length+"";
			
			String nwSelectedSeat = "";
			
			for (String string : list) {
				if(!doubleSeats.contains(string)){
					nwSelectedSeat += string+";";
				}
			}
			
			this.selectedSeat = nwSelectedSeat;
		}
		
		seatMap = buildSeatMap(listTripBeans);
		return SUCCESS;
	}

	@Override
	public void setSession(Map<String, Object> map) {
		this.session = map;
	}
}
