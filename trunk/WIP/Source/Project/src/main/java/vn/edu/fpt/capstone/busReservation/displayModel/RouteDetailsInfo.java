package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

public class RouteDetailsInfo implements Serializable {

	private static final long serialVersionUID = -7740272488683962205L;
	private int id;
	private String routeName;
	private String travelTime;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRouteName() {
		return routeName;
	}
	public void setRouteName(String routeName) {
		this.routeName = routeName;
	}
	public String getTravelTime() {
		return travelTime;
	}
	public void setTravelTime(String travelTime) {
		this.travelTime = travelTime;
	}
}
