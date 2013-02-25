/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

/**
 * @author Yoshimi
 * 
 */
public class User implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 8105614715760282101L;
    private String userId;
    private String username;
    private String roleId;
    private String firstName;
    private String lastName;
    private String mobilePhone;
    

	/**
	 * 
	 */
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param userId
	 * @param username
	 * @param roleId
	 * @param firstName
	 * @param lastName
	 * @param mobilePhone
	 * @param email
	 */
	public User(String userId, String username, String roleId,
			String firstName, String lastName, String mobilePhone, String email) {
		super();
		this.userId = userId;
		this.username = username;
		this.roleId = roleId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.mobilePhone = mobilePhone;
		this.email = email;
	}

	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}

	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	 * @return the mobilePhone
	 */
	public String getMobilePhone() {
		return mobilePhone;
	}

	/**
	 * @param mobilePhone the mobilePhone to set
	 */
	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
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

	private String email;

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @param username
     *            the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @return the roleId
     */
    public String getRoleId() {
        return roleId;
    }

    /**
     * @param roleId
     *            the roleId to set
     */
    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    /**
     * @return the firstName
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * @param firstName
     *            the firstName to set
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
     * @param lastName
     *            the lastName to set
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

}
