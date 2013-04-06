/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.util.List;
import java.util.Locale;

import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

/**
 * @author Yoshimi
 * 
 */
public class ReservationInfo implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private int id;
    private String code;
    private String bookerName;
    private String phone;
    private String email;
    private List<Ticket> tickets;
    private Double transactionFee;
    private Double transactionFeeInUSD;
    private Double totalAmount;
    private Double totalAmountInUSD;
    private Double refundedAmount;
    private Double refundedAmountInUSD;
    private Integer refundRate;
    private String status;
    private String cancelReason;
    private Locale locale;

    /**
     * 
     */
    public ReservationInfo() {
        super();
        locale = CommonConstant.LOCALE_VN;
    }

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id
     *            the id to set
     */
    public void setId(int id) {
        this.id = id;
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
     * @return the bookerName
     */
    public String getBookerName() {
        return bookerName;
    }

    /**
     * @param bookerName
     *            the bookerName to set
     */
    public void setBookerName(String bookerName) {
        this.bookerName = bookerName;
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
    public List<Ticket> getTickets() {
        return tickets;
    }

    /**
     * @param tickets
     *            the tickets to set
     */
    public void setTickets(List<Ticket> tickets) {
        this.tickets = tickets;
    }

    /**
     * @return the basePrice
     */
    public String getBasePrice() {
        return FormatUtils.formatNumber(getBasePriceValue(), 0, locale);
    }

    /**
     * @return the basePrice
     */
    public Double getBasePriceValue() {
        double basePrice = 0;
        if (transactionFee != null && transactionFee != 0 && totalAmount != 0 && totalAmount != null) {
            basePrice = totalAmount - transactionFee;
        } else if (tickets != null) {
            for (Ticket ticket : tickets) {
                if (ticket != null) {
                    basePrice += ticket.ticketPrice;
                }
            }
        }
        return basePrice;
    }

    /**
     * @return the basePriceInUSD
     */
    public String getBasePriceInUSD() {
        return FormatUtils.formatNumber(getBasePriceInUSDValue(), 2, locale);
    }

    /**
     * @return the basePriceInUSD
     */
    public Double getBasePriceInUSDValue() {
        double basePriceInUSD = 0;
        if (transactionFeeInUSD != null && transactionFeeInUSD != 0 && totalAmountInUSD != 0 && totalAmountInUSD != null) {
            basePriceInUSD = totalAmountInUSD - transactionFeeInUSD;
        } else if (tickets != null) {
            for (Ticket ticket : tickets) {
                if (ticket != null) {
                    basePriceInUSD += ticket.ticketPriceInUSD;
                }
            }
        }
        return basePriceInUSD;
    }

    /**
     * @return the transactionFee
     */
    public String getTransactionFee() {
        return FormatUtils.formatNumber(transactionFee, 0, locale);
    }

    /**
     * @return the transactionFee
     */
    public Double getTransactionFeeValue() {
        return transactionFee;
    }

    /**
     * @param transactionFee
     *            the transactionFee to set
     */
    public void setTransactionFee(Double transactionFee) {
        this.transactionFee = transactionFee;
    }

    /**
     * @return the transactionFeeInUSD
     */
    public String getTransactionFeeInUSD() {
        return FormatUtils.formatNumber(transactionFeeInUSD, 2, locale);
    }

    /**
     * @return the transactionFeeInUSD
     */
    public Double getTransactionFeeInUSDValue() {
        return transactionFeeInUSD;
    }

    /**
     * @param transactionFeeInUSD
     *            the transactionFeeInUSD to set
     */
    public void setTransactionFeeInUSD(Double transactionFeeInUSD) {
        this.transactionFeeInUSD = transactionFeeInUSD;
    }

    /**
     * @return the totalAmount
     */
    public String getTotalAmount() {
        return FormatUtils.formatNumber(totalAmount, 0, locale);
    }

    /**
     * @return the totalAmount
     */
    public Double getTotalAmountValue() {
        return totalAmount;
    }

    /**
     * @param totalAmount
     *            the totalAmount to set
     */
    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    /**
     * @return the totalAmountInUSD
     */
    public String getTotalAmountInUSD() {
        return FormatUtils.formatNumber(totalAmountInUSD, 2, locale);
    }

    /**
     * @return the totalAmountInUSD
     */
    public Double getTotalAmountInUSDValue() {
        return totalAmountInUSD;
    }

    /**
     * @param totalAmountInUSD
     *            the totalAmountInUSD to set
     */
    public void setTotalAmountInUSD(Double totalAmountInUSD) {
        this.totalAmountInUSD = totalAmountInUSD;
    }

    /**
     * @return the refundedAmount
     */
    public String getRefundedAmount() {
        return FormatUtils.formatNumber(refundedAmount, 0, locale);
    }

    /**
     * @return the refundedAmount
     */
    public Double getRefundedAmountValue() {
        return refundedAmount;
    }

    /**
     * @param refundedAmount
     *            the refundedAmount to set
     */
    public void setRefundedAmount(Double refundedAmount) {
        this.refundedAmount = refundedAmount;
    }

    /**
     * @return the refundedAmountInUSD
     */
    public String getRefundedAmountInUSD() {
        return FormatUtils.formatNumber(refundedAmountInUSD, 0, locale);
    }

    /**
     * @return the refundedAmountInUSD
     */
    public Double getRefundedAmountInUSDValue() {
        return refundedAmountInUSD;
    }

    /**
     * @param refundedAmountInUSD
     *            the refundedAmountInUSD to set
     */
    public void setRefundedAmountInUSD(Double refundedAmountInUSD) {
        this.refundedAmountInUSD = refundedAmountInUSD;
    }

    /**
     * @return the refundRate
     */
    public String getRefundRate() {
        return refundRate == null ? null : Integer.toString(refundRate);
    }

    /**
     * @return the refundRate
     */
    public Integer getRefundRateValue() {
        return refundRate;
    }

    /**
     * @param refundRate
     *            the refundRate to set
     */
    public void setRefundRate(Integer refundRate) {
        this.refundRate = refundRate;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status
     *            the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * @return the cancelReason
     */
    public String getCancelReason() {
        return cancelReason;
    }

    /**
     * @param cancelReason the cancelReason to set
     */
    public void setCancelReason(String cancelReason) {
        this.cancelReason = cancelReason;
    }

    /**
     * @return the locale
     */
    public Locale getLocale() {
        return locale;
    }

    /**
     * @param locale
     *            the locale to set
     */
    public void setLocale(Locale locale) {
        this.locale = locale;
    }

    /**
     * @author Yoshimi
     * 
     */
    public class Ticket implements Serializable, Comparable<Ticket> {

        /**
         * 
         */
        private static final long serialVersionUID = 1L;
        private int id;
        private Long departureDateInMilisec;
        private String departureDate;
        private String departureStation;
        private String departureLocation;
        private String arrivalDate;
        private String arrivalStation;
        private String arrivalLocation;
        private String busType;
        private String[] seats;
        private Double ticketPrice;
        private Double ticketPriceInUSD;
        private String status;
        private String cancelReason;
        private boolean returnTrip;

        /**
         * @return the id
         */
        public int getId() {
            return id;
        }

        /**
         * @param id
         *            the id to set
         */
        public void setId(int id) {
            this.id = id;
        }

        /**
         * @return the departureDateInMilisec
         */
        public Long getDepartureDateInMilisec() {
            return departureDateInMilisec;
        }

        /**
         * @param departureDateInMilisec
         *            the departureDateInMilisec to set
         */
        public void setDepartureDateInMilisec(Long departureDateInMilisec) {
            this.departureDateInMilisec = departureDateInMilisec;
        }

        /**
         * @return the departureDate
         */
        public String getDepartureDate() {
            return departureDate;
        }

        /**
         * @param departureDate
         *            the departureDate to set
         */
        public void setDepartureDate(String departureDate) {
            this.departureDate = departureDate;
        }

        /**
         * @return the departureStation
         */
        public String getDepartureStation() {
            return departureStation;
        }

        /**
         * @param departureStation
         *            the departureStation to set
         */
        public void setDepartureStation(String departureStation) {
            this.departureStation = departureStation;
        }

        /**
         * @return the departureLocation
         */
        public String getDepartureLocation() {
            return departureLocation;
        }

        /**
         * @param departureLocation
         *            the departureLocation to set
         */
        public void setDepartureLocation(String departureLocation) {
            this.departureLocation = departureLocation;
        }

        /**
         * @return the arrivalDate
         */
        public String getArrivalDate() {
            return arrivalDate;
        }

        /**
         * @param arrivalDate
         *            the arrivalDate to set
         */
        public void setArrivalDate(String arrivalDate) {
            this.arrivalDate = arrivalDate;
        }

        /**
         * @return the arrivalStation
         */
        public String getArrivalStation() {
            return arrivalStation;
        }

        /**
         * @param arrivalStation
         *            the arrivalStation to set
         */
        public void setArrivalStation(String arrivalStation) {
            this.arrivalStation = arrivalStation;
        }

        /**
         * @return the arrivalLocation
         */
        public String getArrivalLocation() {
            return arrivalLocation;
        }

        /**
         * @param arrivalLocation
         *            the arrivalLocation to set
         */
        public void setArrivalLocation(String arrivalLocation) {
            this.arrivalLocation = arrivalLocation;
        }

        /**
         * @return the busType
         */
        public String getBusType() {
            return busType;
        }

        /**
         * @param busType
         *            the busType to set
         */
        public void setBusType(String busType) {
            this.busType = busType;
        }

        /**
         * @return the seats
         */
        public String[] getSeats() {
            return seats;
        }

        /**
         * @param seats
         *            the seats to set
         */
        public void setSeats(String[] seats) {
            this.seats = seats;
        }

        /**
         * @return the ticketPrice
         */
        public String getTicketPrice() {
            return FormatUtils.formatNumber(ticketPrice, 0, locale);
        }

        /**
         * @return the ticketPrice
         */
        public Double getTicketPriceValue() {
            return ticketPrice;
        }

        /**
         * @param ticketPrice
         *            the ticketPrice to set
         */
        public void setTicketPrice(Double ticketPrice) {
            this.ticketPrice = ticketPrice;
        }

        /**
         * @return the ticketPriceInUSD
         */
        public String getTicketPriceInUSD() {
            return FormatUtils.formatNumber(ticketPriceInUSD, 2, locale);
        }

        /**
         * @return the ticketPriceInUSD
         */
        public Double getTicketPriceInUSDValue() {
            return ticketPriceInUSD;
        }

        /**
         * @param ticketPriceInUSD
         *            the ticketPriceInUSD to set
         */
        public void setTicketPriceInUSD(Double ticketPriceInUSD) {
            this.ticketPriceInUSD = ticketPriceInUSD;
        }

        /**
         * @return the status
         */
        public String getStatus() {
            return status;
        }

        /**
         * @param status
         *            the status to set
         */
        public void setStatus(String status) {
            this.status = status;
        }

        /**
         * @return the cancelReason
         */
        public String getCancelReason() {
            return cancelReason;
        }

        /**
         * @param cancelReason
         *            the cancelReason to set
         */
        public void setCancelReason(String cancelReason) {
            this.cancelReason = cancelReason;
        }

        /**
         * @return the returnTrip
         */
        public boolean isReturnTrip() {
            return returnTrip;
        }

        /**
         * @param returnTrip
         *            the returnTrip to set
         */
        public void setReturnTrip(boolean returnTrip) {
            this.returnTrip = returnTrip;
        }

        /* (non-Javadoc)
         * @see java.lang.Comparable#compareTo(java.lang.Object)
         */
        @Override
        public int compareTo(Ticket o) {
            int result = 0;
            if (this.departureDateInMilisec == null
                    || (!this.returnTrip && o.returnTrip)) {
                result = -1;
            } else if (o == null || o.departureDateInMilisec == null
                    || (this.returnTrip && !o.returnTrip)) {
                result = 1;
            } else {
                result = o.departureDateInMilisec
                        .compareTo(departureDateInMilisec);
            }
            return result;
        }

    }
}
