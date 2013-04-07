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
    private TicketBean ticket;
    private double payAmount;
    private double serviceFee;
    private PaymentMethodBean paymentMethod;
    private String transactionId;
    private PaymentType type;

    /**
     * @return the ticket
     */
    public TicketBean getTicket() {
        return ticket;
    }

    /**
     * @param ticket the ticket to set
     */
    public void setTicket(TicketBean ticket) {
        this.ticket = ticket;
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

        /* (non-Javadoc)
         * @see java.lang.Object#hashCode()
         */
        @Override
        public int hashCode() {
            final int prime = 31;
            int result = 1;
            result = prime * result + ((value == null) ? 0 : value.hashCode());
            return result;
        }

        /* (non-Javadoc)
         * @see java.lang.Object#equals(java.lang.Object)
         */
        @Override
        public boolean equals(Object obj) {
            if (this == obj)
                return true;
            if (obj == null)
                return false;
            return value.equals(obj);
        }
    }
}
