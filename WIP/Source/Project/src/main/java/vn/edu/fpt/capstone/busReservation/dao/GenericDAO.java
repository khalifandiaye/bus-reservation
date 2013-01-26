/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import vn.edu.fpt.capstone.busReservation.dao.bean.AbstractBean;

/**
 * @author Yoshimi
 * 
 */
public class GenericDAO<K extends Serializable, T extends AbstractBean<K>> {

	protected final Class<T> clazz;
	private static Log log = LogFactory.getLog(GenericDAO.class);
	/**
	 * The session factory, mainly for getting current session
	 */
	protected SessionFactory sessionFactory;

	public GenericDAO(Class<T> clazz) {
		this.clazz = clazz;
	}

	/**
	 * @param sessionFactory
	 *            the sessionFactory to set
	 */
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	/**
	 * Common exception handling
	 * 
	 * @param e
	 *            the occurred exception
	 * @param session
	 *            the active session
	 */
	protected void exceptionHandling(HibernateException e, Session session) {
		try {
			if (session.getTransaction().isActive()) {
				log.debug("Trying to rollback database transaction after exception");
				session.getTransaction().rollback();
			}
		} catch (Throwable rbEx) {
			log.error("Could not rollback transaction after exception!", rbEx);
		}
		throw e;
	}

	@SuppressWarnings("unchecked")
	public List<T> getAll() {
		List<T> list = null;
		Session session = null;
		Criteria criteria = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// must have to start any transaction
//			sessionFactory.getCurrentSession().beginTransaction();
			// perform database access (query, insert, update, etc) here
			criteria = session.createCriteria(clazz);
			list = criteria.list();
			// commit transaction
//			session.getTransaction().commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		// return result, if needed
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public T getById(K id) {
		T result = null;
		Session session = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// must have to start any transaction
//			session.beginTransaction();
			// perform database access (query, insert, update, etc) here
			result = (T) session.get(clazz, id);
			// commit transaction
//			session.getTransaction().commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		// return result, if needed
		return result;
	}
	
	public K save(T t) {
		K result = null;
		Session session = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// perform database access (query, insert, update, etc) here
			session.save(t);
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
	
	public K update(T t) {
		K result = null;
		Session session = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// perform database access (query, insert, update, etc) here
			session.update(t);
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

}
