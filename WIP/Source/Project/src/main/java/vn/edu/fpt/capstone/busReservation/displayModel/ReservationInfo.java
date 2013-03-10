/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.util.List;

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
	private String routeName;
	private String bookerName;
	private String phone;
	private String email;
	private List<Ticket> tickets;
	private String quantity;
	private String basePrice;
	private String basePriceInUSD;
	private String transactionFee;
	private String transactionFeeInUSD;
	private String totalAmount;
	private String totalAmountInUSD;
    private String refundedAmount;
    private String refundedAmountInUSD;
    private String refundRate;
	private String status;
    
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
     * @return the code
     */
    public String getCode() {
        return code;
    }

    /**
     * @param code the code to set
     */
    public void setCode(String code) {
        this.code = code;
    }

    /**
     * @return the routeName
     * @deprecated
     */
    public String getRouteName() {
        return routeName;
    }

    /**
     * @param routeName the routeName to set
     * @deprecated
     */
    public void setRouteName(String routeName) {
        this.routeName = routeName;
    }

    /**
     * @return the bookerName
     */
    public String getBookerName() {
        return bookerName;
    }

    /**
     * @param bookerName the bookerName to set
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
     * @param phone the phone to set
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
     * @param email the email to set
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
     * @param tickets the tickets to set
     */
    public void setTickets(List<Ticket> tickets) {
        this.tickets = tickets;
    }

    /**
     * @return the quantity
     */
    public String getQuantity() {
        return quantity;
    }

    /**
     * @param quantity the quantity to set
     */
    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    /**
     * @return the basePrice
     */
    public String getBasePrice() {
        return basePrice;
    }

    /**
     * @param basePrice the basePrice to set
     */
    public void setBasePrice(String basePrice) {
        this.basePrice = basePrice;
    }

    /**
     * @return the basePriceInUSD
     */
    public String getBasePriceInUSD() {
        return basePriceInUSD;
    }

    /**
     * @param basePriceInUSD the basePriceInUSD to set
     */
    public void setBasePriceInUSD(String basePriceInUSD) {
        this.basePriceInUSD = basePriceInUSD;
    }

    /**
     * @return the transactionFee
     */
    public String getTransactionFee() {
        return transactionFee;
    }

    /**
     * @param transactionFee the transactionFee to set
     */
    public void setTransactionFee(String transactionFee) {
        this.transactionFee = transactionFee;
    }

    /**
     * @return the transactionFeeInUSD
     */
    public String getTransactionFeeInUSD() {
        return transactionFeeInUSD;
    }

    /**
     * @param transactionFeeInUSD the transactionFeeInUSD to set
     */
    public void setTransactionFeeInUSD(String transactionFeeInUSD) {
        this.transactionFeeInUSD = transactionFeeInUSD;
    }

    /**
     * @return the totalAmount
     */
    public String getTotalAmount() {
        return totalAmount;
    }

    /**
     * @param totalAmount the totalAmount to set
     */
    public void setTotalAmount(String totalAmount) {
        this.totalAmount = totalAmount;
    }

    /**
     * @return the totalAmountInUSD
     */
    public String getTotalAmountInUSD() {
        return totalAmountInUSD;
    }

    /**
     * @param totalAmountInUSD the totalAmountInUSD to set
     */
    public void setTotalAmountInUSD(String totalAmountInUSD) {
        this.totalAmountInUSD = totalAmountInUSD;
    }

    /**
     * @return the refundedAmount
     */
    public String getRefundedAmount() {
        return refundedAmount;
    }

    /**
     * @param refundedAmount the refundedAmount to set
     */
    public void setRefundedAmount(String refundedAmount) {
        this.refundedAmount = refundedAmount;
    }

    /**
     * @return the refundedAmountInUSD
     */
    public String getRefundedAmountInUSD() {
        return refundedAmountInUSD;
    }

    /**
     * @param refundedAmountInUSD the refundedAmountInUSD to set
     */
    public void setRefundedAmountInUSD(String refundedAmountInUSD) {
        this.refundedAmountInUSD = refundedAmountInUSD;
    }

    /**
     * @return the refundRate
     */
    public String getRefundRate() {
        return refundRate;
    }

    /**
     * @param refundRate the refundRate to set
     */
    public void setRefundRate(String refundRate) {
        this.refundRate = refundRate;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
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
        private String arrivalDate;
        private String arrivalStation;
        private String busType;
        private String[] seats;
        private String status;
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
         * @return the departureDateInMilisec
         */
        public Long getDepartureDateInMilisec() {
            return departureDateInMilisec;
        }
        /**
         * @param departureDateInMilisec the departureDateInMilisec to set
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
         * @param departureDate the departureDate to set
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
         * @param departureStation the departureStation to set
         */
        public void setDepartureStation(String departureStation) {
            this.departureStation = departureStation;
        }
        /**
         * @return the arrivalDate
         */
        public String getArrivalDate() {
            return arrivalDate;
        }
        /**
         * @param arrivalDate the arrivalDate to set
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
         * @param arrivalStation the arrivalStation to set
         */
        public void setArrivalStation(String arrivalStation) {
            this.arrivalStation = arrivalStation;
        }
        /**
         * @return the busType
         */
        public String getBusType() {
            return busType;
        }
        /**
         * @param busType the busType to set
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
         * @param seats the seats to set
         */
        public void setSeats(String[] seats) {
            this.seats = seats;
        }
        /**
         * @return the status
         */
        public String getStatus() {
            return status;
        }
        /**
         * @param status the status to set
         */
        public void setStatus(String status) {
            this.status = status;
        }
        @Override
        public int compareTo(Ticket o) {
            int result = 0;
            if (this.departureDateInMilisec == null) {
                result = -1;
            } else if (o == null || o.departureDate == null) {
                result = 1;
            } else {
                result = o.getDepartureDate().compareTo(departureDate);
            }
            return result;
        }
        
    }
}
