/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.security.InvalidParameterException;
import java.util.Date;
import java.util.List;

/**
 * @author Yoshimi
 * 
 */
public class ReservationBean extends AbstractBean<Integer> {
    /**
	 * 
	 */
    private static final long serialVersionUID = -8741646328583374172L;
    private UserBean booker;
    private String code;
    private Date bookTime;
    private ReservationStatus status;
    private String bookerFirstName;
    private String bookerLastName;
    private String phone;
    private String email;
    private List<TicketBean> tickets;
    private List<PaymentBean> payments;

    /**
     * @return the booker
     */
    public UserBean getBooker() {
        return booker;
    }

    /**
     * @param booker
     *            the booker to set
     */
    public void setBooker(UserBean booker) {
        this.booker = booker;
    }

    /**
     * @return the code
     */
    public String getCode() {
        return code;
    }

    /**
     * @param code
     *            the code to set
     */
    public void setCode(String code) {
        this.code = code;
    }

    /**
     * @return the bookTime
     */
    public Date getBookTime() {
        return bookTime;
    }

    /**
     * @param bookTime
     *            the bookTime to set
     */
    public void setBookTime(Date bookTime) {
        this.bookTime = bookTime;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status != null ? status.value : null;
    }

    /**
     * @param status
     *            the status to set
     */
    public void setStatus(String status) {
        this.status = ReservationStatus.fromValue(status);
    }

    /**
     * @return the bookerFirstName
     */
    public String getBookerFirstName() {
        return bookerFirstName;
    }

    /**
     * @param bookerFirstName
     *            the bookerFirstName to set
     */
    public void setBookerFirstName(String bookerFirstName) {
        this.bookerFirstName = bookerFirstName;
    }

    /**
     * @return the bookerLastName
     */
    public String getBookerLastName() {
        return bookerLastName;
    }

    /**
     * @param bookerLastName
     *            the bookerLastName to set
     */
    public void setBookerLastName(String bookerLastName) {
        this.bookerLastName = bookerLastName;
    }

    /**
     * @return the phone
     */
    public String getPhone() {
        return phone;
    }

    /**
     * @param phone
     *            the phone to set
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email
     *            the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the tickets
     */
    public List<TicketBean> getTickets() {
        return tickets;
    }

    /**
     * @param tickets the tickets to set
     */
    public void setTickets(List<TicketBean> tickets) {
        this.tickets = tickets;
    }

    /**
     * @return the payments
     */
    public List<PaymentBean> getPayments() {
        return payments;
    }

    /**
     * @param payments
     *            the payments to set
     */
    public void setPayments(List<PaymentBean> payments) {
        this.payments = payments;
    }

    /**
     * Support class for properties with limited value
     * 
     * @author Yoshimi
     * 
     */
    public static class ReservationStatus {
        private final String value;
        /**
         * The reservation is in effect.
         */
        public static final ReservationStatus PAID = new ReservationStatus(
                "paid");
        /**
         * The reservation has been created, but payment has not been completed
         */
        public static final ReservationStatus UNPAID = new ReservationStatus(
                "unpaid");
        /**
         * The reservation can no longer be cancelled
         */
        public static final ReservationStatus PENDING = new ReservationStatus(
                "pending");
        /**
         * The first trip has departed
         */
        public static final ReservationStatus DEPARTED = new ReservationStatus(
                "departed");
        /**
         * The reservation has been cancelled due to the trip being cancelled.<br>
         * Awaiting refund or changing trip.
         */
        public static final ReservationStatus CANCELLED = new ReservationStatus(
                "cancelled");
        /**
         * The reservation has been moved to another trip
         */
        public static final ReservationStatus MOVED = new ReservationStatus(
                "moved");
        /**
         * The reservation was not paid within the time limit
         */
        public static final ReservationStatus DELETED = new ReservationStatus(
                "deleted");
        /**
         * The reservation was cancelled, and refund is completed.
         */
        public static final ReservationStatus REFUNDED = new ReservationStatus(
                "refunded");

        private ReservationStatus(String value) {
            this.value = value;
        }

        public static final ReservationStatus fromValue(final String value) {
            if (value == null) {
                return null;
            } else if (PAID.value.equalsIgnoreCase(value)) {
                return PAID;
            } else if (UNPAID.value.equalsIgnoreCase(value)) {
                return UNPAID;
            } else if (PENDING.value.equalsIgnoreCase(value)) {
                return PENDING;
            } else if (DEPARTED.value.equalsIgnoreCase(value)) {
                return DEPARTED;
            } else if (CANCELLED.value.equalsIgnoreCase(value)) {
                return CANCELLED;
            } else if (MOVED.value.equalsIgnoreCase(value)) {
                return MOVED;
            } else if (DELETED.value.equalsIgnoreCase(value)) {
                return DELETED;
            } else if (REFUNDED.value.equalsIgnoreCase(value)) {
                return REFUNDED;
            } else {
                throw new InvalidParameterException("Can not instantiate new "
                        + ReservationStatus.class.getName()
                        + " from the value \"" + value + "\"");
            }
        }

        /**
         * @return the value
         */
        public String getValue() {
            return value;
        }
    }
}
