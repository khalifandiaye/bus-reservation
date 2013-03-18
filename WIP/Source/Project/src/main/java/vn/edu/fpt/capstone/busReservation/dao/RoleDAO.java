package vn.edu.fpt.capstone.busReservation.dao;

import vn.edu.fpt.capstone.busReservation.dao.bean.RoleBean;

public class RoleDAO extends GenericDAO<Integer, RoleBean> {

	public RoleDAO(Class<RoleBean> clazz) {
		super(clazz);
	}
}
