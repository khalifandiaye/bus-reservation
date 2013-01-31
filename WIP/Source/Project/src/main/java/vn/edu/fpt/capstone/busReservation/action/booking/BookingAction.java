/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.booking;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SeatInfo;

import com.opensymphony.xwork2.ActionChainResult;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author NoName
 *
 */

public class BookingAction extends ActionSupport implements SessionAware {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5962554617409673584L;
	
	private TripDAO tripDAO = null; 
	private List<TripBean> listTripBean = new ArrayList<TripBean>();
	private List<SeatInfo> seatMap = new ArrayList<SeatInfo>();
	Map<String,Object> session = null;
	

	public List<SeatInfo> getSeatMap() {
		return seatMap;
	}

	public void setSeatMap(List<SeatInfo> seatMap) {
		this.seatMap = seatMap;
	}

	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
	}

	public void getListTripBean(){
		TripBean tripTmp = new TripBean();
		tripTmp = tripDAO.getById(1);
		listTripBean.add(tripTmp);
	}
	
	public List<SeatInfo> getSeatsList(){
		getListTripBean();
		List<SeatInfo> seats = new ArrayList<SeatInfo>();		
		for(int k = 0; k < listTripBean.size(); k++){
			int reservationForTrip = listTripBean.get(k).getReservations().size();
			for(int i = 0; i < reservationForTrip; i++){
				int positionSize = listTripBean.get(k).getReservations().get(i).getSeatPositions().size();
				for(int j = 0; j < positionSize; j++){
					SeatInfo tmp = new SeatInfo(listTripBean.get(k).getReservations().get(i).getSeatPositions().get(j).getName(), "1");
					if( !seats.contains(tmp)){
						seats.add(tmp);
					}
				}
			}
		}
		return seats;
	}
	
	public String buildSeatMap(){
		
		List<SeatInfo> seats = getSeatsList();
		
		String[] bigText = {"A","B","C","D","E","F","G","H","I","J","K"}; 
		
		for(int i = 0; i < 11; i++){
			if(i < 10){
				for(int j = 0; j < 4;j++ ){
					String seatNum = bigText[i] + Integer.toString(j+1);
					String status = "0";
					for(int k = 0; k < seats.size(); k++){
						if(seats.get(k).getName().equals(seatNum)){
							status = "1";
						}
					}
					seatMap.add(new SeatInfo(seatNum, status));
				}
			}else{
				//Bonus seat
				for(int j = 0; j < 5;j++ ){
					String seatNum = bigText[i] + Integer.toString(j+1);
					String status = "0";
					for(int k = 0; k < seats.size(); k++){
						if(seats.get(k).getName().equals(seatNum)){
							status = "1";
						}
					}
					seatMap.add(new SeatInfo(seatNum, status));
				}
			}
		}
		return SUCCESS;
	}
	
	public String execute(){
		buildSeatMap();
		session.put("listTripBean", listTripBean);
		return SUCCESS;
	}

	@Override
	public void setSession(Map<String, Object> map) {
		this.session = map;
	}
}
