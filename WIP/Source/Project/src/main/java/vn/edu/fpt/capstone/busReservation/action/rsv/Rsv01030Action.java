/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.rsv;

import java.io.InputStream;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

/**
 * @author Yoshimi
 * 
 */
public class Rsv01030Action extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

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
    private InputStream fileInputStream;

    /**
     * @return the fileInputStream
     */
    public InputStream getFileInputStream() {
        return fileInputStream;
    }

    @Override
    public void validate() {
        if (!session.containsKey(CommonConstant.SESSION_KEY_RESERVATION_ID)) {
            addActionError(getText("msgerrcm000"));
        } else if (session
                .containsKey(CommonConstant.SESSION_KEY_RESERVATION_ID)
                && !Integer.class.isAssignableFrom(session.get(
                        CommonConstant.SESSION_KEY_RESERVATION_ID).getClass())) {
            addActionError(getText("msgerrcm000"));
        }
    }

    @Action(results = { @Result(type = "stream", name = SUCCESS, params = {
            "contentType", "application/octet-stream", "inputName",
            "fileInputStream", "contentDisposition",
            "attachment;filename=\"reservation.pdf\"", "bufferSize", "1024" }) })
    public String execute() {
        int reservationId = 0;
        reservationId = (Integer) session
                .get(CommonConstant.SESSION_KEY_RESERVATION_ID);
        try {
            fileInputStream = reservationLogic.printReservation(reservationId);
        } catch (Exception e) {
            errorProcessing(e);
            return ERROR;
        }
        return SUCCESS;
    }
}
