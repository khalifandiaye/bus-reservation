/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

/**
 * @author Yoshimi
 *
 */
public class SeatPositionBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6583091312608772197L;
	private String name;
	private BusTypeBean busType;
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the busType
	 */
	public BusTypeBean getBusType() {
		return busType;
	}
	/**
	 * @param busType the busType to set
	 */
	public void setBusType(BusTypeBean busType) {
		this.busType = busType;
	}
}
