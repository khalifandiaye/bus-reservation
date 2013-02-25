package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import vn.edu.fpt.capstone.busReservation.dao.bean.BusTypeBean;

public class BusTypeDAO extends GenericDAO<Integer, BusTypeBean>{

	public BusTypeDAO(Class<BusTypeBean> clazz) {
		super(clazz);
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("unchecked")
    public List<BusTypeBean> getAllBusType(){
		List<BusTypeBean> result = null;
		Query query = null;
		String queryString = null;
		Session session = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		Transaction tx = session.beginTransaction();
		try {
			// perform database access (query, insert, update, etc) here
			queryString = "SELECT bus FROM BusTypeBean bus";
			query = session.createQuery(queryString);
			result = query.list();
			// commit transaction
			// session.getTransaction().commit();
			tx.commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		// return result, if needed
		return result;
	}
}
