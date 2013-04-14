package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;

import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

/**
 * Immutable
 *
 */
public final class TripDetailInfo implements Serializable, Comparable<TripDetailInfo> {

    private static final long serialVersionUID = -2195287469199563262L;

    private static final Format dateFormatter = new SimpleDateFormat(
            "dd-MM-yyyy HH:mm a", CommonConstant.LOCALE_VN);
    private static final Format dateFormatterFull = new SimpleDateFormat(
            "yyyy-MM-dd HH:mm:ss", CommonConstant.LOCALE_VN);
    private final int busStatusId;
    private final String from;
    private final String to;
    private final Date departureTime;
    private final Date arrivalTime;
    private final int remainedSeatCount;

    /**
     * @param busStatusId
     * @param from
     * @param to
     * @param departureTime
     * @param arrivalTime
     */
    public TripDetailInfo(int busStatusId, String from, String to,
            Date departureTime, Date arrivalTime, int remainedSeatCount) {
        this.busStatusId = busStatusId;
        this.from = from;
        this.to = to;
        this.departureTime = (Date) departureTime.clone();
        this.arrivalTime = (Date) arrivalTime.clone();
        this.remainedSeatCount = remainedSeatCount;
    }

    /**
     * @return the busStatusId
     */
    public int getBusStatusId() {
        return busStatusId;
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
     * @return the departureTime
     */
    public Date getDepartureTimeValue() {
        return (Date) departureTime.clone();
    }

    /**
     * @return the arrivalTime
     */
    public Date getArrivalTimeValue() {
        return (Date) arrivalTime.clone();
    }

    /**
     * @return the departureTimeFull
     */
    public String getDepartureTimeFull() {
        return dateFormatterFull.format((Date) departureTime.clone());
    }

    /**
     * @return the arrivalTimeFull
     */
    public String getArrivalTimeFull() {
        return dateFormatterFull.format((Date) arrivalTime.clone());
    }

    /**
     * @return the name
     */
    public String getName() {
        return from + " - " + to;
    }

    /**
     * @return the departureTime
     */
    public String getDepartureTime() {
        return dateFormatter.format((Date) departureTime.clone());
    }

    /**
     * @return the arrivalTime
     */
    public String getArrivalTime() {
        return dateFormatter.format((Date) arrivalTime.clone());
    }

    /**
     * @return the remainedSeatCount
     */
    public int getRemainedSeatCount() {
        return remainedSeatCount;
    }

    @Override
    public int compareTo(TripDetailInfo o) {
        // null == null
        if (this.departureTime == null && (o == null || o.departureTime == null)) {
            return 0;
        }
        // null > anything
        if (this.departureTime == null) {
            return 1;
        } else if (o == null || o.departureTime == null) {
            return -1;
        }
        return this.departureTime.compareTo(o.departureTime);
    }
}
