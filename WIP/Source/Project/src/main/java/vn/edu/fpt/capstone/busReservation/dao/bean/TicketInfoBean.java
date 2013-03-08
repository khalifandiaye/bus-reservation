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
    public TicketInfoBean(final TicketBean id, final TripBean startTrip, final TripBean endTrip) {
        setId(id);
        this.startTrip = startTrip;
        this.endTrip = endTrip;
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
