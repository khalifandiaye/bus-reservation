/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.admin;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.hibernate.HibernateException;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.RoleDAO;
import vn.edu.fpt.capstone.busReservation.dao.UserDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.MailTemplateBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RoleBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.UserLogic;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.CryptUtils;
import vn.edu.fpt.capstone.busReservation.util.MailUtils;
import vn.edu.fpt.capstone.busReservation.util.MailUtils.MailPasswordAuthenticator;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author NoName
 *
 */
@ParentPackage("jsonPackage")
public class AdminAction extends BaseAction{
	private static final long serialVersionUID = 1L;

    // ===========================DAO Object===========================
    private UserDAO userDAO;
    private RoleDAO roleDAO;

    /**
	 * @param roleDAO the roleDAO to set
	 */
	public void setRoleDAO(RoleDAO roleDAO) {
		this.roleDAO = roleDAO;
	}



	public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }
    
    private String inputUsername;
    private String inputPassword;
    private String inputLastname;
    private String inputFirstname;
    private String inputEmail;
    private String inputMobilephone;
    private String optionsRole;
    private boolean checkboxActive;
    private boolean resultJSON;
    private String errorMessage;
    private UserLogic ul;
    
	/**
	 * @param ul the ul to set
	 */
	public void setUl(UserLogic ul) {
		this.ul = ul;
	}



	/**
	 * @return the inputLastname
	 */
	public String getInputLastname() {
		return inputLastname;
	}



	/**
	 * @return the inputFirstname
	 */
	public String getInputFirstname() {
		return inputFirstname;
	}



	/**
	 * @return the inputEmail
	 */
	public String getInputEmail() {
		return inputEmail;
	}



	/**
	 * @return the inputMobilephone
	 */
	public String getInputMobilephone() {
		return inputMobilephone;
	}



	/**
	 * @return the optionsRole
	 */
	public String getOptionsRole() {
		return optionsRole;
	}



	/**
	 * @return the checkboxActive
	 */
	public boolean isCheckboxActive() {
		return checkboxActive;
	}



	/**
	 * @return the errorMessage
	 */
	public String getErrorMessage() {
		return errorMessage;
	}
	


	/**
	 * @return the resultJSON
	 */
	public boolean isResultJSON() {
		return resultJSON;
	}



	/**
	 * @param inputUsername the inputUsername to set
	 */
	public void setInputUsername(String inputUsername) {
		this.inputUsername = inputUsername;
	}



	/**
	 * @param inputPassword the inputPassword to set
	 */
	public void setInputPassword(String inputPassword) {
		this.inputPassword = inputPassword;
	}



	/**
	 * @param inputLastname the inputLastname to set
	 */
	public void setInputLastname(String inputLastname) {
		this.inputLastname = inputLastname;
	}



	/**
	 * @param inputFirstname the inputFirstname to set
	 */
	public void setInputFirstname(String inputFirstname) {
		this.inputFirstname = inputFirstname;
	}



	/**
	 * @param inputEmail the inputEmail to set
	 */
	public void setInputEmail(String inputEmail) {
		this.inputEmail = inputEmail;
	}



	/**
	 * @param inputMobilephone the inputMobilephone to set
	 */
	public void setInputMobilephone(String inputMobilephone) {
		this.inputMobilephone = inputMobilephone;
	}



	/**
	 * @param optionsRole the optionsRole to set
	 */
	public void setOptionsRole(String optionsRole) {
		this.optionsRole = optionsRole;
	}



	/**
	 * @param checkboxActive the checkboxActive to set
	 */
	public void setCheckboxActive(boolean checkboxActive) {
		this.checkboxActive = checkboxActive;
	}


	@Action(value = "/addUser", results = { @Result(type = "json", name = SUCCESS) })
	public String addUser() {
		resultJSON = false;
		errorMessage = "Can not add user";
        try {
        	UserBean userBean = new UserBean();
        	userBean.setUsername(inputUsername);
        	userBean.setPassword(CryptUtils.encrypt2String(inputPassword));
        	userBean.setLastName(inputLastname);
        	userBean.setFirstName(inputFirstname);
        	userBean.setEmail(inputEmail);        	
        	RoleBean roleBean = roleDAO.getById(2);
        	userBean.setRole(roleBean);
        	
        	userBean.setMobileNumber(inputMobilephone);
        	userBean.setStatus(checkboxActive == true ? "active" : "new");
        	
			userDAO.insert(userBean);
			userDAO.endTransaction();
			errorMessage = "Add user successful";
			resultJSON = true;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return SUCCESS;
	}
	
	@Action(value = "/deleteUser", results = { @Result(type = "json", name = SUCCESS) })
	public String deleteUser(){
		resultJSON = false;
		errorMessage = "Can not delete user";
        try {
        	UserBean userBean = userDAO.getByUsername(inputUsername);
        	userBean.setStatus("banned");
        	
			userDAO.update(userBean) ;
			userDAO.endTransaction();
			
			errorMessage = "Delete user successful";
			resultJSON = true;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return SUCCESS;
	}
	
	@Action(value = "/getUser", results = { @Result(type = "json", name = SUCCESS) })
	public String getUser(){
		resultJSON = false;
		errorMessage = "Can not get user";
		
		try {
        	UserBean userBean = userDAO.getByUsername(inputUsername);
        	
        	this.inputEmail = userBean.getEmail();
        	this.inputFirstname = userBean.getFirstName();
        	this.inputLastname = userBean.getLastName();
        	this.inputMobilephone = userBean.getMobileNumber();
        	this.optionsRole = userBean.getRole().getName().toLowerCase();
        	this.checkboxActive = userBean.getStatus() == "active" ? true : false;
        	
			errorMessage = "Get user successful";
			resultJSON = true;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return SUCCESS;
	}
	
	@Action(value = "/updateUser", results = { @Result(type = "json", name = SUCCESS) })
	public String updateUser(){
		resultJSON = false;
		errorMessage = "Can not update user";
		try {
        	UserBean userBean = userDAO.getByUsername(inputUsername);
        	if(userBean == null){
        		errorMessage = "That user is not exist.";
    			resultJSON = false;
    			return SUCCESS;
        	}
        	userBean.setEmail(inputEmail);
        	userBean.setFirstName(inputFirstname);
        	userBean.setLastName(inputLastname);
        	userBean.setMobileNumber(inputMobilephone);
        	
        	RoleBean role = roleDAO.getById(2);
        	userBean.setRole(role);
        	
        	if(checkboxActive){
        		userBean.setStatus("active");
        	}else{
        		userBean.setStatus("inactive");
        	}
        	
        	userDAO.update(userBean);
        	userDAO.endTransaction();
        	
			errorMessage = "Edit user successful";
			resultJSON = true;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return SUCCESS;
	}
	
	@Action(value = "/resetPassword", results = { @Result(type = "json", name = SUCCESS) })
	public String resetPassword(){
		resultJSON = false;
		errorMessage = "Can not reset password.";
		String newPass = "";
		try {
        	UserBean userBean = userDAO.getByUsername(inputUsername);
        	if(userBean == null){
        		errorMessage = "That user is not exist.";
    			resultJSON = false;
    			return SUCCESS;
        	}
        	newPass = CryptUtils.generateCode(6);
        	//Send mail.
        	ul = new UserLogic();
        	ul.sendResetMailPub(newPass,userBean.getFirstName(),userBean.getLastName(),userBean.getEmail(),servletRequest.getContextPath());
        	userBean.setPassword(CryptUtils.encrypt2String(newPass));
			errorMessage = "Reset password successful";
			resultJSON = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
}
