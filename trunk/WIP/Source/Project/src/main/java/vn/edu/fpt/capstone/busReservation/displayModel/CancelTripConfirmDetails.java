/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

/**
 * @author Yoshimi
 *
 */
public class CancelTripConfirmDetails implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private int reservationCount;
    private double refundAmount;
    /**
     * @return the reservationCount
     */
    public int getReservationCount() {
        return reservationCount;
    }
    /**
     * @param reservationCount the reservationCount to set
     */
    public void setReservationCount(int reservationCount) {
        this.reservationCount = reservationCount;
    }
    /**
     * @return the refundAmount
     */
    public double getRefundAmount() {
        return refundAmount;
    }
    /**
     * @param refundAmount the refundAmount to set
     */
    public void setRefundAmount(double refundAmount) {
        this.refundAmount = refundAmount;
    }
    
}
