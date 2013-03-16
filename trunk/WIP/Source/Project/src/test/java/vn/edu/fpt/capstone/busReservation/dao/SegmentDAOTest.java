/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.text.ParseException;

import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;
import vn.edu.fpt.capstone.busReservation.util.DateUtils;

/**
 * @author Yoshimi
 * 
 */
public class SegmentDAOTest extends DAOTest {
    @Test
    public void testInsert001() throws ParseException {
        SegmentDAO segmentDAO = (SegmentDAO) getBean("segmentDAO");
        StationDAO stationDAO = (StationDAO) getBean("stationDAO");
        SegmentBean segmentBean = new SegmentBean();
        segmentBean.setStartAt(stationDAO.getById(3));
        segmentBean.setEndAt(stationDAO.getById(8));
        segmentBean.setTravelTime(DateUtils.getTime(27, 0, 0));
        segmentDAO.insert(segmentBean);
    }
}
