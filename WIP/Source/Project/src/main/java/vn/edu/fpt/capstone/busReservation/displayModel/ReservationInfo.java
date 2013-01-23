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
	private String routeName;
	private String subRouteName;
	private String departureDate;
	private String arrivalDate;
	private String seatNumbers;
	/**
	 * number of tickets
	 */
	private String quantity;
	/**
	 * conversion rate from USD
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
	 * currency in price list
	 */
	private String currency;
	/**
	 * total amount that must be paid in USD
	 */
	private String totalAmountInUSD;
	/**
	 * @return the routeName
	 */
	public String getRouteName() {
		return routeName;
	}
	/**
	 * @param routeName the routeName to set
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
	 */
	public String getConversionRate() {
		return conversionRate;
	}
	/**
	 * @param conversionRate the conversionRate to set
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
	 * @return the currency
	 */
	public String getCurrency() {
		return currency;
	}
	/**
	 * @param currency the currency to set
	 */
	public void setCurrency(String currency) {
		this.currency = currency;
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
}
