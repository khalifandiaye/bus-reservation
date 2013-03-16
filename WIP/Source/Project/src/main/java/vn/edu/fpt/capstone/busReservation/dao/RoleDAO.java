package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.RoleBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;

public class RoleDAO extends GenericDAO<Integer, RoleBean> {

	public RoleDAO(Class<RoleBean> clazz) {
		super(clazz);
	}
}
