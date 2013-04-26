/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.logic;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import vn.edu.fpt.capstone.busReservation.dao.SystemSettingDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.SystemSettingBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SettingModel;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;

/**
 * @author Yoshimi
 * 
 */
public class SystemLogic extends BaseLogic {
    private SystemSettingDAO systemSettingDAO;

    /**
     * @param systemSettingDAO
     *            the systemSettingDAO to set
     */
    @Autowired
    public void setSystemSettingDAO(SystemSettingDAO systemSettingDAO) {
        this.systemSettingDAO = systemSettingDAO;
    }

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    public void setConfiguration(SettingModel model) {
        SystemSettingBean setting = null;
        if (model != null) {
            if (CheckUtils.isNullOrBlank(model.getSegment().getDefaultPrice())) {
                setting = new SystemSettingBean();
                setting.setId("segment.default.price");
                setting.setValue(model.getSegment().getDefaultPrice());
                systemSettingDAO.update(setting);
            }
            if (CheckUtils.isNullOrBlank(model.getSegment().getMaxCount())) {
                setting = new SystemSettingBean();
                setting.setId("maximum.segment.in.route");
                setting.setValue(model.getSegment().getMaxCount());
                systemSettingDAO.update(setting);
            }
            if (CheckUtils.isNullOrBlank(model.getSegment().getRest())) {
                setting = new SystemSettingBean();
                setting.setId("station.delay");
                setting.setValue(model.getSegment().getRest());
                systemSettingDAO.update(setting);
            }
            if (CheckUtils.isNullOrBlank(model.getSegment()
                    .getDefaultTravelTime().getHour())
                    && CheckUtils.isNullOrBlank(model.getSegment()
                            .getDefaultTravelTime().getMinute())) {
                setting = new SystemSettingBean();
                setting.setId("minimum.segment.traveltime");
                setting.setValue(Long.toString(Long.parseLong(model
                        .getSegment().getDefaultTravelTime().getHour())
                        * 60
                        * 60
                        * 1000
                        + Long.parseLong(model.getSegment()
                                .getDefaultTravelTime().getMinute())
                        * 60
                        * 1000));
                systemSettingDAO.update(setting);
            }
            if (CheckUtils.isNullOrBlank(model.getReservation().getMaxSeat())) {
                setting = new SystemSettingBean();
                setting.setId("reservation.maxSeat");
                setting.setValue(model.getReservation().getMaxSeat());
                systemSettingDAO.update(setting);
            }
            if (CheckUtils.isNullOrBlank(model.getReservation().getTimeout())) {
                setting = new SystemSettingBean();
                setting.setId("reservation.timeout");
                setting.setValue(model.getReservation().getTimeout());
                systemSettingDAO.update(setting);
            }
            if (CheckUtils.isNullOrBlank(model.getReservation()
                    .getRefundRate1())) {
                setting = new SystemSettingBean();
                setting.setId("refund.1.rate");
                setting.setValue(model.getReservation().getRefundRate1());
                systemSettingDAO.update(setting);
            }
            if (CheckUtils.isNullOrBlank(model.getReservation()
                    .getRefundRate2())) {
                setting = new SystemSettingBean();
                setting.setId("refund.2.rate");
                setting.setValue(model.getReservation().getRefundRate2());
                systemSettingDAO.update(setting);
            }
            if (CheckUtils.isNullOrBlank(model.getReservation()
                    .getRefundTime1())) {
                setting = new SystemSettingBean();
                setting.setId("refund.1.time");
                setting.setValue(model.getReservation().getRefundTime1());
                systemSettingDAO.update(setting);
            }
            if (CheckUtils.isNullOrBlank(model.getReservation()
                    .getRefundTime2())) {
                setting = new SystemSettingBean();
                setting.setId("refund.2.time");
                setting.setValue(model.getReservation().getRefundTime2());
                systemSettingDAO.update(setting);
            }
            if (CheckUtils.isNullOrBlank(model.getDiscount().getFullRoute())) {
                setting = new SystemSettingBean();
                setting.setId("discount.fullRoute");
                setting.setValue(model.getDiscount().getFullRoute());
                systemSettingDAO.update(setting);
            }
        }
    }

    public void getConfiguration(SettingModel model) {
        List<SystemSettingBean> beans = null;
        long time = 0;
        String id = null;
        String value = null;
        beans = systemSettingDAO.getAll();
        if (beans != null) {
            for (SystemSettingBean bean : beans) {
                id = bean.getId();
                value = bean.getValue();
                if ("maximum.segment.in.route".equalsIgnoreCase(id)) {
                    model.getSegment().setMaxCount(value);
                } else if ("minimum.segment.traveltime".equalsIgnoreCase(bean
                        .getId())) {
                    time = Long.parseLong(value);
                    model.getSegment().getDefaultTravelTime()
                            .setMinute(Long.toString(time / 1000 / 60 % 60));
                    model.getSegment().getDefaultTravelTime()
                            .setHour(Long.toString(time / 1000 / 60 / 60));
                } else if ("segment.default.price".equalsIgnoreCase(id)) {
                    model.getSegment().setDefaultPrice(value);
                } else if ("station.delay".equalsIgnoreCase(id)) {
                    model.getSegment().setRest(value);
                } else if ("refund.1.rate".equalsIgnoreCase(id)) {
                    model.getReservation().setRefundRate1(value);
                } else if ("refund.1.time".equalsIgnoreCase(id)) {
                    model.getReservation().setRefundTime1(value);
                } else if ("refund.2.rate".equalsIgnoreCase(id)) {
                    model.getReservation().setRefundRate2(value);
                } else if ("refund.2.time".equalsIgnoreCase(id)) {
                    model.getReservation().setRefundTime2(value);
                } else if ("reservation.maxSeat".equalsIgnoreCase(id)) {
                    model.getReservation().setMaxSeat(value);
                } else if ("reservation.timeout".equalsIgnoreCase(id)) {
                    model.getReservation().setTimeout(value);
                } else if ("discount.fullRoute".equalsIgnoreCase(id)) {
                    model.getDiscount().setFullRoute(value);
                }
            }
        }
    }

}
