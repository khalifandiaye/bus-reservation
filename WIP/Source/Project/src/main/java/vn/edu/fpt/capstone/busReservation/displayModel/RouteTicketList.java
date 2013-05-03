/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.DateUtils;

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
    private final Date fromDate;
    private final String busPlate;
    private final List<SegmentTicket> segmentTicketList;

    /**
     * @param from
     * @param to
     */
    public RouteTicketList(String from, String to, Date fromDate,
            String busPlate) {
        this.from = from;
        this.to = to;
        this.fromDate = fromDate;
        this.busPlate = busPlate;
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
     * @return the fromDate
     */
    public Date getFromDate() {
        return fromDate;
    }

    /**
     * @return the fromDate
     */
    public String getFromDateStr() {
        return DateUtils.date2String(fromDate,
                CommonConstant.PATTERN_DATE_TIME_LONG,
                CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE);
    }

    /**
     * @return the busPlate
     */
    public String getBusPlate() {
        return busPlate;
    }

    /**
     * @return the segmentTicketList
     */
    public List<SegmentTicket> getSegmentTicketList() {
        return segmentTicketList;
    }

}
