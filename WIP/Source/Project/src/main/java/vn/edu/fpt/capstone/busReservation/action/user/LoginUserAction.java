package vn.edu.fpt.capstone.busReservation.action.user;

import vn.edu.fpt.capstone.busReservation.dao.UserDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;

import com.opensymphony.xwork2.ActionSupport;

public class LoginUserAction extends ActionSupport {
	private String inputUserName;
	private String inputPassword;
	private UserDAO userDAO;
	
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}


	public void setInputUserName(String inputUserName) {
		this.inputUserName = inputUserName;
	}


	public void setInputPassword(String inputPassword) {
		this.inputPassword = inputPassword;
	}
	
	
	public String execute(){
		UserBean userBean = userDAO.checkLogin(inputUserName, inputPassword);
		if(userBean != null){
			
		}
		return SUCCESS;
	}
}
