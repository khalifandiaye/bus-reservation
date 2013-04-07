package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

/**
 * @author Yoshimi
 * 
 */
public class RefundInfo implements Serializable {

    public final class RefundInfoPerTicket {

        /**
         * @param refundAmount
         * @param refundAmountInUSD
         */
        public RefundInfoPerTicket(int ticketId, double refundAmount,
                double refundAmountInUSD) {
            this.ticketId = ticketId;
            this.refundAmount = refundAmount;
            this.refundAmountInUSD = refundAmountInUSD;
        }

        private final int ticketId;
        private final double refundAmount;
        private final double refundAmountInUSD;

        /**
         * @return the ticketId
         */
        public int getTicketId() {
            return ticketId;
        }

        /**
         * @return the refundAmount
         */
        public double getRefundAmount() {
            return refundAmount;
        }

        /**
         * @return the refundAmountInUSD
         */
        public double getRefundAmountInUSD() {
            return refundAmountInUSD;
        }
    }

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private List<RefundInfoPerTicket> tickets;
    private int refundRate;
    private int paymentMethodId;
    private int reservationId;

    /**
     * 
     */
    public RefundInfo() {
        tickets = new ArrayList<RefundInfo.RefundInfoPerTicket>();
    }

    /**
     * @return the tickets
     */
    public List<RefundInfoPerTicket> getTickets() {
        return tickets;
    }

    /**
     * @return the refundAmount
     */
    public double getRefundAmount() {
        double refundAmount = 0;
        if (tickets != null) {
            for (RefundInfoPerTicket ticket : tickets) {
                if (ticket != null) {
                    refundAmount += ticket.refundAmount;
                }
            }
        }
        return refundAmount;
    }

    /**
     * @return the refundAmountInUSD
     */
    public double getRefundAmountInUSD() {
        double refundAmountInUSD = 0;
        if (tickets != null) {
            for (RefundInfoPerTicket ticket : tickets) {
                if (ticket != null) {
                    refundAmountInUSD += ticket.refundAmountInUSD;
                }
            }
        }
        return refundAmountInUSD;
    }

    /**
     * @return the refundRate
     */
    public int getRefundRate() {
        return refundRate;
    }

    /**
     * @param refundRate
     *            the refundRate to set
     */
    public void setRefundRate(int refundRate) {
        this.refundRate = refundRate;
    }

    public String getRefundAmountString() {
        return FormatUtils.formatNumber(getRefundAmount(), 0,
                CommonConstant.LOCALE_VN);
    }

    public String getRefundAmountInUSDString() {
        return FormatUtils.formatNumber(getRefundAmountInUSD(), 2,
                CommonConstant.LOCALE_VN);
    }

    public String getRefundRateString() {
        return Integer.toString(refundRate);
    }

    /**
     * @return the paymentMethodId
     */
    public int getPaymentMethodId() {
        return paymentMethodId;
    }

    /**
     * @param paymentMethodId the paymentMethodId to set
     */
    public void setPaymentMethodId(int paymentMethodId) {
        this.paymentMethodId = paymentMethodId;
    }

    /**
     * @return the reservationId
     */
    public int getReservationId() {
        return reservationId;
    }

    /**
     * @param reservationId the reservationId to set
     */
    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

}
