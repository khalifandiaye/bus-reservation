/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.hibernate.HibernateException;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;

/**
 * @author Yoshimi
 * 
 */
@Action(results = {@Result(name="input", location="pay02000-success.jsp" )})
public class Pay02010Action extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5713118155580163291L;

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
	private String reservationCode;

	/**
	 * @param reservationCode the reservationCode to set
	 */
	public void setReservationCode(String reservationCode) {
	    this.reservationCode = reservationCode;
	}

	// ==========================Action Output=========================
	private ReservationInfo reservationInfo;

	/**
	 * @return the reservationInfo
	 */
	public ReservationInfo getReservationInfo() {
		return reservationInfo;
	}

	@Override
	public void validate() {
		if (CheckUtils.isNullOrBlank(reservationCode)) {
			addFieldError("reservationCode", "Please enter a reservation code");
		}
	}

	public String execute() {
        try {
            reservationInfo = reservationLogic
                    .loadReservationInfoByCode(reservationCode, true);
        } catch (HibernateException e) {
            // TODO error processing
            genericDatabaseErrorProcess(e);
            return ERROR;
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        }
        session.put(ReservationInfo.class.getName(), reservationInfo);

        return SUCCESS;
	}

}
