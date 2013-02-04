/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.List;

/**
 * @author Yoshimi
 *
 */
public class BusTypeBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1442140060048270348L;
	private String name;
	private int numberOfSeats;
	private List<BusBean> buses;
	private List<TariffBean> tariffs;

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the numberOfSeats
	 */
	public int getNumberOfSeats() {
		return numberOfSeats;
	}

	/**
	 * @param numberOfSeats the numberOfSeats to set
	 */
	public void setNumberOfSeats(int numberOfSeats) {
		this.numberOfSeats = numberOfSeats;
	}

	/**
	 * @return the buses
	 */
	public List<BusBean> getBuses() {
	    return buses;
	}

	/**
	 * @param buses the buses to set
	 */
	public void setBuses(List<BusBean> buses) {
	    this.buses = buses;
	}

	/**
	 * @return the tariffs
	 */
	public List<TariffBean> getTariffs() {
	    return tariffs;
	}

	/**
	 * @param tariffs the tariffs to set
	 */
	public void setTariffs(List<TariffBean> tariffs) {
	    this.tariffs = tariffs;
	}
}
