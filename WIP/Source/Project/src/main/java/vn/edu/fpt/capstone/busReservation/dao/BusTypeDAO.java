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
		Transaction tx = session.beginTransaction();
		try {
			String queryString = "SELECT bus FROM BusTypeBean bus";
			Query query = session.createQuery(queryString);
			result = query.list();
			tx.commit();
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
								 " 	 inner join tariff trf on bty.id = trf.bus_type_id " +
								 "	 inner join route_details rdt on rdt.segment_id = trf.segment_id " +
								 " where rdt.route_id = :route_id " +
								 " group by bty.id " +
								 " having count(distinct trf.segment_id) = (select count(rou.segment_id) " + 
								 "							 			    from route_details rou " +
								 "										    where rou.route_id = :route_id) ";
			Query query = session.createSQLQuery(queryString);
			query.setParameter("route_id", routeId);
			result = query.list();
			tx.commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
}
