/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.admin;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.SettingModel;
import vn.edu.fpt.capstone.busReservation.logic.SystemLogic;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @author Yoshimi
 *
 */
public class SettingsAction extends BaseAction implements ModelDriven<SettingModel> {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    // ==========================Logic Object==========================
    private SystemLogic systemLogic;
    /**
     * @param systemLogic the systemLogic to set
     */
    public void setSystemLogic(SystemLogic systemLogic) {
        this.systemLogic = systemLogic;
    }

    // ==========================Action Model==========================
    private SettingModel model;

    /* (non-Javadoc)
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    @Override
    public SettingModel getModel() {
        return model;
    }

    /**
     * @param model the model to set
     */
    public void setModel(SettingModel model) {
        this.model = model;
    }
    
    public String execute() {
        if (model != null && model.isUpdateSettings()) {
            // update settings
            systemLogic.setConfiguration(model);
        }
        // reload settings
        systemLogic.getConfiguration(model);
        return SUCCESS;
    }

}
