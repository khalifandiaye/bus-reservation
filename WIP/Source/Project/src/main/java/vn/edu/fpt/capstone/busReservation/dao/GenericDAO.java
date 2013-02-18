/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import vn.edu.fpt.capstone.busReservation.dao.bean.AbstractBean;

/**
 * @author Yoshimi
 * 
 */
public class GenericDAO<K extends Serializable, T extends AbstractBean<K>> {

    protected final Class<T> clazz;
    private static Log log = LogFactory.getLog(GenericDAO.class);
    /**
     * The session factory, mainly for getting current session
     */
    protected SessionFactory sessionFactory;

    public GenericDAO(Class<T> clazz) {
        this.clazz = clazz;
    }

    /**
     * @param sessionFactory
     *            the sessionFactory to set
     */
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    /**
     * Common database exception handling
     * 
     * @param e
     *            the occurred exception
     * @param session
     *            the active session
     * @throws HibernateException
     *             the occurred exception
     */
    protected void exceptionHandling(HibernateException e, Session session) {
        try {
            if (session.getTransaction().isActive()) {
                log.debug("Trying to rollback database transaction after exception");
                session.getTransaction().rollback();
            }
        } catch (Throwable rbEx) {
            log.error("Could not rollback transaction after exception!", rbEx);
        }
        throw e;
    }

    /**
     * @return all entities in the database
     * @throws HibernateException
     *             Indicates a problem either translating the criteria to SQL,
     *             executing the SQL or processing the SQL results.
     */
    @SuppressWarnings("unchecked")
    public List<T> getAll() throws HibernateException {
        List<T> list = null;
        Session session = null;
        Criteria criteria = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            criteria = session.createCriteria(clazz);
            list = criteria.list();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return list;
    }

    /**
     * Return the persistent instance of the given entity class with the given
     * identifier, or null if there is no such persistent instance. (If the
     * instance is already associated with the session, return that instance.
     * This method never returns an uninitialized instance.)
     * 
     * @param id
     *            an identifier
     * @return a persistent instance or null
     * @throws HibernateException
     *             Indicates a problem either translating the criteria to SQL,
     *             executing the SQL or processing the SQL results.
     */
    @SuppressWarnings("unchecked")
    public T getById(K id) {
        T result = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            try {
                if (id.getClass().getName().startsWith(
                        this.getClass().getPackage().getName())) {
                    result = clazz.newInstance();
                    result.setId(id);
                    result = (T) session.get(clazz, result);
                } else {
                    result = (T) session.get(clazz, id);
                }
            } catch (InstantiationException e) {
                result = (T) session.get(clazz, id);
            } catch (IllegalAccessException e) {
                result = (T) session.get(clazz, id);
            }
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

    /**
     * Return the persistent instance of the given entity class with the given
     * identifier, assuming that the instance exists. This method might return a
     * proxied instance that is initialized on-demand, when a non-identifier
     * method is accessed.
     * <p>
     * 
     * You should not use this method to determine if an instance exists (use
     * get() instead). Use this only to retrieve an instance that you assume
     * exists, where non-existence would be an actual error.
     * 
     * @param id
     *            an identifier
     * @return a persistent instance or null
     * @throws HibernateException
     *             Indicates a problem either translating the criteria to SQL,
     *             executing the SQL or processing the SQL results.
     */
    @SuppressWarnings("unchecked")
    public T loadById(K id) {
        T result = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            try {
                T t = clazz.newInstance();
                t.setId(id);
            } catch (InstantiationException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            result = (T) session.load(clazz, id);
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        // return result, if needed
        return result;
    }

    /**
     * Insert new entity into the database.<br>
     * 
     * @param t
     *            entity to be inserted
     * @return the generated identifier
     * @throws HibernateException
     *             Indicates a problem either translating the criteria to SQL,
     *             executing the SQL or processing the SQL results.
     */
    public Serializable insert(T t) {
        Serializable result = null;
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            result = session.save(t);
            session.flush();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
        return result;
    }

    /**
     * Insert a list of new entities into the database.<br>
     * 
     * @param tList
     *            list of entities to be inserted
     * @throws HibernateException
     *             Indicates a problem either translating the criteria to SQL,
     *             executing the SQL or processing the SQL results.
     */
    public void insert(List<T> tList) {
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            for (T t : tList) {
                session.save(t);
            }
            session.flush();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
    }

    /**
     * Update an existing entity in the database.<br>
     * 
     * @param t
     *            entity to be updated
     * @throws HibernateException
     *             Indicates a problem either translating the criteria to SQL,
     *             executing the SQL or processing the SQL results.
     */
    public void update(T t) {
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            session.update(t);
            session.flush();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
    }

    /**
     * Update a list of existing entities in the database.<br>
     * If any entity in the list does not exist in the database
     * 
     * @param tList
     *            list of entities to be updated
     * @throws HibernateException
     *             Indicates a problem either translating the criteria to SQL,
     *             executing the SQL or processing the SQL results.
     */
    public void update(List<T> tList) {
        Session session = null;
        // get the current session
        session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            for (T t : tList) {
                session.update(t);
            }
            session.flush();
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
    }

    // public void initialize(Object proxy) throws HibernateException {
    // Session session = null;
    // // get the current session
    // session = sessionFactory.getCurrentSession();
    // try {
    // session.beginTransaction();
    // // perform database access (query, insert, update, etc) here
    // Hibernate.initialize(proxy);
    // } catch (HibernateException e) {
    // exceptionHandling(e, session);
    // }
    // }

    public void startTransaction() {
        if (!sessionFactory.getCurrentSession().getTransaction().isActive()
                || sessionFactory.getCurrentSession().getTransaction()
                        .wasCommitted()) {
            log.debug("Starting a database transaction");
            sessionFactory.getCurrentSession().beginTransaction();
        } else {
            log.debug("A transaction is in progress");
        }
    }

    public void endTransaction() {
        log.debug("Committing the database transaction");
        if (sessionFactory.getCurrentSession().getTransaction().isActive()
                && !sessionFactory.getCurrentSession().getTransaction()
                        .wasCommitted()) {
            sessionFactory.getCurrentSession().getTransaction().commit();
        } else {
            log.debug("The database transaction has been comnitted somewhere else");
        }
    }

}
