/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;

/**
 * @author Yoshimi
 * 
 */
public abstract class TripUtils {

	/**
	 * Get the first and last trips from a list of continuous trips.<br>
	 * 
	 * @param trips
	 *            a list of trips
	 * @return an array of the first and the last trips, in that order
	 */
	public static Map<Integer, TripBean[]> getStartEndTrips(List<TripBean> trips) {
		Map<Integer, TripBean[]> result = null;
		int busStatusId = 0;
		result = new HashMap<Integer, TripBean[]>();
		for (TripBean trip : trips) {
			busStatusId = trip.getBusStatus().getId();
			if (!result.containsKey(busStatusId)) {
				result.put(busStatusId, new TripBean[2]);
			}
			if (result.get(busStatusId)[0] == null
					|| result.get(busStatusId)[0].getArrivalTime().after(
							trip.getArrivalTime())) {
				result.get(busStatusId)[0] = trip;
			}
			if (result.get(busStatusId)[1] == null
					|| result.get(busStatusId)[1].getArrivalTime().before(
							trip.getArrivalTime())) {
				result.get(busStatusId)[1] = trip;
			}
		}
		return result;
	}

}
