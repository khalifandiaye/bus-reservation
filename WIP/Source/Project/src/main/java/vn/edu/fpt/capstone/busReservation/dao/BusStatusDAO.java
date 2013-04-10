/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusChangeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusChangeTypeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean.TicketStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;

/**
 * @author Yoshimi
 * 
 */
public class BusStatusDAO extends GenericDAO<Integer, BusStatusBean> {

	public BusStatusDAO(Class<BusStatusBean> clazz) {
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
	@SuppressWarnings("unchecked")
	public List<BusStatusBean> getAllTrip() {
		String hql = "SELECT bs FROM BusStatusBean bs WHERE bs.status = :status "
				+ "AND bs.busStatus != :busStatus";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("status", "active");
			query.setParameter("busStatus", "initiation");
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

	/**
	 * Common database exception handling Get all scheduled trip from (toDate)
	 * to future that has status is maintain or ontrip
	 * 
	 * @param e
	 *            the occurred exception
	 * @throws HibernateException
	 *             the occurred exception
	 */
	@SuppressWarnings("unchecked")
	public List<BusStatusBean> getAllScheduledTrip(Date fromDate) {
		String hql = "SELECT bs FROM BusStatusBean bs WHERE bs.status = :status "
				+ "AND bs.busStatus != :busStatus "
				+ "AND bs.fromDate >= :fromDate ORDER BY bs.fromDate ASC";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("status", "active");
			query.setParameter("busStatus", "initiation");
			query.setParameter("fromDate", fromDate);
			result = query.list();
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
	public List<BusStatusBean> getAllAvailTripByRouteId(int routeId, Date date) {
		String hql = "Select distinct bs FROM BusStatusBean bs INNER JOIN"
				+ " bs.trips trp INNER JOIN trp.routeDetails.route rte WHERE rte.id = :routeId "
				+ "AND bs.busStatus = :busStatus "
				+ "AND bs.fromDate >= :date AND bs.status = :status "
				+ "ORDER BY bs.fromDate";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("routeId", routeId);
			query.setParameter("busStatus", "ontrip");
			query.setParameter("date", date);
			query.setParameter("status", "active");
			result = query.list();
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
	public List<BusStatusBean> getAllTripsByRouteId(int routeId) {
		String hql = "Select distinct bs FROM BusStatusBean bs INNER JOIN bs.trips trp INNER JOIN "
				+ "trp.routeDetails.route rte WHERE rte.id = :routeId "
				+ "AND bs.busStatus = :busStatus " + "ORDER BY bs.fromDate";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("routeId", routeId);
			query.setParameter("busStatus", "ontrip");
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<BusStatusBean> getAllAvailTripByBusId(int busId, Date date) {
		String hql = "SELECT bs.id FROM BusStatusBean bs WHERE bs.bus.id = :busId "
				+ "AND bs.fromDate >= :date AND bs.status = :status AND bs.busStatus != :busStatus";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("busId", busId);
			query.setParameter("date", date);
			query.setParameter("status", "active");
			query.setParameter("busStatus", "initiation");
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

	/**
	 * Common database exception handling Get all bus status in the future by
	 * bus id
	 * 
	 * @param e
	 *            the occurred exception
	 * @throws HibernateException
	 *             the occurred exception
	 */

	@SuppressWarnings("unchecked")
	public List<BusStatusBean> getAllTripByBusId(int busId, Date date) {
		String hql = "SELECT bs.id FROM BusStatusBean bs WHERE bs.bus.id = :busId "
				+ "AND bs.toDate >= :date AND bs.status = :status";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("busId", busId);
			query.setParameter("date", date);
			query.setParameter("status", "active");
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

	/**
	 * Common database exception handling Get all max date to maintain
	 * 
	 * @param e
	 *            the occurred exception
	 * @throws HibernateException
	 *             the occurred exception
	 */
	@SuppressWarnings("unchecked")
	public List<Date> getMaintainFromDate(int busId) {
		String hql = "SELECT MAX(bs.toDate) FROM BusStatusBean bs WHERE bs.status = :status "
				+ "AND bs.bus.id = :busId";
		Session session = sessionFactory.getCurrentSession();
		List<Date> result = new ArrayList<Date>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("status", "active");
			query.setParameter("busId", busId);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

	/**
	 * Common database exception handling Get current station by toDate
	 * 
	 * @param e
	 *            the occurred exception
	 * @throws HibernateException
	 *             the occurred exception
	 */
	@SuppressWarnings("unchecked")
	public List<StationBean> getCurrentStation(Date toDate) {
		String hql = "SELECT bs.endStation FROM BusStatusBean bs WHERE bs.status = :status "
				+ "AND bs.toDate = :toDate";
		Session session = sessionFactory.getCurrentSession();
		List<StationBean> result = new ArrayList<StationBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("status", "active");
			query.setParameter("toDate", toDate);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

	/**
	 * Common database exception handling Get current station by toDate Get last
	 * station of bus
	 * 
	 * @param e
	 *            the occurred exception
	 * @throws HibernateException
	 *             the occurred exception
	 */
	@SuppressWarnings("unchecked")
	public List<Object[]> getLastStationByBusId(int busId) {
		String hql = "SELECT bs.endStation, MAX(bs.toDate) FROM BusStatusBean bs WHERE bs.status = :status "
				+ "AND bs.bus.id = :busId";
		Session session = sessionFactory.getCurrentSession();
		List<Object[]> result = new ArrayList<Object[]>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("status", "active");
			query.setParameter("busId", busId);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<BusStatusBean> getBusStatus(int routeId, int busId, Date date) {
		String hql = "FROM BusStatusBean bs WHERE bs.endStation.id = :busId "
				+ "AND bs.bus.id = :busId";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("status", "active");
			query.setParameter("busId", busId);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

	/**
	 * Common database exception handling Get exist busStatus(used by add new
	 * schedule)
	 * 
	 * @param e
	 *            the occurred exception
	 * @throws HibernateException
	 *             the occurred exception
	 */
	@SuppressWarnings("unchecked")
	public List<BusStatusBean> getDuplicatedBusAndDate(BusBean busBean,
			Date date, StationBean endStation) {
		String hql = "SELECT bs FROM BusStatusBean bs WHERE bs.bus = :busBean AND bs.fromDate = :date "
				+ "AND bs.endStation = :endStation "
				+ "AND bs.busStatus = :busStatus AND bs.status = :status";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("busBean", busBean);
			query.setParameter("date", date);
			query.setParameter("endStation", endStation);
			query.setParameter("busStatus", "ontrip");
			query.setParameter("status", "inactive");
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<BusStatusBean> getAllScheduledTripByRouteId(int routeId,
			Date fromDate) {
		String hql = "SELECT bs FROM BusStatusBean bs WHERE bs.status = :status "
				+ "AND bs.busStatus != :busStatus "
				+ "AND bs.fromDate >= :fromDate AND (bs.bus.forwardRoute.id = :routeId "
				+ "OR bs.bus.returnRoute.id = :routeId)";
		Session session = sessionFactory.getCurrentSession();
		List<BusStatusBean> result = new ArrayList<BusStatusBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setParameter("status", "active");
			query.setParameter("busStatus", "initiation");
			query.setParameter("fromDate", fromDate);
			query.setParameter("routeId", routeId);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<TicketBean> getTickets(int busStatusId) {
		List<TicketBean> result = null;
		Query query = null;
		String queryString = null;
		Session session = null;
		List<String> stati = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// perform database access (query, insert, update, etc) here
			queryString = "SELECT tkt FROM "
					+ "TicketBean tkt INNER JOIN tkt.trips trp INNER JOIN trp.busStatus bst INNER JOIN FETCH tkt.payments INNER JOIN FETCH tkt.reservation rsv WHERE bst.id = :busStatusId AND tkt.status IN (:statusTicketValidStati) AND rsv.status IN (:statusReservationValidStati)";
			query = session.createQuery(queryString);
			query.setInteger("busStatusId", busStatusId);
			stati = new ArrayList<String>();
			stati.add(TicketStatus.ACTIVE.getValue());
			stati.add(TicketStatus.PENDING.getValue());
			query.setParameterList("statusTicketValidStati", stati);
			stati = new ArrayList<String>();
			stati.add(ReservationStatus.PAID.getValue());
			stati.add(ReservationStatus.PENDING.getValue());
			query.setParameterList("statusReservationValidStati", stati);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}

	public void cancel(int busStatusId, String reason, int userId) {
		Query query = null;
		String queryString = null;
		Session session = null;
		List<String> stati = null;
		BusStatusChangeBean change = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// perform database access (query, insert, update, etc) here
			// set busStatus to 'cancelled'
			queryString = "UPDATE BusStatusBean bst SET bst.status = 'cancelled' WHERE bst.id = :busStatusId";
			query = session.createQuery(queryString);
			query.setInteger("busStatusId", busStatusId);
			query.executeUpdate();
			// set related tickets to 'cancelled'
			queryString = "UPDATE TicketBean tkt"
					+ " SET tkt.status = :cancelled"
					+ " WHERE tkt IN (SELECT tkts"
					+ " FROM BusStatusBean bst"
					+ " INNER JOIN bst.trips trp"
					+ " INNER JOIN trp.tickets tkts"
					+ " INNER JOIN tkts.reservation rsv"
					+ " WHERE bst.id = :busStatusId"
					+ " AND tkt.status IN (:tktStati)"
					+ " AND rsv.status IN (:rsvStati))";
			query = session.createQuery(queryString);
			query.setString("cancelled", TicketStatus.CANCELLED.getValue());
			query.setInteger("busStatusId", busStatusId);
			stati = new ArrayList<String>();
			stati.add(TicketStatus.ACTIVE.getValue());
			stati.add(TicketStatus.PENDING.getValue());
			query.setParameterList("tktStati", stati);
			stati = new ArrayList<String>();
			stati.add(ReservationStatus.PAID.getValue());
			stati.add(ReservationStatus.PENDING.getValue());
			query.setParameterList("rsvStati", stati);
			query.executeUpdate();
			// add status change record
			change = new BusStatusChangeBean();
			change.setBusStatus((BusStatusBean) session.get(
					BusStatusChangeTypeBean.class, busStatusId));
			change.setDate(new Date());
			change.setReason(reason);
			change.setType((BusStatusChangeTypeBean) session.get(
					BusStatusChangeTypeBean.class, 1));
			change.setUser((UserBean) session.get(UserBean.class, userId));
			session.save(change);
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
	}
}
