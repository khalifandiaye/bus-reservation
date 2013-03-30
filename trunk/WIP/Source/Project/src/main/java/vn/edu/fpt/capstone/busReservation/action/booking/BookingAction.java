/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.booking;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.SeatPositionDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SeatInfo;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;

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
	private List<SeatInfo[][]> seatMapOut;
	private List<SeatInfo[][]> seatMapReturn;
	private SeatPositionDAO seatPositionDAO;
	private String message;
	private String out_journey;
	private String rtn_journey;
	private String selectedOutSeat;
	private String selectedReturnSeat;
	private String rtnDepartTime;
	private String rtnArriveTime;
	private String rtnBusStatus;
	
	
	/**
	 * @param rtnBusStatus the rtnBusStatus to set
	 */
	public void setRtnBusStatus(String rtnBusStatus) {
		this.rtnBusStatus = rtnBusStatus;
	}

	/**
	 * @param rtnDepartTime the rtnDepartTime to set
	 */
	public void setRtnDepartTime(String rtnDepartTime) {
		this.rtnDepartTime = rtnDepartTime;
	}

	/**
	 * @param rtnArriveTime the rtnArriveTime to set
	 */
	public void setRtnArriveTime(String rtnArriveTime) {
		this.rtnArriveTime = rtnArriveTime;
	}

	/**
	 * @return the selectedOutSeat
	 */
	public String getSelectedOutSeat() {
		return selectedOutSeat;
	}

	/**
	 * @return the selectedReturnSeat
	 */
	public String getSelectedReturnSeat() {
		return selectedReturnSeat;
	}

	/**
	 * @return the seatMapOut
	 */
	public List<SeatInfo[][]> getSeatMapOut() {
		return seatMapOut;
	}

	/**
	 * @return the seatMapReturn
	 */
	public List<SeatInfo[][]> getSeatMapReturn() {
		return seatMapReturn;
	}

	/**
	 * @param out_journey the out_journey to set
	 */
	public void setOut_journey(String out_journey) {
		this.out_journey = out_journey;
	}

	/**
	 * @param rtn_journey the rtn_journey to set
	 */
	public void setRtn_journey(String rtn_journey) {
		this.rtn_journey = rtn_journey;
	}

	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}

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

	Map<String,Object> session = null;	

	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
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
	
	private List<SeatInfo[][]> buildSeatMap(List<TripBean> listTripBean){
		if(listTripBean == null){
			return null;
		}
		List<SeatInfo> seats = getSeatsList(listTripBean);
		int tmpBustType = listTripBean.get(0).getBusStatus().getBus().getBusType().getId();
		String[] bigText = {"A","B","C","D","E"}; 
		
		List<SeatInfo[][]> listSeatMap = new ArrayList<SeatInfo[][]>();
		
		if(tmpBustType == 1){
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
			listSeatMap.add(tmpSeatMap);
		}else{
			SeatInfo[][] tmpSeatMapUp = new SeatInfo[3][7];
			SeatInfo[][] tmpSeatMapDown = new SeatInfo[3][7];
			for(int i = 0; i < 3; i++){
				for(int j = 0; j < 14; j++){
					String seatNum = bigText[i] + Integer.toString(j+1);
					String status = "0";
					for(int k = 0; k < seats.size(); k++){
						if(seats.get(k).getName().equals(seatNum)){
							status = "1";
						}
					}
					if(j < 7){
						tmpSeatMapDown[i][j] = new SeatInfo(seatNum, status);
					}else{
						tmpSeatMapUp[i][j-7] = new SeatInfo(seatNum, status);
					}
				}
			}
			listSeatMap.add(tmpSeatMapDown);
			listSeatMap.add(tmpSeatMapUp);
		}
		return listSeatMap;
	}
	
	@SuppressWarnings("unchecked")
	public String execute(){
		
		List<TripBean> listOutTripBean = null;
		List<TripBean> listReturnTripBean = null;
		
		if(!CheckUtils.isNullOrBlank(outBusStatus) || !CheckUtils.isNullOrBlank(rtnBusStatus)){
			if(session.containsKey("listOutTripBean")){
				session.remove("listOutTripBean");
			}
			if(session.containsKey("listReturnTripBean")){
				session.remove("listReturnTripBean");
			}
			if(!CheckUtils.isNullOrBlank(out_journey) && out_journey.equalsIgnoreCase("on") && CheckUtils.isNullOrBlank(rtn_journey)){
				int busStatus = Integer.parseInt(outBusStatus);
				listOutTripBean = tripDAO.getBookingTrips(busStatus, outDepartTime, outArriveTime);
				session.put("listOutTripBean", listOutTripBean);
			}else if(!CheckUtils.isNullOrBlank(rtn_journey) && rtn_journey.equalsIgnoreCase("on") && CheckUtils.isNullOrBlank(out_journey)){
				int busStatus = Integer.parseInt(rtnBusStatus);
				listOutTripBean = tripDAO.getBookingTrips(busStatus, rtnDepartTime, rtnArriveTime);
				session.put("listOutTripBean", listOutTripBean);
			}else if(!CheckUtils.isNullOrBlank(rtn_journey) && rtn_journey.equalsIgnoreCase("on") && !CheckUtils.isNullOrBlank(out_journey) && out_journey.equalsIgnoreCase("on")){
				int busStatusOut = Integer.parseInt(outBusStatus);
				int busStatusRtn = Integer.parseInt(rtnBusStatus);
				listOutTripBean = tripDAO.getBookingTrips(busStatusOut, outDepartTime, outArriveTime);
				session.put("listOutTripBean", listOutTripBean);
				listReturnTripBean = tripDAO.getBookingTrips(busStatusRtn, rtnDepartTime, rtnArriveTime);
				session.put("listReturnTripBean", listReturnTripBean);
			}
			session.put("passengerNo", passengerNo);
		}else if(session.containsKey("listOutTripBean") || session.containsKey("listReturnTripBean")){
			//redirect from some where
			if(session.containsKey("redirectFrom")){
				if("bookingPay".equals((String)session.get("redirectFrom"))){
					if(session.containsKey("listOutTripBean")){ 
						listOutTripBean = (List<TripBean>)session.get("listOutTripBean");
					}
					if(session.containsKey("listReturnTripBean")){
						listReturnTripBean = (List<TripBean>)session.get("listReturnTripBean");
					}
					this.passengerNo = (String)session.get("passengerNo");
					session.remove("redirectFrom");
				}
			}else{
				session.remove("listOutTripBean");
				session.remove("listReturnTripBean");
				
				session.remove("message");
				session.remove("seatsOutDouble");
				session.remove("seatsReturnDouble");
				return ERROR;
			}
		}		
		
		
		if(session != null
                && (session.containsKey("seatsOutDouble") || session.containsKey("seatsReturnDouble"))){
			
			String selOutSeat = (String)session.get("selectedOutSeat");
			String selReturnSeat = (String)session.get("selectedReturnSeat");
			String[] listOutSeats = selOutSeat.split(";");
			String[] listReturnSeats = selReturnSeat.split(";");
			
			List<String> listOutDouble = (List<String>)session.get("seatsOutDouble");
			List<String> listReturnDouble = (List<String>)session.get("seatsReturnDouble");
			
			String nwOutSeat = "";
			String nwReturnSeat = "";
			if(listOutDouble != null){
				for (String string : listOutSeats) {
					if(!listOutDouble.contains(string)){ 
						nwOutSeat += string+";";
					}
				}
			}
			if(listReturnDouble != null){
				for (String string : listReturnSeats) {
					if(!listReturnDouble.contains(string)){ 
						nwReturnSeat += string+";";
					}
				}
			}
			this.selectedOutSeat = nwOutSeat;
			this.selectedReturnSeat = nwReturnSeat;
			
			this.message = (String)session.get("message");
			
			session.remove("message");
			session.remove("seatsOutDouble");
			session.remove("seatsReturnDouble");
		}
		if(listOutTripBean != null){
			seatMapOut = buildSeatMap(listOutTripBean);
		}
		if(listReturnTripBean != null){
			seatMapReturn = buildSeatMap(listReturnTripBean);
		}
		return SUCCESS;
	}

	@Override
	public void setSession(Map<String, Object> map) {
		this.session = map;
	}
}
