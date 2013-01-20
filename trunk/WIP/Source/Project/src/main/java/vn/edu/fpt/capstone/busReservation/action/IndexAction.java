package vn.edu.fpt.capstone.busReservation.action;

import org.apache.struts2.convention.annotation.ParentPackage;

import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("pay")
public class IndexAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5962554617409673584L;
	
	public String execute() throws Exception {
        return SUCCESS;
    }

}
