/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.security.InvalidParameterException;

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
    private PaymentMethodBean paymentMethod;
    private String transactionId;
    private PaymentType type;

    /**
     * @return the reservation
     */
    public ReservationBean getReservation() {
        return reservation;
    }

    /**
     * @param reservation
     *            the reservation to set
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
     * @param payAmount
     *            the payAmount to set
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
     * @param serviceFee
     *            the serviceFee to set
     */
    public void setServiceFee(double serviceFee) {
        this.serviceFee = serviceFee;
    }

    /**
     * @return the paymentMethod
     */
    public PaymentMethodBean getPaymentMethod() {
        return paymentMethod;
    }

    /**
     * @param paymentMethod
     *            the paymentMethod to set
     */
    public void setPaymentMethod(PaymentMethodBean paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    /**
     * @return the transactionId
     */
    public String getTransactionId() {
        return transactionId;
    }

    /**
     * @param transactionId
     *            the transactionId to set
     */
    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    /**
     * @return the type
     */
    public String getType() {
        return type != null ? type.getValue() : null;
    }

    /**
     * @param type
     *            the type to set
     */
    public void setType(String type) {
        this.type = PaymentType.fromValue(type);
    }

    /**
     * Support class for properties with limited value
     * 
     * @author Yoshimi
     * 
     */
    public static class PaymentType {
        private final String value;
        public static final PaymentType PAY = new PaymentType("pay");
        public static final PaymentType REFUND = new PaymentType("refund");

        private PaymentType(String value) {
            this.value = value;
        }

        public static final PaymentType fromValue(final String value) {
            if (value == null) {
                return null;
            } else if (PAY.value.equalsIgnoreCase(value)) {
                return PAY;
            } else if (REFUND.value.equalsIgnoreCase(value)) {
                return REFUND;
            } else {
                throw new InvalidParameterException("Can not instantiate new "
                        + PaymentType.class.getName() + " from the value \""
                        + value + "\"");
            }
        }

        /**
         * @return the value
         */
        public String getValue() {
            return value;
        }
    }
}
