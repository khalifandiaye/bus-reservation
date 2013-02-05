package vn.edu.fpt.capstone.busReservation.action.booking;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import vn.edu.fpt.capstone.busReservation.displayModel.SeatInfo;

import com.opensymphony.xwork2.ActionSupport;

public class BookingInfoAction extends ActionSupport implements SessionAware{
	
	Map<String,Object> session = null;
	private String selectedSeat;
	private String[] seats; 
	private List<SeatInfo> listSeats = new ArrayList<SeatInfo>();
	
	public List<SeatInfo> getListSeats() {
		return listSeats;
	}

	public void setSelectedSeat(String selectedSeat) {
		this.selectedSeat = selectedSeat;
	}

	public String execute(){
		session.put("selectedSeats", selectedSeat);
		seats = selectedSeat.split(";");
		for(int i= 0; i < seats.length; i++){
			listSeats.add(new SeatInfo(seats[i], "2"));
		}
		return SUCCESS;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
		
	}
}
