package vn.edu.fpt.capstone.busReservation.dao;


public class HelloWorldDAOImpl implements HelloWorldDAO {
//	private static Log log = LogFactory.getLog(HelloWorldDAOImpl.class);
	/**
	 * The session factory, mainly for getting current session
	 */
//	private SessionFactory sessionFactory;

	/**
	 * @param sessionFactory the sessionFactory to set
	 */
//	public void setSessionFactory(SessionFactory sessionFactory) {
//		this.sessionFactory = sessionFactory;
//	}

	public void doNothing() {
		/*Session session = null;
		// get the current session
		session = sessionFactory.getCurrentSession();
		try {
			// must have to start any transaction
			session.beginTransaction();
			// perform database access (query, insert, update, etc) here
			// commit transaction
			session.getTransaction().commit();
		} catch (HibernateException e) {
			exceptionHandling(e, session);
		}*/
		// return result, if needed
	}

	/**
	 * Common exception handling
	 * 
	 * @param e
	 *            the occurred exception
	 * @param session
	 *            the active session
	 */
//	private void exceptionHandling(HibernateException e, Session session) {
//		try {
//			if (session.getTransaction().isActive()) {
//				log.debug("Trying to rollback database transaction after exception");
//				session.getTransaction().rollback();
//			}
//		} catch (Throwable rbEx) {
//			log.error("Could not rollback transaction after exception!", rbEx);
//		}
//		throw e;
//	}

}
