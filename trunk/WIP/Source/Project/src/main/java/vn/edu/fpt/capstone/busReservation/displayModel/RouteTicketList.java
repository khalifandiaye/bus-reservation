/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Yoshimi
 * 
 */
public class RouteTicketList implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private final String from;
    private final String to;
    private final List<SegmentTicket> segmentTicketList;

    /**
     * @param from
     * @param to
     */
    public RouteTicketList(String from, String to) {
        this.from = from;
        this.to = to;
        this.segmentTicketList = new ArrayList<SegmentTicket>();
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

    /**
     * @return the segmentTicketList
     */
    public List<SegmentTicket> getSegmentTicketList() {
        return segmentTicketList;
    }

}
