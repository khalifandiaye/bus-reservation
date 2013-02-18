package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;

public class UserDAO extends GenericDAO<Integer, UserBean> {

	public UserDAO(Class<UserBean> clazz) {
		super(clazz);
	}
	
	public boolean isExist(String username){
		List<UserBean> result = null;
		Query query = null;
		String queryString = null;
		Session session = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// perform database access (query, insert, update, etc) here
			queryString = "SELECT user FROM UserBean AS user WHERE user.username = ?";
			query = session.createQuery(queryString);
			query.setString(0, username);
			result = query.list();
			// commit transaction
			// session.getTransaction().commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		// return result, if needed
		if (result.size() > 0) {
			return true;
		}
		return false;
	}
	
	public boolean isEmailExist(String email){
		List<UserBean> result = null;
		Query query = null;
		String queryString = null;
		Session session = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// perform database access (query, insert, update, etc) here
			queryString = "SELECT user FROM UserBean AS user WHERE user.email = ?";
			query = session.createQuery(queryString);
			query.setString(0, email);
			result = query.list();
			// commit transaction
			// session.getTransaction().commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		// return result, if needed
		if (result.size() > 0) {
			return true;
		}
		return false;
	}
	
}
