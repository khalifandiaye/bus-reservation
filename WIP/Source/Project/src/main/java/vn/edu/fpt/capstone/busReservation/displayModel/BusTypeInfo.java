package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

public class BusTypeInfo implements Serializable {

   /**
    * 
    */
   private static final long serialVersionUID = 1L;
   
   private int id;
	private String type;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

   public String getType() {
      return type;
   }

   public void setType(String type) {
      this.type = type;
   }

}
