package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;

public class BusDAO extends GenericDAO<Integer, BusBean>{

	public BusDAO(Class<BusBean> clazz) {
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
	public List<BusBean> getAvailBus(Date departureTime, Date arrivalTime, int busTypeId) {
		String hql = "SELECT busBean " +
				"FROM BusBean busBean WHERE busBean.id " +
				"NOT IN (SELECT distinct busStatusBean.bus.id " +
				"FROM BusStatusBean busStatusBean " +
				"WHERE (:departureTime <= busStatusBean.fromDate and busStatusBean.fromDate <= :arrivalTime) "+
					"OR (:departureTime <= busStatusBean.toDate and busStatusBean.toDate <= :arrivalTime) "+
					"OR (:departureTime >= busStatusBean.fromDate and busStatusBean.toDate >= :arrivalTime)) " +
				"AND busBean.busType.id = :busTypeId ";
		Session session = sessionFactory.getCurrentSession();
		List<BusBean> result = new ArrayList<BusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setDate("departureTime", departureTime);
			query.setDate("arrivalTime", arrivalTime);
			query.setInteger("busTypeId", busTypeId);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

}
