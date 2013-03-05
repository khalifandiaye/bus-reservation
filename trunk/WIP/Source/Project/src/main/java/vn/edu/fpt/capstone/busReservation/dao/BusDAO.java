package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;

public class BusDAO extends GenericDAO<Integer, BusBean> {

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

	/*
	 * SELECT b.id, b.plate_number, MAX(bs.to_date) FROM bus b LEFT JOIN
	 * bus_status bs ON b.id = bs.bus_id WHERE bs.end_station_id = 8 AND
	 * (b.assigned_route_forward_id = 1 OR b.assigned_route_return_id = 1) GROUP
	 * BY b.id
	 */
	@SuppressWarnings("unchecked")
	public List<Object[]> getAvailBus(Date departureTime, int routeId,
			int startStationId, int busTypeId) {
		String stringQuery = "SELECT b.id, b.plate_number, bs.to_date, bs.end_station_id "
				+ "FROM bus b LEFT JOIN (SELECT t1.* FROM bus_status t1 "
				+ "JOIN (SELECT Max(id) id, MAX(to_date) to_date FROM bus_status WHERE status = 'active' GROUP BY bus_id ) t2 "
				+ "ON t1.id = t2.id AND t1.to_date = t2.to_date) bs ON b.id = bs.bus_id "
				+ "WHERE (b.assigned_route_forward_id = :routeId OR b.assigned_route_return_id = :routeId) "
				+ "AND b.bus_type_id = :busTypeId AND b.status = 'active'" 
				+ "GROUP BY b.id "
				+ "HAVING bs.to_date < :departureTime AND bs.end_station_id = :startStationId";

		Session session = sessionFactory.getCurrentSession();
		List<Object[]> result = new ArrayList<Object[]>();
		try {
			// must have to start any transaction
			Query query = session.createSQLQuery(stringQuery);
			query.setParameter("departureTime", departureTime);
			query.setParameter("routeId", routeId);
			query.setParameter("startStationId", startStationId);
			query.setParameter("busTypeId", busTypeId);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
	
	public List<BusBean> getBusByType(int busType) {
		String hql = "FROM BusBean b WHERE b.busType.id = :busType";
		Session session = sessionFactory.getCurrentSession();
		List<BusBean> result = new ArrayList<BusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("busType", busType);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

}
