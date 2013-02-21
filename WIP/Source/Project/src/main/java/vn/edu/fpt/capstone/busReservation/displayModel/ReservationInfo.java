/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

/**
 * @author Yoshimi
 *
 */
public class ReservationInfo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7740272488683962205L;
    private int id;
	/**
	 * 
     * @deprecated
	 */
	private String routeName;
	private String subRouteName;
	private String departureDate;
	private String departureStationAddress;
	private String arrivalDate;
	private String arrivalStationAddress;
	private String seatNumbers;
	private String bookerName;
	private String phone;
	private String email;
	/**
	 * number of tickets
	 */
	private String quantity;
	/**
	 * conversion rate from USD
	 * @deprecated
	 */
	private String conversionRate;
	/**
	 * base price of each ticket
	 */
	private String basePrice;
	/**
	 * base price of each ticket in USD
	 */
	private String basePriceInUSD;
	/**
	 * online transaction fee
	 */
	private String transactionFee;
	/**
	 * online transaction fee in USD
	 */
	private String transactionFeeInUSD;
	/**
	 * total amount that must be paid
	 */
	private String totalAmount;
	/**
	 * total amount that must be paid in USD
	 */
	private String totalAmountInUSD;
	/**
	 * status of the reservation
	 */
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
	 * @return the subRouteName
	 */
	public String getSubRouteName() {
		return subRouteName;
	}
	/**
	 * @param subRouteName the subRouteName to set
	 */
	public void setSubRouteName(String subRouteName) {
		this.subRouteName = subRouteName;
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
     * @return the departureStationAddress
     */
    public String getDepartureStationAddress() {
        return departureStationAddress;
    }
    /**
     * @param departureStationAddress the departureStationAddress to set
     */
    public void setDepartureStationAddress(String departureStationAddress) {
        this.departureStationAddress = departureStationAddress;
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
     * @return the arrivalStationAddress
     */
    public String getArrivalStationAddress() {
        return arrivalStationAddress;
    }
    /**
     * @param arrivalStationAddress the arrivalStationAddress to set
     */
    public void setArrivalStationAddress(String arrivalStationAddress) {
        this.arrivalStationAddress = arrivalStationAddress;
    }
    /**
	 * @return the seatNumbers
	 */
	public String getSeatNumbers() {
		return seatNumbers;
	}
	/**
	 * @param seatNumbers the seatNumbers to set
	 */
	public void setSeatNumbers(String seatNumbers) {
		this.seatNumbers = seatNumbers;
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
	 * @return the conversionRate
     * @deprecated
	 */
	public String getConversionRate() {
		return conversionRate;
	}
	/**
	 * @param conversionRate the conversionRate to set
     * @deprecated
	 */
	public void setConversionRate(String conversionRate) {
		this.conversionRate = conversionRate;
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
}
