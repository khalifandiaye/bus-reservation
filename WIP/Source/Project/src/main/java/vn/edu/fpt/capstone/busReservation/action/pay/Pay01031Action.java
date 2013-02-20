/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;

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
	    session.remove("reservationInfo");
	    session.remove("reservationId");
		return SUCCESS;
	}

}
