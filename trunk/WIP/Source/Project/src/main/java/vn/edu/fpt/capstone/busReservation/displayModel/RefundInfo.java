package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

/**
 * @author Yoshimi
 *
 */
public class RefundInfo implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private double refundAmount;
    private double refundAmountInUSD;
    private int refundRate;
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
    /**
     * @return the refundAmountInUSD
     */
    public double getRefundAmountInUSD() {
        return refundAmountInUSD;
    }
    /**
     * @param refundAmountInUSD the refundAmountInUSD to set
     */
    public void setRefundAmountInUSD(double refundAmountInUSD) {
        this.refundAmountInUSD = refundAmountInUSD;
    }
    
    /**
     * @return the refundRate
     */
    public int getRefundRate() {
        return refundRate;
    }
    /**
     * @param refundRate the refundRate to set
     */
    public void setRefundRate(int refundRate) {
        this.refundRate = refundRate;
    }
    public String getRefundAmountString() {
        return FormatUtils.formatNumber(this.refundAmount,
                0, CommonConstant.LOCALE_VN);
    }
    
    public String getRefundAmountInUSDString() {
        return FormatUtils.formatNumber(this.refundAmountInUSD,
                2, CommonConstant.LOCALE_VN);
    }
    
    public String getRefundRateString() {
        return Integer.toString(refundRate);
    }

}
