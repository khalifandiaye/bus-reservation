package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

public class BusInfo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2195287469199563262L;
	private int id;
	private String plateNumber;
	private String delete;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPlateNumber() {
		return plateNumber;
	}

	public void setPlateNumber(String plateNumber) {
		this.plateNumber = plateNumber;
	}

   public String getDelete() {
      return delete;
   }

   public void setDelete(String delete) {
      this.delete = delete;
   }
	
}
