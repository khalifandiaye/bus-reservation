package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

public class StationInfo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2195287469199563262L;
	private int id;
	private String name;
	
	public StationInfo(int id, String name) {
		super();
		this.setId(id);
		this.setName(name);
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
