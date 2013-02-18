/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author Yoshimi
 * 
 */
public class Pay01000Action extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5713118155580163291L;

	// =====================Database Access Object=====================
	private ReservationDAO reservationDAO;

	/**
	 * @param reservationDAO
	 *            the reservationDAO to set
	 */
	public void setReservationDAO(ReservationDAO reservationDAO) {
		this.reservationDAO = reservationDAO;
	}

	// ==========================Action output=========================
	private Map<Integer, String> reservationList;

	/**
	 * @return the reservationList
	 */
	public Map<Integer, String> getReservationList() {
		return reservationList;
	}

	public String execute() {
		List<ReservationBean> reservations = null;
		StringBuilder description = null;
		reservations = reservationDAO.getAll();
		reservationList = new HashMap<Integer, String>();
		description = new StringBuilder();
		for (ReservationBean reservation : reservations) {
			description.setLength(0);
			description.append(reservation.getId());
			description.append(" - ");
			description.append(FormatUtils.formatDate(
					reservation.getBookTime(), "yyyy/MM/dd hh:mm", Locale.US, CommonConstant.DEFAULT_TIME_ZONE));
			description.append(", ");
			description
					.append((reservation.getPayments() == null || reservation
							.getPayments().size() <= 0) ? "unpaid" : "paid");
			reservationList.put(reservation.getId(), description.toString());
		}
		return SUCCESS;
	}

}
