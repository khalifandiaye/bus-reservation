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
	
	private TripDAO tripDAO;
	private SeatInfo[][] seatMap;
	
	public SeatInfo[][] getSeatMap() {
		return seatMap;
	}

	Map<String,Object> session = null;	

	public void setTripDAO(TripDAO tripDAO) {
		this.tripDAO = tripDAO;
	}

	private List<TripBean> getListTripBean(){
		TripBean tripTmp = new TripBean();
		tripTmp = tripDAO.getById(1);
		List<TripBean> listTripBean = new ArrayList<TripBean>();
		listTripBean.add(tripTmp);
		session.put("listTripBean", listTripBean);
		return listTripBean;
	}
	
	private List<SeatInfo> getSeatsList(List<TripBean> listTripBean){
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
	
	private SeatInfo[][] buildSeatMap(List<TripBean> listTripBean){
		
		List<SeatInfo> seats = getSeatsList(listTripBean);
		
		String[] bigText = {"A","B","C","D","E","F","G","H","I","J","K"}; 
		
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
	
	public String execute(){
		List<TripBean> listTripBeans = null;
		listTripBeans = getListTripBean();
		seatMap = buildSeatMap(listTripBeans);
		return SUCCESS;
	}

	@Override
	public void setSession(Map<String, Object> map) {
		this.session = map;
	}
}
