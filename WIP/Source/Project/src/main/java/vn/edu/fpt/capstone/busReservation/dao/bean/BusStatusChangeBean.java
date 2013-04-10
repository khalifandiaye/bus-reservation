/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.Date;

/**
 * @author Yoshimi
 *
 */
public class BusStatusChangeBean extends AbstractBean<Integer> {
	/**
     * 
     */
    private static final long serialVersionUID = 1L;
    private BusStatusBean busStatus;
    private UserBean user;
    private BusStatusChangeTypeBean type;
    private String reason;
    private Date date;

    /**
     * @return the busStatus
     */
    public BusStatusBean getBusStatus() {
        return busStatus;
    }

    /**
     * @param busStatus
     *            the busStatus to set
     */
    public void setBusStatus(BusStatusBean busStatus) {
        this.busStatus = busStatus;
    }

    /**
     * @return the user
     */
    public UserBean getUser() {
        return user;
    }

    /**
     * @param user
     *            the user to set
     */
    public void setUser(UserBean user) {
        this.user = user;
    }

    /**
     * @return the type
     */
    public BusStatusChangeTypeBean getType() {
        return type;
    }

    /**
     * @param type the type to set
     */
    public void setType(BusStatusChangeTypeBean type) {
        this.type = type;
    }

    /**
     * @return the reason
     */
    public String getReason() {
        return reason;
    }

    /**
     * @param reason
     *            the reason to set
     */
    public void setReason(String reason) {
        this.reason = reason;
    }

    /**
     * @return the date
     */
    public Date getDate() {
        return date;
    }

    /**
     * @param date
     *            the date to set
     */
    public void setDate(Date date) {
        this.date = date;
    }
}