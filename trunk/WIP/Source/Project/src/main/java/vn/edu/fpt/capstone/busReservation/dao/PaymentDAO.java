package vn.edu.fpt.capstone.busReservation.dao;

import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean;

public class PaymentDAO extends GenericDAO<Integer,PaymentBean> {

	public PaymentDAO(Class<PaymentBean> clazz) {
		super(clazz);
	}

}
