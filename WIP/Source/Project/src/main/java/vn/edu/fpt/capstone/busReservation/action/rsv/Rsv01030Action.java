/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.rsv;

import java.io.InputStream;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;

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

    @Action(results = { @Result(type = "stream", name = SUCCESS, params = {
            "contentType", "application/octet-stream", "inputName",
            "fileInputStream", "contentDisposition",
            "attachment;filename=\"reservation.pdf\"", "bufferSize", "1024" }) })
    public String execute() {
        try {
            fileInputStream = reservationLogic.printReservation(0, servletRequest.getSession()
                    .getId(), ServletActionContext.getServletContext()
                    .getRealPath("/"));
        } catch (Exception e) {
            errorProcessing(e);

        }
        return SUCCESS;
    }
}
