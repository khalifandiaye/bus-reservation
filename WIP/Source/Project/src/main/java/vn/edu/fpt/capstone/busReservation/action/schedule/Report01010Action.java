/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.schedule;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.RouteTicketList;
import vn.edu.fpt.capstone.busReservation.logic.ScheduleLogic;

/**
 * @author Yoshimi
 * 
 */
public class Report01010Action extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    // ==========================Logic Object==========================
    private ScheduleLogic scheduleLogic;

    /**
     * @param scheduleLogic
     *            the scheduleLogic to set
     */
    public void setScheduleLogic(ScheduleLogic scheduleLogic) {
        this.scheduleLogic = scheduleLogic;
    }

    // ==========================Action Input==========================
    private String busStatusId;

    /**
     * @param busStatusId
     *            the busStatusId to set
     */
    public void setBusStatusId(String busStatusId) {
        this.busStatusId = busStatusId;
    }

    // ==========================Action Output=========================
    private RouteTicketList model;

    /**
     * @return the model
     */
    public RouteTicketList getModel() {
        return model;
    }

    @Override
    public String execute() {
        model = scheduleLogic.getTicketList(Integer.parseInt(busStatusId));
        return SUCCESS;
    }

}
