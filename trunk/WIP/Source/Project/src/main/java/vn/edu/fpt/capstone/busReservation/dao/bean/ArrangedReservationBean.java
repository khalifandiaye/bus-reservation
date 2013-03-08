/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.Date;


/**
 * @author Yoshimi
 *
 */
public final class ArrangedReservationBean extends AbstractBean<ReservationBean> {
    public final class ArrangedTicketBean extends AbstractBean<TicketBean> {
        /**
         * 
         */
        private static final long serialVersionUID = 1L;
        private final Date departureDate;

        /**
         * @param departureDate
         */
        public ArrangedTicketBean(TicketBean id, Date departureDate) {
            super(id);
            this.departureDate = departureDate;
        }

        /**
         * @return the departureDate
         */
        public Date getDepartureDate() {
            return departureDate;
        }
    }
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private final ArrangedTicketBean ticket1;
    private final ArrangedTicketBean ticket2;
    
    public ArrangedReservationBean(ReservationBean id, TicketBean ticket1, Date departureDate1, TicketBean ticket2, Date departureDate2) {
        super(id);
        this.ticket1 = new ArrangedTicketBean(ticket1, departureDate1);
        if (ticket2 != ticket1) {
            this.ticket2 = new ArrangedTicketBean(ticket2, departureDate2);
        } else {
            this.ticket2 = null;
        }
    }
    /**
     * @return the ticket1
     */
    public ArrangedTicketBean getTicket1() {
        return ticket1;
    }
    /**
     * @return the ticket2
     */
    public ArrangedTicketBean getTicket2() {
        return ticket2;
    }
}
