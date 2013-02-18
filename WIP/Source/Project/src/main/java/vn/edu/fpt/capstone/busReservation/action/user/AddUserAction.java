/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.user;

import vn.edu.fpt.capstone.busReservation.dao.UserDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RoleBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author NoName
 *
 */
public class AddUserAction extends ActionSupport {
	private String inputUserName;
	private String inputFirstName;
	private String inputLastName;
	private String inputPassword;
	private String inputEmail;
	private String inputMobile;
	private UserDAO userDAO;
	
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}


	public void setInputUserName(String inputUserName) {
		this.inputUserName = inputUserName;
	}


	public void setInputFirstName(String inputFirstName) {
		this.inputFirstName = inputFirstName;
	}


	public void setInputLastName(String inputLastName) {
		this.inputLastName = inputLastName;
	}


	public void setInputPassword(String inputPassword) {
		this.inputPassword = inputPassword;
	}


	public void setInputEmail(String inputEmail) {
		this.inputEmail = inputEmail;
	}


	public void setInputMobile(String inputMobile) {
		this.inputMobile = inputMobile;
	}


	public String execute(){
		UserBean userBean = new UserBean();
		userBean.setUsername(inputUserName);
		userBean.setPassword(inputPassword);
		userBean.setFirstName(inputFirstName);
		userBean.setLastName(inputLastName);
		userBean.setEmail(inputEmail);
		userBean.setMobileNumber(inputMobile);
		userBean.setStatus("active");
		
		RoleBean roleBean = new RoleBean();
		roleBean.setId(1);
		
		userBean.setRole(roleBean);
		userDAO.insert(userBean);
		
		return SUCCESS;
	}
}
