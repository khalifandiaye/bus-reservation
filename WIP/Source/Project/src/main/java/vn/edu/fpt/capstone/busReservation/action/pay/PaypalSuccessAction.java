/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author Yoshimi
 * 
 */
public class PaypalSuccessAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -855508237619631030L;

	public String execute() {
		System.out.println("PaypalSuccessAction");
		return SUCCESS;
	}
}
