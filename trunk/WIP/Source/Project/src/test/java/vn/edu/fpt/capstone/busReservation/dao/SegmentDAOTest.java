/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import static org.junit.Assert.*;

import java.text.ParseException;
import java.util.List;

import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.SegmentBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

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
        segmentDAO.insert(segmentBean);
    }

    @Test
    public void testGetAll001() throws ParseException {
        SegmentDAO segmentDAO = (SegmentDAO) getBean("segmentDAO");
        List<SegmentBean> beans = segmentDAO.getAll();
        assertNotNull(beans);
        assertNotEquals(0, beans.size());
    }
}
