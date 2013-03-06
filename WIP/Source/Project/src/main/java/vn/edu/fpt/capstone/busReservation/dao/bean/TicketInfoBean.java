/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

/**
 * @author Yoshimi
 * 
 */
public class TicketInfoBean extends AbstractBean<TicketBean> implements
        Comparable<TicketInfoBean> {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private TripBean startTrip;
    private TripBean endTrip;
    private Double ticketPrice;

    /**
     * 
     */
    public TicketInfoBean() {
    }

    /**
     * @param startTrip
     * @param endTrip
     * @param ticketPrice
     */
    public TicketInfoBean(TicketBean id, TripBean startTrip, TripBean endTrip,
            Double ticketPrice) {
        setId(id);
        this.startTrip = startTrip;
        this.endTrip = endTrip;
        this.ticketPrice = ticketPrice;
    }

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
     * @param ticketPrice
     *            the ticketPrice to set
     */
    public void setTicketPrice(Double ticketPrice) {
        this.ticketPrice = ticketPrice;
    }

    @Override
    public int compareTo(TicketInfoBean o) {
        long thisDepartureTime = 0;
        long departureTime = 0;
        long now = 0;
        long result = 0;
        thisDepartureTime = startTrip.getDepartureTime().getTime();
        departureTime = o.startTrip.getDepartureTime().getTime();
        now = System.currentTimeMillis();
        if (thisDepartureTime < now || departureTime < now) {
            result = departureTime - thisDepartureTime;
        } else {
            result = thisDepartureTime - departureTime; 
        }
        return result > Integer.MAX_VALUE ? Integer.MAX_VALUE
                : result < Integer.MIN_VALUE ? Integer.MIN_VALUE : (int) result;
    }
}
