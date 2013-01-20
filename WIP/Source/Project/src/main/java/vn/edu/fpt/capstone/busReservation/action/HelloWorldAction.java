package vn.edu.fpt.capstone.busReservation.action;

import org.springframework.beans.factory.annotation.Autowired;

import vn.edu.fpt.capstone.busReservation.logic.HelloWorldLogic;

import com.opensymphony.xwork2.ActionSupport;

public class HelloWorldAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5962554617409673584L;
	/**
	 * Business logics executor.<br>
	 * Must have setter
	 */
	private HelloWorldLogic helloWorldLogic;
	/**
	 * in and out parameter(s)<br>
	 * Must have setter (in) and getter (out)
	 */
	private String name;

	/**
	 * This method will be executed when the action is called
	 * 
	 * @return the execution status (success, error, input, etc)
	 */
	public String execute() throws Exception {
		// call logic object method
		name = helloWorldLogic.processName(name);
		return SUCCESS;
	}

	/**
	 * @param helloWorldLogic
	 *            the helloWorldLogic to set
	 */
	@Autowired
	public void setHelloWorldLogic(HelloWorldLogic helloWorldLogic) {
		this.helloWorldLogic = helloWorldLogic;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

}
