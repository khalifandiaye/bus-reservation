/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketInfoBean;

/**
 * @author Yoshimi
 * 
 */
public class TicketDAO extends GenericDAO<Integer, TicketBean> {

    // private static final ResultTransformer TICKET_INFO_TRANSFORMER = new
    // ResultTransformer() {
    //
    // /**
    // *
    // */
    // private static final long serialVersionUID = 1L;
    //
    // @Override
    // public Object transformTuple(Object[] tuple, String[] aliases) {
    // TicketInfoBean info = new TicketInfoBean();
    // int size = aliases.length;
    // for (int i = 0; i < size; i++) {
    // if ("ticket".equalsIgnoreCase(aliases[i])) {
    // info.setId((TicketBean) tuple[i]);
    // } else if ("startTrip".equalsIgnoreCase(aliases[i])) {
    // info.setStartTrip((TripBean) tuple[i]);
    // } else if ("endTrip".equalsIgnoreCase(aliases[i])) {
    // info.setEndTrip((TripBean) tuple[i]);
    // } else if ("ticketPrice".equalsIgnoreCase(aliases[i])) {
    // info.setTicketPrice((Double) tuple[i]);
    // }
    // }
    // return info;
    // }
    //
    // @SuppressWarnings("rawtypes")
    // @Override
    // public List transformList(List collection) {
    // return collection;
    // }
    // };

    public TicketDAO(Class<TicketBean> clazz) {
        super(clazz);
        // TODO Auto-generated constructor stub
    }

    @SuppressWarnings("unchecked")
    public List<TicketInfoBean> getInfoByUsername(String username) {
        List<TicketInfoBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "SELECT new vn.edu.fpt.capstone.busReservation.dao.bean.TicketInfoBean(tkt, trps, trpe, SUM(tar.fare))"
                    + " FROM TicketBean tkt"
                    + "     INNER JOIN tkt.trips trps"
                    + "     INNER JOIN tkt.trips trpe"
                    + "     INNER JOIN tkt.trips trp"
                    + "     INNER JOIN trp.routeDetails.segment.tariffs tar"
                    + " WHERE tkt.reservation.booker.username = :username"
                    + " AND tar.busType = trp.busStatus.bus.busType"
                    + " AND tar.validFrom = (SELECT MAX(tar1.validFrom)"
                    + "     FROM TariffBean tar1"
                    + "     WHERE tar1.validFrom <= tkt.reservation.bookTime"
                    + "     AND tar1.segment = trp.routeDetails.segment"
                    + "     AND tar1.busType = trp.busStatus.bus.busType)"
                    + " AND trps.departureTime = (SELECT MIN(trp1.departureTime)"
                    + "     FROM TicketBean tkt1 INNER JOIN tkt1.trips trp1"
                    + "     WHERE tkt1 = tkt)"
                    + " AND trpe.departureTime = (SELECT MAX(trp2.departureTime)"
                    + "     FROM TicketBean tkt2 INNER JOIN tkt2.trips trp2"
                    + "     WHERE tkt2 = tkt)" + " GROUP BY tkt, trps, trpe";
            query = session.createQuery(queryString);
            query.setString("username", username);
            // query.setResultTransformer(TICKET_INFO_TRANSFORMER);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

	@SuppressWarnings("unchecked")
	public List<TicketBean> getTicketByBusStatusId(int busStatusId) {
		String hql = "SELECT tr.tickets FROM TripBean tr " +
				"LEFT JOIN tr.tickets " +
				"WHERE tr.busStatus.id = :busStatusId ";
		Session session = sessionFactory.getCurrentSession();
		List<TicketBean> result = new ArrayList<TicketBean>();
		try {
			// must have to start any transaction
			Query query = session.createQuery(hql);
			query.setInteger("busStatusId", busStatusId);
			result = query.list();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}
		return result;
	}
    
}
