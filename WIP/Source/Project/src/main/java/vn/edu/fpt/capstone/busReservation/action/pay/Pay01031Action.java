/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author Yoshimi
 *
 */
public class Pay01031Action extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1609116152245459318L;
	
	public String execute() {
        getSession().remove("reservationInfo");
        getSession().remove("reservationId");
		return SUCCESS;
	}

}
