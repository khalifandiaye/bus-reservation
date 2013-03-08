/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.util.Date;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.DateUtils;

/**
 * @author Yoshimi
 * 
 */
public class SimpleReservationInfo implements Serializable, Comparable<SimpleReservationInfo> {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private final int id;
    private final int ticketId;
    private final StationBean from;
    private final StationBean to;
    private final Date departureDate;
    private final Date bookTime;
    private final String reservationStatus;
    private final String ticketStatus;

    /**
     * @param reservationId
     * @param ticketId
     * @param from
     * @param to
     * @param departureDate
     * @param bookTime
     * @param status
     */
    public SimpleReservationInfo(int id, int ticketId,
            StationBean from, StationBean to, Date departureDate,
            Date bookTime, String reservationStatus, String ticketStatus) {
        this.id = id;
        this.ticketId = ticketId;
        this.from = from;
        this.to = to;
        this.departureDate = departureDate;
        this.bookTime = bookTime;
        this.reservationStatus = reservationStatus;
        this.ticketStatus = ticketStatus;
    }

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @return the ticketId
     */
    public int getTicketId() {
        return ticketId;
    }

    /**
     * @return the from
     */
    public StationBean getFrom() {
        return from;
    }

    /**
     * @return the to
     */
    public StationBean getTo() {
        return to;
    }

    /**
     * @return the subRouteName
     */
    public String getSubRouteName() {
        return from.getCity().getName() + " - " + to.getCity().getName();
    }

    /**
     * @return the departureDate
     */
    public Date getDepartureDate() {
        return departureDate;
    }

    /**
     * @return the departureDate
     */
    public String getDepartureDateStr() {
        return DateUtils.date2String(departureDate, "dd/MM/yyyy hh:mm aa",
                CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE);
    }

    /**
     * @return the bookTime
     */
    public String getBookTime() {
        return DateUtils.date2String(bookTime, "dd/MM/yyyy hh:mm aa",
                CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE);
    }

    /**
     * @return the bookTimeInMilisec
     */
    public long getBookTimeInMilisec() {
        return bookTime.getTime();
    }

    /**
     * @return the reservationStatus
     */
    public String getReservationStatus() {
        return reservationStatus;
    }

    /**
     * @return the ticketStatus
     */
    public String getTicketStatus() {
        return ticketStatus;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        if (ReservationStatus.CANCELLED.getValue().equals(reservationStatus)
                || ReservationStatus.DELETED.getValue().equals(reservationStatus)
                || ReservationStatus.REFUNDED.getValue().equals(reservationStatus)
                || ReservationStatus.MOVED.getValue().equals(reservationStatus)
                || ReservationStatus.UNPAID.getValue().equals(reservationStatus)) {
            return reservationStatus;
        } else {
            return ticketStatus;
        }
    }

    @Override
    public int compareTo(SimpleReservationInfo o) {
        long thisDepartureTime = 0;
        long departureTime = 0;
        long now = 0;
        long result = 0;
        thisDepartureTime = departureDate.getTime();
        departureTime = o.departureDate.getTime();
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
