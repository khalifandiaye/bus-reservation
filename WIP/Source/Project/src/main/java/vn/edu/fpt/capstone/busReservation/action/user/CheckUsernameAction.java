/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.ws.Action;

import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Actions;

import vn.edu.fpt.capstone.busReservation.dao.UserDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author NoName
 *
 */
@ParentPackage("jsonPackage")
public class CheckUsernameAction extends ActionSupport {
	
	private String inputUserName;
	private String inputEmail;
	private Map<String, Boolean> checkUsernameResult;
	private UserDAO userDAO;
	
	public Map<String, Boolean> getCheckUsernameResult() {
		return checkUsernameResult;
	}

	public void setInputUserName(String inputUserName) {
		this.inputUserName = inputUserName;
	}
	
	public void setInputEmail(String inputEmail) {
		this.inputEmail = inputEmail;
	}
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	@org.apache.struts2.convention.annotation.Action(results={
		@Result(type="json")
	})
	public String execute(){
		boolean resultUsername = false;
		boolean resultEmail = false;
		checkUsernameResult = new HashMap<String, Boolean>();
	
		if(inputUserName.length()>0){
			resultUsername = userDAO.isExist(inputUserName);
		}
		if(inputEmail.length()>0){
			resultEmail = userDAO.isEmailExist(inputEmail);
		}
		
		checkUsernameResult.put("usernameCheck", resultUsername);
		checkUsernameResult.put("emailCheck", resultEmail);
		
		return SUCCESS;
	}
}
