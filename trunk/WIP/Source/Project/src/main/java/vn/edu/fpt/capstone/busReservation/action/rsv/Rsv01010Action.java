/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.rsv;

import java.util.List;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.SimpleReservationInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

/**
 * @author Yoshimi
 * 
 */
public class Rsv01010Action extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = -8442913088264749449L;
    // ==========================Logic Object==========================
    private ReservationLogic reservationLogic;

    /**
     * @param reservationLogic
     *            the reservationLogic to set
     */
    public void setReservationLogic(ReservationLogic reservationLogic) {
        this.reservationLogic = reservationLogic;
    }

    // ==========================Action Input==========================
    // ==========================Action Output=========================
    private List<SimpleReservationInfo> reservationList;

    /**
     * @return the reservationList
     */
    public List<SimpleReservationInfo> getReservationList() {
        return reservationList;
    }

    // ========================Action Execution========================
    private void forTest() {
        String username = null;
        User user = null;
        // create dummy session object
        if (!CheckUtils.isNullOrBlank(servletRequest.getParameter("username"))) {
            username = servletRequest.getParameter("username");
            user = new User("1", username, "1", "First", "Customer", null,
                    "cust1_1357703483_per@fpt.edu.vn");
            session.put(CommonConstant.SESSION_KEY_USER, user);
        }
    }

    @Override
    public String execute() {
        String username = null;
        forTest();
        if (session.containsKey(CommonConstant.SESSION_KEY_USER)) {
            username = ((User) session.get(CommonConstant.SESSION_KEY_USER))
                    .getUsername();
        } else {
            // TODO handle error
            commonSessionTimeoutError();
            return ERROR;
        }
        try {
            reservationList = reservationLogic.loadReservations(username);
        } catch (CommonException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return SUCCESS;
    }
}
