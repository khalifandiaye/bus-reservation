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

    /**
     * 
     */
    public ReservationInfoBean() {
    }

    /**
     * @param id
     */
    public ReservationInfoBean(ReservationBean id) {
        super(id);
    }

    /**
     * @param id
     * @param startTrip
     * @param endTrip
     */
    public ReservationInfoBean(ReservationBean id, TripBean startTrip, TripBean endTrip) {
        super(id);
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

}
