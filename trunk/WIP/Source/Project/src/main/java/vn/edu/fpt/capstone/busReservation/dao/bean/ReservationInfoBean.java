/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;


/**
 * @author Yoshimi
 * 
 */
public class ReservationInfoBean extends AbstractBean<ReservationBean> {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private TripBean startTrip;
    private TripBean endTrip;
    private Double ticketPrice;
    private Double paidAmount;
    private Double refundAmount;

    /**
     * @return the startTrip
     */
    public TripBean getStartTrip() {
        return startTrip;
    }

    /**
     * @param startTrip
     *            the startTrip to set
     */
    public void setStartTrip(TripBean startTrip) {
        this.startTrip = startTrip;
    }

    /**
     * @return the endTrip
     */
    public TripBean getEndTrip() {
        return endTrip;
    }

    /**
     * @param endTrip
     *            the endTrip to set
     */
    public void setEndTrip(TripBean endTrip) {
        this.endTrip = endTrip;
    }

    /**
     * @return the ticketPrice
     */
    public Double getTicketPrice() {
        return ticketPrice;
    }

    /**
     * @param ticketPrice the ticketPrice to set
     */
    public void setTicketPrice(Double ticketPrice) {
        this.ticketPrice = ticketPrice;
    }

    /**
     * @return the paidAmount
     */
    public Double getPaidAmount() {
        return paidAmount;
    }

    /**
     * @param paidAmount the paidAmount to set
     */
    public void setPaidAmount(Double paidAmount) {
        this.paidAmount = paidAmount;
    }

    /**
     * @return the refundAmount
     */
    public Double getRefundAmount() {
        return refundAmount;
    }

    /**
     * @param refundAmount the refundAmount to set
     */
    public void setRefundAmount(Double refundAmount) {
        this.refundAmount = refundAmount;
    }

}
