package vn.edu.fpt.capstone.busReservation.action.booking;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.mapping.Array;

import vn.edu.fpt.capstone.busReservation.displayModel.SeatInfo;

import com.opensymphony.xwork2.ActionSupport;

public class BookingInfoAction extends ActionSupport{
	
	private String selectedSeat;
	private String[] seats; 
	private List<SeatInfo> listSeats = new ArrayList<SeatInfo>();
	
	public List<SeatInfo> getListSeats() {
		return listSeats;
	}

	public void setListSeats(List<SeatInfo> listSeats) {
		this.listSeats = listSeats;
	}

	public String getSelectedSeat() {
		return selectedSeat;
	}

	public void setSelectedSeat(String selectedSeat) {
		this.selectedSeat = selectedSeat;
	}

	public String execute(){
		seats = selectedSeat.split(";");
		for(int i= 0; i < seats.length; i++){
			listSeats.add(new SeatInfo(seats[i], "2"));
		}
		return SUCCESS;
	}
}
