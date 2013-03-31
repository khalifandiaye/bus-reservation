package vn.edu.fpt.capstone.busReservation.action.schedule.secured;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.ScheduleLogic;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

@ParentPackage("jsonPackage")
public class DeleteScheduleAction extends BaseAction {

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
    private String id;
    private String reason;

    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * @param reason the reason to set
     */
    public void setReason(String reason) {
        this.reason = reason;
    }

    // ==========================Action Output=========================
    private boolean success;
    private String[] messages;

    /**
     * @return the success
     */
    public boolean isSuccess() {
        return success;
    }

    /**
     * @return the messages
     */
    public String[] getMessages() {
        return messages;
    }

    @Action(value = "/confirmDelete", results = { @Result(type = "json", name = SUCCESS, params = {
            "callbackParameter", "callback" }) })
    public String confirmDelete() {
        Object user = null;
        int userId = 0;
        if (session != null
                && session.containsKey(CommonConstant.SESSION_KEY_USER)) {
            user = session.get(CommonConstant.SESSION_KEY_USER);
            if (User.class.isAssignableFrom(user.getClass())) {
                userId = ((User) user).getUserId();
            } else {
                // wrong object on session
                session.remove(CommonConstant.SESSION_KEY_USER);
            }
        } else {
            // wrong object on session
            session.remove(CommonConstant.SESSION_KEY_USER);
        }
        try {
            scheduleLogic.getDeleteInfo(Integer.parseInt(id), userId);
        } catch (CommonException e) {
            errorProcessing(e);
            messages = new String[getActionErrors().size()];
            getActionErrors().toArray(messages);
        }
        success = true;
        return SUCCESS;
    }

    @Action(value = "/executeDelete", results = { @Result(type = "json", name = SUCCESS, params = {
            "callbackParameter", "callback" }) })
    public String executeDelete() {
        Object user = null;
        int userId = 0;
        if (session != null
                && session.containsKey(CommonConstant.SESSION_KEY_USER)) {
            user = session.get(CommonConstant.SESSION_KEY_USER);
            if (User.class.isAssignableFrom(user.getClass())) {
                userId = ((User) user).getUserId();
            } else {
                // wrong object on session
                session.remove(CommonConstant.SESSION_KEY_USER);
            }
        } else {
            // wrong object on session
            session.remove(CommonConstant.SESSION_KEY_USER);
        }
        try {
            scheduleLogic.deleteBusStatus(Integer.parseInt(id), reason, userId);
        } catch (CommonException e) {
            errorProcessing(e);
            messages = new String[getActionErrors().size()];
            getActionErrors().toArray(messages);
        }
        success = true;
        return SUCCESS;
    }

}
