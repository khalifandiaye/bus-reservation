/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

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
        this.status = status != null ? ReservationStatus.fromValue(status) : null;
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
     * @param tickets
     *            the tickets to set
     */
    public void setTickets(List<TicketBean> tickets) {
        this.tickets = tickets;
    }

    /**
     * Support class for properties with limited value
     * 
     * @author Yoshimi
     * 
     */
    public static enum ReservationStatus {
        /**
         * The reservation is in effect.
         */
        PAID("paid"),
        /**
         * The reservation has been created, but payment has not been completed
         */
        UNPAID("unpaid"),
        /**
         * The reservation can no longer be cancelled
         */
        PENDING("pending"),
        /**
         * The first trip has departed
         */
        DEPARTED("departed"),
        /**
         * The reservation has been cancelled due to the trip being cancelled.<br>
         * Awaiting refund or changing trip.
         */
        CANCELLED("cancelled"),
        /**
         * The reservation has been moved to another trip
         */
        MOVED("moved"),
        /**
         * The reservation was not paid within the time limit
         */
        DELETED("deleted"),
        /**
         * The reservation was cancelled by user, and refund is completed.
         */
        REFUNDED("refunded"),
        /**
         * The reservation was cancelled by company, and refund is completed.
         */
        REFUNDED2("refunded2");

        private String value;

        private ReservationStatus(String value) {
            this.value = value;
        }

        public static final ReservationStatus fromValue(final String value) {
            for (ReservationStatus c : values()) {
                if (c.value.equals(value)) {
                    return c;
                }
            }
            throw new IllegalArgumentException(value);
        }

        /**
         * @return the value
         */
        public String getValue() {
            return value;
        }
    }
}
