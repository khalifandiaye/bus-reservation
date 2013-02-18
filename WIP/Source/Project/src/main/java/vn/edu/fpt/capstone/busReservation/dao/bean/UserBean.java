/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.List;

/**
 * @author Yoshimi
 *
 */
public class UserBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1371685596827271874L;
	private String username;
	private String password;
	private RoleBean role;
	private String firstName;
	private String lastName;
	private String phoneNumber;
	private String mobileNumber;
	private String email;
	private String civilId;
	private String status;
	private List<ReservationBean> reservations;
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
	 * @return the role
	 */
	public RoleBean getRole() {
	    return role;
	}
	/**
	 * @param role the role to set
	 */
	public void setRole(RoleBean role) {
	    this.role = role;
	}
	/**
	 * @return the firstName
	 */
	public String getFirstName() {
	    return firstName;
	}
	/**
	 * @param firstName the firstName to set
	 */
	public void setFirstName(String firstName) {
	    this.firstName = firstName;
	}
	/**
	 * @return the lastName
	 */
	public String getLastName() {
	    return lastName;
	}
	/**
	 * @param lastName the lastName to set
	 */
	public void setLastName(String lastName) {
	    this.lastName = lastName;
	}
	/**
	 * @return the phoneNumber
	 */
	public String getPhoneNumber() {
	    return phoneNumber;
	}
	/**
	 * @param phoneNumber the phoneNumber to set
	 */
	public void setPhoneNumber(String phoneNumber) {
	    this.phoneNumber = phoneNumber;
	}
	/**
	 * @return the mobileNumber
	 */
	public String getMobileNumber() {
	    return mobileNumber;
	}
	/**
	 * @param mobileNumber the mobileNumber to set
	 */
	public void setMobileNumber(String mobileNumber) {
	    this.mobileNumber = mobileNumber;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
	    return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
	    this.email = email;
	}
	/**
	 * @return the civilId
	 */
	public String getCivilId() {
	    return civilId;
	}
	/**
	 * @param civilId the civilId to set
	 */
	public void setCivilId(String civilId) {
	    this.civilId = civilId;
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
    /**
     * @return the reservations
     */
    public List<ReservationBean> getReservations() {
        return reservations;
    }
    /**
     * @param reservations the reservations to set
     */
    public void setReservations(List<ReservationBean> reservations) {
        this.reservations = reservations;
    }
}
