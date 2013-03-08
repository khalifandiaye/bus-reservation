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
    private int id;
    private StationBean from;
    private StationBean to;
    private Date departureDate;
    private Date bookTime;
    private String reservationStatus;
    private String ticketStatus;

    /**
     * 
     */
    public SimpleReservationInfo() {
    }

    /**
     * @param reservationId
     * @param ticketId
     * @param from
     * @param to
     * @param departureDate
     * @param bookTime
     * @param status
     */
    public SimpleReservationInfo(int id,
            StationBean from, StationBean to, Date departureDate,
            Date bookTime, String reservationStatus, String ticketStatus) {
        this.id = id;
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
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the from
     */
    public StationBean getFrom() {
        return from;
    }

    /**
     * @param from
     *            the from to set
     */
    public void setFrom(StationBean from) {
        this.from = from;
    }

    /**
     * @return the to
     */
    public StationBean getTo() {
        return to;
    }

    /**
     * @param to
     *            the to to set
     */
    public void setTo(StationBean to) {
        this.to = to;
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
     * @param departureDate
     *            the departureDate to set
     */
    public void setDepartureDate(Date departureDate) {
        this.departureDate = departureDate;
    }

    /**
     * @return the departureDate
     */
    public String getDepartureDateStr() {
        return DateUtils.date2String(departureDate, "dd/MM/yyyy hh:mm aa",
                CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE);
    }

    /**
     * @param bookTime
     *            the bookTime to set
     */
    public void setBookTime(Date bookTime) {
        this.bookTime = bookTime;
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
     * @param reservationStatus the reservationStatus to set
     */
    public void setReservationStatus(String reservationStatus) {
        this.reservationStatus = reservationStatus;
    }

    /**
     * @return the ticketStatus
     */
    public String getTicketStatus() {
        return ticketStatus;
    }

    /**
     * @param ticketStatus the ticketStatus to set
     */
    public void setTicketStatus(String ticketStatus) {
        this.ticketStatus = ticketStatus;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        if (ReservationStatus.CANCELLED.equals(reservationStatus)
                || ReservationStatus.DELETED.equals(reservationStatus)
                || ReservationStatus.REFUNDED.equals(reservationStatus)
                || ReservationStatus.MOVED.equals(reservationStatus)
                || ReservationStatus.UNPAID.equals(reservationStatus)) {
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
