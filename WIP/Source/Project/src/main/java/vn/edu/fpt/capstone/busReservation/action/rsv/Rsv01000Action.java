/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.rsv;

import java.util.List;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;

/**
 * @author Yoshimi
 *
 */
public class Rsv01000Action extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 5062565033385325127L;
    // ==========================Logic Object==========================
    private ReservationLogic reservationLogic;
    /**
     * @param reservationLogic the reservationLogic to set
     */
    public void setReservationLogic(ReservationLogic reservationLogic) {
        this.reservationLogic = reservationLogic;
    }
    
    // ==========================Action Output=========================
    private List<String> userList;
    
    /**
     * @return the userList
     */
    public List<String> getUserList() {
        return userList;
    }

    @Override
    public String execute() throws Exception {
        userList = reservationLogic.getUserList();
        return SUCCESS;
    }
}
