/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.user;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.UserDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

/**
 * @author Yoshimi
 *
 */
@ParentPackage("jsonPackage")
public class LoginAction extends BaseAction {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

    // ===========================DAO Object===========================
	private UserDAO userDAO;

    public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
		
    // ==========================Action Input==========================
	private String username;
	private String password;

    public void setUsername(String username) {
		this.username = username;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	// ==========================Action Output=========================
	private boolean success;
	private String name;
	private String errorMessage;

	public boolean isSuccess() {
		return success;
	}

	public String getName() {
		return name;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	@Action(value = "/login", results = { @Result(type = "json", name = SUCCESS) })
	public String execute(){
		success = false;
		String[] params = null;
		UserBean userBean = null;
		User user = null;
		if (CheckUtils.isNullOrBlank(username)) {
			params = new String[1];
			params[0] = "username";
			errorMessage = getText("msgerrcm001", params);
		} else if (CheckUtils.isNullOrBlank(password)) {
			params = new String[1];
			params[0] = "password";
			errorMessage = getText("msgerrcm001", params);
		} else {
			userBean = userDAO.checkLogin(username, password);
			if (userBean != null) {
			user = new User();
			user.setUserId(Integer.toString(userBean.getId()));
			user.setUsername(userBean.getUsername());
			user.setRoleId(Integer.toString(userBean.getRole().getId()));
			user.setFirstName(userBean.getFirstName());
			user.setLastName(userBean.getLastName());
			user.setEmail(userBean.getEmail());
			user.setMobilePhone(userBean.getMobileNumber());
			session.put(CommonConstant.SESSION_KEY_USER, user);
			name = user.getLastName() + " " + user.getFirstName();
			success = true;
			} else {
				params = new String[1];
				params[0] = "password";
				errorMessage = getText("msgerrau001", params);
			}
		}
		return SUCCESS;
	}
}