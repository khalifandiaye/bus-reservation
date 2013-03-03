/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.io.Serializable;


/**
 * @author Yoshimi
 * 
 */
public class SeatPositionKey implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3947765243302644340L;
	private String name;
	private TicketBean ticket;

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

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

    @Override
	public boolean equals(Object arg0) {
		if (arg0 == null || !this.getClass().isAssignableFrom(arg0.getClass())) {
			return false;
		} else {
			SeatPositionKey key = (SeatPositionKey) arg0;
			if (this.name == null && this.ticket == null) {
				return key.name == null && key.ticket == null;
			} else if (this.name == null && key.name == null) {
				return key.name == null
						&& this.ticket.equals(key.ticket);
			} else if (this.ticket == null) {
				return this.name.equals(key.name) && key.ticket == null;
			} else {
				return this.name.equals(key.name)
						&& this.ticket.equals(key.ticket);
			}
		}
	}

	@Override
    public int hashCode() {
        int hash = 5;
        hash = 89 * hash + (this.name != null ? this.name.hashCode() : 0);
        hash = 89 * hash + (this.ticket != null ? this.ticket.hashCode() : 0);
        return hash;
    }
}
