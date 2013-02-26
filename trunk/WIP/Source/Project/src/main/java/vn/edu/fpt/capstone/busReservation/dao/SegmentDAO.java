/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;


/**
 * @author Yoshimi
 *
 */
public class SegmentDAO extends GenericDAO<Integer, SegmentBean> {

	public SegmentDAO(Class<SegmentBean> clazz) {
		super(clazz);
	}
}
