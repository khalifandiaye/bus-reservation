package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
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
		List<BusTypeBean> result = new ArrayList<BusTypeBean>();
		Session session = sessionFactory.getCurrentSession();
		try {
			String queryString = "SELECT bus FROM BusTypeBean bus";
			Query query = session.createQuery(queryString);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
	
	@SuppressWarnings("unchecked")
    public List<Object[]> getBusTypesInRoute(int routeId) {
		List<Object[]> result = new ArrayList<Object[]>();
		Session session = sessionFactory.getCurrentSession();
		Transaction tx = session.beginTransaction();
		try {
			String queryString = " SELECT bty.* " +
								 " FROM bus_type bty " +
								 " 	 INNER JOIN tariff trf ON bty.id = trf.bus_type_id " +
								 "	 INNER JOIN route_details rdt ON rdt.segment_id = trf.segment_id " +
								 " WHERE rdt.route_id = :routeId " +
								 " GROUP BY bty.id " +
								 " HAVING COUNT(DISTINCT trf.segment_id) = (SELECT COUNT(rou.segment_id) " + 
								 "							 			    FROM route_details rou " +
								 "										    WHERE rou.route_id = :routeId) ";
//			String queryString = "SELECT bt.* FROM " +
				//               "( SELECT rd.route_id AS id, t.bus_type_id AS bus_type_id " +
				//               "FROM route_details rd LEFT JOIN tariff t ON rd.segment_id = t.segment_id " +
				//               "GROUP BY rd.route_id, t.bus_type_id HAVING rd.route_id = :routeId ) " +
				//               "AS bir LEFT JOIN bus_type bt " +
				//               "ON bir.bus_type_id = bt.id";
			Query query = session.createSQLQuery(queryString);
			query.setParameter("routeId", routeId);
			result = query.list();
			tx.commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
}
