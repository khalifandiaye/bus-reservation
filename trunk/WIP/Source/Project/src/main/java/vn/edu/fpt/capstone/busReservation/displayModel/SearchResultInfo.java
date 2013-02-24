/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;
import java.util.Date;
/**
 * @author Monkey
 *
 */

public class SearchResultInfo implements Serializable{
		private static final long serialVersionUID = 52L;
		private int busStatusId;
		private String departureCity;
		private String departureStation;
		private String departureStationAddress;
		private Date departureTime;
		private String arrivalCity;
		private String arrivalStation;
		private String arrivalStationAddress;
		private Date arrivalTime;
		private double fare;
		
		/**
		 * @return the busStatusId
		 */
		public int getBusStatusId() {
			return busStatusId;
		}
		/**
		 * @param busStatusId the busStatusId to set
		 */
		public void setBusStatusId(int busStatusId) {
			this.busStatusId = busStatusId;
		}
		/**
		 * @return the departureCity
		 */
		public String getDepartureCity() {
			return departureCity;
		}
		/**
		 * @param departureCity the departureCity to set
		 */
		public void setDepartureCity(String departureCity) {
			this.departureCity = departureCity;
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
		 * @return the departureTime
		 */
		public Date getDepartureTime() {
			return departureTime;
		}
		/**
		 * @param departureTime the departureTime to set
		 */
		public void setDepartureTime(Date departureTime) {
			this.departureTime = departureTime;
		}
		/**
		 * @return the arrivalCity
		 */
		public String getArrivalCity() {
			return arrivalCity;
		}
		/**
		 * @param arrivalCity the arrivalCity to set
		 */
		public void setArrivalCity(String arrivalCity) {
			this.arrivalCity = arrivalCity;
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
		 * @return the arrivalTime
		 */
		public Date getArrivalTime() {
			return arrivalTime;
		}
		/**
		 * @param arrivalTime the arrivalTime to set
		 */
		public void setArrivalTime(Date arrivalTime) {
			this.arrivalTime = arrivalTime;
		}
		/**
		 * @return the fare
		 */
		public double getFare() {
			return fare;
		}
		/**
		 * @param fare the fare to set
		 */
		public void setFare(double fare) {
			this.fare = fare;
		}
}
