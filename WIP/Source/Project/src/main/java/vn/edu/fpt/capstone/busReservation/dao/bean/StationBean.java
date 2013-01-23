/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;


/**
 * @author Yoshimi
 * 
 */
public class StationBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6213565429368774910L;
	private String name;
	private String city;
	private String status;

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the city
	 */
	public String getCity() {
		return city;
	}

	/**
	 * @param city
	 *            the city to set
	 */
	public void setCity(String city) {
		this.city = city;
	}

	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status
	 *            the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
}
