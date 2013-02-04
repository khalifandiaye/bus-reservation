package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.List;

/**
 * @author Yoshimi
 *
 */
public class RoleBean extends AbstractBean<Integer> {
    /**
     * 
     */
    private static final long serialVersionUID = 5155493553891303354L;
    private String name;
    private List<UserBean> users;
    /**
     * @return the name
     */
    public String getName() {
        return name;
    }
    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }
    /**
     * @return the users
     */
    public List<UserBean> getUsers() {
        return users;
    }
    /**
     * @param users the users to set
     */
    public void setUsers(List<UserBean> users) {
        this.users = users;
    }
}
