/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.interceptor.SessionAware;
import org.hibernate.HibernateException;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.TariffDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;
import vn.edu.fpt.capstone.busReservation.util.ReservationUtils;

import com.opensymphony.xwork2.ActionSupport;

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

	// =====================Database Access Object=====================
	private ReservationDAO reservationDAO;
	private TariffDAO tariffDAO;

	/**
	 * @param reservationDAO
	 *            the reservationDAO to set
	 */
	public void setReservationDAO(ReservationDAO reservationDAO) {
		this.reservationDAO = reservationDAO;
	}

	/**
	 * @param tariffDAO
	 *            the tariffDAO to set
	 */
	public void setTariffDAO(TariffDAO tariffDAO) {
		this.tariffDAO = tariffDAO;
	}

    // ==========================Logic Object==========================
    private PaymentLogic paymentLogic;
    private ReservationLogic reservationLogic;

    /**
     * @param paymentLogic
     *            the paymentLogic to set
     */
    public void setPaymentLogic(PaymentLogic paymentLogic) {
        this.paymentLogic = paymentLogic;
    }

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
                    .loadReservationInfoByCode(reservationCode);
        } catch (HibernateException e) {
            // TODO error processing
            genericDatabaseErrorProcess(e);
            return ERROR;
        } catch (CommonException e) {
            errorProcessing(e);
            return ERROR;
        }
        getSession().put(ReservationInfo.class.getName(), reservationInfo);

        return SUCCESS;
	}

}
