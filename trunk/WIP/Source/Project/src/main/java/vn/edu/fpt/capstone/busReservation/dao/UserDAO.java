package vn.edu.fpt.capstone.busReservation.dao;

import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;

public class UserDAO extends GenericDAO<Integer, UserBean> {

	public UserDAO(Class<UserBean> clazz) {
		super(clazz);
	}

}
