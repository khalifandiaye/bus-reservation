/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;
import java.io.Serializable;
/**
 * @author Monkey
 *
 */
public class CityInfo implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 61L;
	private int id;
	private String name;
	
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
