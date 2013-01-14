package vn.edu.fpt.capstone.busReservation.logic;

import vn.edu.fpt.capstone.busReservation.dao.HelloWorldDAO;

/**
 * Implementation of HelloWorldLogic
 * @author Yoshimi
 *
 */
public class HelloWorldLogicImpl implements HelloWorldLogic {
	/**
	 * DAO to perform database accessing<br>
	 * Must have setter
	 */
	private HelloWorldDAO helloWorldDAO;

	/**
	 * @param helloWorldDAO the helloWorldDAO to set
	 */
	public void setHelloWorldDAO(HelloWorldDAO helloWorldDAO) {
		this.helloWorldDAO = helloWorldDAO;
	}

	public String processName(String name) {
		// Access database (if needed)
		helloWorldDAO.doNothing();
		return name.trim();
	}

}
