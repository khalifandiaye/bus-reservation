/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;

/**
 * @author Yoshimi
 * 
 */
public class SegmentDAO extends GenericDAO<Integer, SegmentBean> {

   public SegmentDAO(Class<SegmentBean> clazz) {
      super(clazz);
   }

   public String getTravelTime(int id) {
      String strQuery = "SELECT CAST( sec_to_time(time_to_sec(s.travel_time)) "
            + "AS CHAR CHARACTER SET utf8 ) "
            + "FROM segment s WHERE s.id = :id";
      Session session = sessionFactory.getCurrentSession();
      String result = "";
      try {
         // must have to start any transaction
         Query query = session.createSQLQuery(strQuery);
         query.setParameter("id", id);
         result = (String) query.list().get(0);
      } catch (HibernateException e) {
         exceptionHandling(e, session);
      }

      return result;
   }

   @SuppressWarnings("unchecked")
public List<SegmentBean> getSegmentInRouteTerminal(int routeId,
         int startAtId, int endAtId) {
      String hql = "select sir.segment from RouteDetailsBean sir where sir.route.id = :routeId "
            + "and sir.segment.startAt.id = :startAtId "
            + "and sir.segment.endAt.id = :endAtId";
      Session session = sessionFactory.getCurrentSession();
      List<SegmentBean> result = new ArrayList<SegmentBean>();
      try {
         // must have to start any transaction
         Query query = session.createQuery(hql);
         query.setParameter("routeId", routeId)
               .setParameter("startAtId", startAtId)
               .setParameter("endAtId", endAtId);
         result = query.list();
      } catch (HibernateException e) {
         exceptionHandling(e, session);
      }

      return result;
   }
}
