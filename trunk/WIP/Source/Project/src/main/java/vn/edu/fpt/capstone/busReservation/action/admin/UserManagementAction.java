/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.admin;

import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.UserDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author NoName
 *
 */
public class UserManagementAction extends ActionSupport {
	/**
	 * 
	 */
    private static final long serialVersionUID = 1L;

    // ===========================DAO Object===========================
    private UserDAO userDAO;

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    // ==========================Action Output=========================
    private List<UserBean> listUser;
    
    
	/**
	 * @return the listUser
	 */
	public List<UserBean> getListUser() {
		return listUser;
	}


	public String execute(){ 
		listUser = new ArrayList<UserBean>(); 
		listUser = userDAO.getAllActiveUser();
		return SUCCESS;
	}
}
