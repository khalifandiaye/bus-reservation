/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

/**
 * @author Yoshimi
 * 
 */
public class PaymentDetails implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private int ticketId;
    private String grossAmount;
    private String feeAmount;
    private String transactionID;
    private boolean fullRefund;

    /**
     * @return the ticketId
     */
    public int getTicketId() {
        return ticketId;
    }

    /**
     * @param ticketId
     *            the ticketId to set
     */
    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    /**
     * @return the grossAmount
     */
    public String getGrossAmount() {
        return grossAmount;
    }

    /**
     * @param grossAmount
     *            the grossAmount to set
     */
    public void setGrossAmount(String grossAmount) {
        this.grossAmount = grossAmount;
    }

    /**
     * @return the feeAmount
     */
    public String getFeeAmount() {
        return feeAmount;
    }

    /**
     * @param feeAmount
     *            the feeAmount to set
     */
    public void setFeeAmount(String feeAmount) {
        this.feeAmount = feeAmount;
    }

    /**
     * @return the transactionID
     */
    public String getTransactionID() {
        return transactionID;
    }

    /**
     * @param transactionID
     *            the transactionID to set
     */
    public void setTransactionID(String transactionID) {
        this.transactionID = transactionID;
    }

    /**
     * @return the isFullRefund
     */
    public boolean isFullRefund() {
        return fullRefund;
    }

    /**
     * @param isFullRefund
     *            the isFullRefund to set
     */
    public void setFullRefund(boolean fullRefund) {
        this.fullRefund = fullRefund;
    }
}
