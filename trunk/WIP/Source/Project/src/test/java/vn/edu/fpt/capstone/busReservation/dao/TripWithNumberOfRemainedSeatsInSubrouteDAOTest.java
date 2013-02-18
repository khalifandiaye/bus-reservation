package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.TripWithNumberOfRemainedSeatsInSubrouteBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

public class TripWithNumberOfRemainedSeatsInSubrouteDAOTest extends DAOTest {
    @Test
    public void testGetAvailableTrips001() {
        TripWithNumberOfRemainedSeatsInSubrouteDAO dao = (TripWithNumberOfRemainedSeatsInSubrouteDAO) getBean("tripWithNumberOfRemainedSeatsInSubrouteDAO");
        List<TripWithNumberOfRemainedSeatsInSubrouteBean> result = null;
        result = dao.getAvailableTrips(8, 54, 40);
        Assert.assertNotNull(result);
        Assert.assertEquals(2, result.size());
    }
}
