/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.user;

import java.util.ArrayList;
import java.util.List;

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
@ParentPackage("json-default")
public class CheckUsernameAction extends ActionSupport {
	
	private String inputUserName;
	private String inputEmail;
	private List<Boolean> checkUsernameResult;
	private UserDAO userDAO;
	private String inputUserNameStat;
	private String inputEmailStat;
	
	public void setInputUserName(String inputUserName) {
		this.inputUserName = inputUserName;
	}

	public void setInputUserNameStat(String inputUserNameStat) {
		this.inputUserNameStat = inputUserNameStat;
	}
	
	public List<Boolean> getCheckUsernameResult() {
		return checkUsernameResult;
	}
	
	public void setInputEmail(String inputEmail) {
		this.inputEmail = inputEmail;
	}

	public void setInputEmailStat(String inputEmailStat) {
		this.inputEmailStat = inputEmailStat;
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	@org.apache.struts2.convention.annotation.Action(results={
		@Result(type="json",params={
			"includeProperties",
			"checkUsernameResult"
		})
	})
	public String execute(){
		boolean resultUsername = false;
		boolean resultEmail = false;
		checkUsernameResult = new ArrayList<Boolean>();
	
		if(inputUserNameStat.equals("1")){
			resultUsername = userDAO.isExist(inputUserName);
		}
		if(inputEmailStat.equals("1")){
			resultEmail = userDAO.isEmailExist(inputEmail);
		}
		
		checkUsernameResult.add(resultUsername);
		checkUsernameResult.add(resultEmail);
		
		return SUCCESS;
	}
}
