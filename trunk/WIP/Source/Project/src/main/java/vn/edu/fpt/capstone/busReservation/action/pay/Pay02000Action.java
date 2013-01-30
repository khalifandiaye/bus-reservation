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
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author Yoshimi
 * 
 */
public class Pay02000Action extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5713118155580163291L;

	// =====================Database Access Object=====================

	// ==========================Action output=========================

	public String execute() {
		return SUCCESS;
	}

}
