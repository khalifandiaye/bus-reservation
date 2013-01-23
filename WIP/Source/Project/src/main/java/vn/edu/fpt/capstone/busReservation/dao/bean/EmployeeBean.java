/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

/**
 * @author Yoshimi
 *
 */
public class EmployeeBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3350278777199103062L;
	private String username;
	private String password;
	private String status;
	/**
	 * @return the username
	 */
	public String getUsername() {
		return username;
	}
	/**
	 * @param username the username to set
	 */
	public void setUsername(String username) {
		this.username = username;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

}
