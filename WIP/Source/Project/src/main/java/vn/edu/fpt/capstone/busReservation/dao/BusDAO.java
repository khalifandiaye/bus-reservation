package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Restrictions;

import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;

public class BusDAO extends GenericDAO<Integer, TripBean>{

	public BusDAO(Class<TripBean> clazz) {
		super(clazz);
		// TODO Auto-generated constructor stub
	}

	@SuppressWarnings("unchecked")
	public List<Integer> getBusyBus(Date date) {
		String hql = "select distinct busStatusBean.bus.id from BusStatusBean busStatusBean where :date > busStatusBean.fromDate and busStatusBean.toDate < :date";
		Session session = sessionFactory.getCurrentSession();
		List<Integer> result = new ArrayList<Integer>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setDate("date", date);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public List<BusBean> getAvailBus(List<Integer> busyBusIds) {
		Session session = sessionFactory.getCurrentSession();
		Criteria criteria = session.createCriteria(BusBean.class);
		if (busyBusIds != null && !busyBusIds.isEmpty()) {
			criteria.add(Restrictions.not(
			// replace "id" below with property name, depending on what you're
			// filtering against
					Restrictions.in("id", busyBusIds)));
		}

		return criteria.list();
	}
}
