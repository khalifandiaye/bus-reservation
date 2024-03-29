/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

/**
 * @author Yoshimi
 * 
 */
public class ClearSessionAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    @Action(results = { @Result(name = SUCCESS, type = "chain", params = {
            "namespace", "/", "actionName", "index" }) })
    public String execute() {
        session.clear();
        return SUCCESS;
    }

}
