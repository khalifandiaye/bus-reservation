/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

/**
 * @author Yoshimi
 *
 */
public class PaymentBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5879391215552789234L;
	private ReservationBean reservation;
	private double payAmount;
	private double serviceFee;
	private String paymentMethod;
	/**
	 * @return the reservation
	 */
	public ReservationBean getReservation() {
		return reservation;
	}
	/**
	 * @param reservation the reservation to set
	 */
	public void setReservation(ReservationBean reservation) {
		this.reservation = reservation;
	}
	/**
	 * @return the payAmount
	 */
	public double getPayAmount() {
		return payAmount;
	}
	/**
	 * @param payAmount the payAmount to set
	 */
	public void setPayAmount(double payAmount) {
		this.payAmount = payAmount;
	}
	/**
	 * @return the serviceFee
	 */
	public double getServiceFee() {
		return serviceFee;
	}
	/**
	 * @param serviceFee the serviceFee to set
	 */
	public void setServiceFee(double serviceFee) {
		this.serviceFee = serviceFee;
	}
	/**
	 * @return the paymentMethod
	 */
	public String getPaymentMethod() {
		return paymentMethod;
	}
	/**
	 * @param paymentMethod the paymentMethod to set
	 */
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
}
