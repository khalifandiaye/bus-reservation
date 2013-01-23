/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;


/**
 * @author Yoshimi
 *
 */
public class StationDAO extends GenericDAO<Integer, StationBean> {

	public StationDAO(Class<StationBean> clazz) {
		super(clazz);
	}
}
