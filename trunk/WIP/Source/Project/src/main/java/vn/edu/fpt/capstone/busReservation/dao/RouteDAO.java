package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

public class RouteDAO extends GenericDAO<Integer, RouteBean> {

	public RouteDAO(Class<RouteBean> clazz) {
		super(clazz);
	}

	/**
	 * Common database exception handling
	 * 
	 * @param e
	 *            the occurred exception
	 * @throws HibernateException
	 *             the occurred exception
	 */
	public int deleteRouteByRouteId(int routeId) {
		String hql = "DELETE FROM RouteBean r WHERE r.id = :routeId";
		Session session = sessionFactory.getCurrentSession();
		int result = 0;
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("routeId", routeId);
			result = query.executeUpdate();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
	
	/**
	 * Common database exception handling
	 * 
	 * @param e
	 *            the occurred exception
	 * @throws HibernateException
	 *             the occurred exception
	 */
	@SuppressWarnings("unchecked")
	public List<RouteBean> getAllActiveRoute() {
		String hql = "SELECT r FROM RouteBean r WHERE r.status = :status";
		Session session = sessionFactory.getCurrentSession();
		List<RouteBean> result = null;
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setString("status", "active");
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<Integer> getRouteTerminal(int routeId) {
		String queryString = "SELECT ter.return_route_id FROM (SELECT `rdt`.`route_id` AS `forward_route_id`,`rdt_r`.`route_id` AS `return_route_id` "
				+ "FROM (`bus_reservation`.`route_details` `rdt` "
				+ "INNER JOIN `bus_reservation`.`segment` `seg` ON `rdt`.`segment_id` = `seg`.`id`) "
				+ "LEFT JOIN (`bus_reservation`.`route_details` `rdt_r` "
				+ "INNER JOIN `bus_reservation`.`segment` `seg_r` ON `rdt_r`.`segment_id` = `seg_r`.`id`) "
				+ "ON `seg`.`departure_station_id` = `seg_r`.`arrival_station_id` "
				+ "AND `seg`.`arrival_station_id` = `seg_r`.`departure_station_id` "
				+ "GROUP BY `rdt`.`route_id`,`rdt_r`.`route_id` "
				+ "HAVING COUNT(DISTINCT `rdt_r`.`id`) = (SELECT COUNT(*) FROM `bus_reservation`.`route_details` `rdt1` WHERE `rdt1`.`route_id` = `rdt_r`.`route_id`)) ter "
				+ "WHERE ter.forward_route_id = :routeId";
		List<Integer> result = null;
		Session session = sessionFactory.getCurrentSession();
		List<Integer> list = null;
		try {
			// must have to start any transaction
			Query query = session.createSQLQuery(queryString);
			query.setInteger("routeId", routeId);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		if (result != null && result.size() > 0) {
			list = new ArrayList<Integer>();
			list.add(routeId);
			list.add(result.get(0));
		}
		return list;
	}
	
	/**
	 * Common database exception handling
	 * 
	 * @param e
	 *            the occurred exception
	 * @throws HibernateException
	 *             the occurred exception
	 */
	@SuppressWarnings("unchecked")
	public List<RouteBean> getExistRoute(List<SegmentBean> segmentList) {
		String hql = "SELECT route FROM RouteBean route WHERE 0 = "
				+ "(SELECT COUNT(*) FROM RouteDetailsBean rdt "
				+ "WHERE rdt.route = route AND rdt.segment NOT IN (:segmentList)) "
				+ "AND :segmentCount = (SELECT COUNT(*) FROM RouteDetailsBean rdt WHERE rdt.route = route)";
		Session session = sessionFactory.getCurrentSession();
		List<RouteBean> result = new ArrayList<RouteBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameterList("segmentList", segmentList);
			query.setParameter("segmentCount", (long) segmentList.size());
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
	
}
