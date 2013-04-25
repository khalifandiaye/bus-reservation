/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.util.Set;
import java.util.TreeSet;

/**
 * @author Yoshimi
 * 
 */
public final class SegmentTicket implements Serializable {
    public final class Ticket implements Serializable, Comparable<Ticket> {
        /**
         * 
         */
        private static final long serialVersionUID = 1L;
        private final String code;
        private final String seats;

        /**
         * @param code
         * @param seats
         */
        public Ticket(String code, String seats) {
            if (code == null || seats == null) {
                throw new IllegalArgumentException(
                        "Unable to create vn.edu.fpt.capstone.busReservation.displayModel.SegmentTicket.Ticket with code "
                                + code + " and seats " + seats);
            }
            this.code = code;
            this.seats = seats;
            ticketList.add(this);
        }

        /**
         * @return the code
         */
        public String getCode() {
            return code;
        }

        /**
         * @return the seats
         */
        public String getSeats() {
            return seats;
        }

        /* (non-Javadoc)
         * @see java.lang.Comparable#compareTo(java.lang.Object)
         */
        @Override
        public int compareTo(Ticket o) {
            if (this.code.equals(o.code)) {
                return this.seats.compareTo(o.seats);
            }
            return this.code.compareTo(o.code);
        }

        /* (non-Javadoc)
         * @see java.lang.Object#hashCode()
         */
        @Override
        public int hashCode() {
            final int prime = 31;
            int result = 1;
            result = prime * result + getOuterType().hashCode();
            result = prime * result + ((code == null) ? 0 : code.hashCode());
            result = prime * result + ((seats == null) ? 0 : seats.hashCode());
            return result;
        }

        /* (non-Javadoc)
         * @see java.lang.Object#equals(java.lang.Object)
         */
        @Override
        public boolean equals(Object obj) {
            if (this == obj)
                return true;
            if (obj == null)
                return false;
            if (getClass() != obj.getClass())
                return false;
            Ticket other = (Ticket) obj;
            if (!getOuterType().equals(other.getOuterType()))
                return false;
            if (code == null) {
                if (other.code != null)
                    return false;
            } else if (!code.equals(other.code))
                return false;
            if (seats == null) {
                if (other.seats != null)
                    return false;
            } else if (!seats.equals(other.seats))
                return false;
            return true;
        }

        private SegmentTicket getOuterType() {
            return SegmentTicket.this;
        }
    }

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private final String from;
    private final String to;
    private final Set<Ticket> ticketList;

    /**
     * @param from
     * @param to
     */
    public SegmentTicket(String from, String to) {
        this.from = from;
        this.to = to;
        this.ticketList = new TreeSet<SegmentTicket.Ticket>();
    }

    /**
     * @return the ticketList
     */
    public Set<Ticket> getTicketList() {
        return ticketList;
    }

    /**
     * @return the from
     */
    public String getFrom() {
        return from;
    }

    /**
     * @return the to
     */
    public String getTo() {
        return to;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((from == null) ? 0 : from.hashCode());
        result = prime * result + ((to == null) ? 0 : to.hashCode());
        return result;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        SegmentTicket other = (SegmentTicket) obj;
        if (from == null) {
            if (other.from != null)
                return false;
        } else if (!from.equals(other.from))
            return false;
        if (to == null) {
            if (other.to != null)
                return false;
        } else if (!to.equals(other.to))
            return false;
        return true;
    }

}
