package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

public class TariffInfo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2195287469199563262L;
	private int id;
	private int segmentId;
	private String startAt;
	private String endAt;
	private Double fare;
	
	public int getSegmentId() {
		return segmentId;
	}
	
	public void setSegmentId(int segmentId) {
		this.segmentId = segmentId;
	}

	public Double getFare() {
		return fare;
	}

	public void setFare(Double fare) {
		this.fare = fare;
	}

	public String getStartAt() {
		return startAt;
	}

	public void setStartAt(String startAt) {
		this.startAt = startAt;
	}

	public String getEndAt() {
		return endAt;
	}

	public void setEndAt(String endAt) {
		this.endAt = endAt;
	}

   public int getId() {
      return id;
   }

   public void setId(int id) {
      this.id = id;
   }
	
}
