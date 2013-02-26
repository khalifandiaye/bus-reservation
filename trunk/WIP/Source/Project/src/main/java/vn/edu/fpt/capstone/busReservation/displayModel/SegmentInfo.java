package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

public class SegmentInfo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2195287469199563262L;
	private int startAt;
	private int endAt;
	private String duration;
	private Double price;
	private int stationStartAt;
	private int stationEndAt;

	public int getStartAt() {
		return startAt;
	}

	public void setStartAt(int startAt) {
		this.startAt = startAt;
	}

	public int getEndAt() {
		return endAt;
	}

	public void setEndAt(int endAt) {
		this.endAt = endAt;
	}

	public String getDuration() {
		return duration;
	}

	public void setDuration(String duration) {
		this.duration = duration;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public int getStationStartAt() {
		return stationStartAt;
	}

	public void setStationStartAt(int stationStartAt) {
		this.stationStartAt = stationStartAt;
	}

	public int getStationEndAt() {
		return stationEndAt;
	}

	public void setStationEndAt(int stationEndAt) {
		this.stationEndAt = stationEndAt;
	}

}
