/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import vn.edu.fpt.capstone.busReservation.dao.bean.MailTemplateBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;

/**
 * @author Yoshimi
 *
 */
public class MailTemplateDAO extends GenericDAO<Integer, MailTemplateBean> {

    public MailTemplateDAO(Class<MailTemplateBean> clazz) {
        super(clazz);
    }
    
    @SuppressWarnings("unchecked")
    public MailTemplateBean getByName(String name){
        List<MailTemplateBean> result = null;
        Query query = null;
        String queryString = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            queryString = "FROM MailTemplateBean mt WHERE mt.name = :name";
            query = session.createQuery(queryString);
            query.setString("name", name);
            result = query.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result != null && result.size() > 0 ? result.get(0) : null;
    }

}
