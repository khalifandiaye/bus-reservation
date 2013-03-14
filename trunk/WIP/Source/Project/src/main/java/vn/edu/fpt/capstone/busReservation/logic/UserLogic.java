/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.logic;

import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Autowired;

import vn.edu.fpt.capstone.busReservation.dao.UserDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean.UserStatus;
import vn.edu.fpt.capstone.busReservation.displayModel.RegisterModel;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CryptUtils;

/**
 * @author Yoshimi
 *
 */
public class UserLogic extends BaseLogic {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    /**
     * @param userDAO the userDAO to set
     */
    @Autowired
    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }
    
    public void registerUser(RegisterModel model) throws CommonException {
        //TODO implement it
        UserBean bean = null;
        bean = new UserBean();
        bean.setUsername(model.getUsername());
        try {
            bean.setPassword(CryptUtils.encrypt2String(model.getPassword()));
        } catch (NoSuchAlgorithmException e) {
            // Impossible exception
            throw new CommonException(e);
        }
        if (!CheckUtils.isNullOrBlank(model.getFirstName())) {
            bean.setFirstName(model.getFirstName());
        }
        if (!CheckUtils.isNullOrBlank(model.getLastName())) {
            bean.setLastName(model.getLastName());
        }
        if (!CheckUtils.isNullOrBlank(model.getPhoneNumber())) {
            bean.setPhoneNumber(model.getPhoneNumber());
        }
        if (!CheckUtils.isNullOrBlank(model.getMobileNumber())) {
            bean.setMobileNumber(model.getMobileNumber());
        }
        if (!CheckUtils.isNullOrBlank(model.getEmail())) {
            bean.setEmail(model.getEmail());
        }
        if (!CheckUtils.isNullOrBlank(model.getCivilId())) {
            bean.setCivilId(model.getCivilId());
        }
        bean.setStatus(UserStatus.NEW.getValue());
        userDAO.insert(bean);
    }
    
    public User activateUser(int userId, String code) throws CommonException {
        User user = null;
        return user;
    }

    public boolean isUsernameExists(String username) {
        return userDAO.getByUsername(username) != null;
    }

}
