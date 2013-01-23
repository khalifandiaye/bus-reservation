package vn.edu.fpt.capstone.busReservation.dao;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;

public class ReservationDAO extends GenericDAO<Integer,ReservationBean> {

	public ReservationDAO(Class<ReservationBean> clazz) {
		super(clazz);
	}

}
