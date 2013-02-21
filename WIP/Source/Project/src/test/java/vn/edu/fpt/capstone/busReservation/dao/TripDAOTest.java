/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 *
 */
public class TripDAOTest extends DAOTest {

//    @Test
//    public void testUpdate001() {
//        TripDAO tripDAO = (TripDAO) getBean("tripDAO");
//        List<TripBean> beans = tripDAO.getAll();
//        BusStatusDAO busStatusDAO = (BusStatusDAO) getBean("busStatusDAO");
//        List<BusStatusBean> beans2 = busStatusDAO.getAll();
//        Assert.assertNotNull(beans);
//        Assert.assertNotEquals(0, beans.size());
//        Assert.assertNotNull(beans.get(0));
//        Calendar bookTime = Calendar.getInstance();
//        long shiftMilisecs = 0;
//        bookTime.setTimeInMillis(0);
//        bookTime.add(Calendar.DATE, 12);
//        shiftMilisecs = bookTime.getTimeInMillis();
//        for (TripBean tripBean : beans) {
//                tripBean.setDepartureTime(new Date(tripBean.getDepartureTime().getTime() + shiftMilisecs));
//                tripBean.setArrivalTime(new Date(tripBean.getArrivalTime().getTime() + shiftMilisecs));
//        }
//        for (BusStatusBean busStatusBean : beans2) {
//            busStatusBean.setFromDate(new Date(busStatusBean.getFromDate().getTime() + shiftMilisecs));
//            busStatusBean.setToDate(new Date(busStatusBean.getToDate().getTime() + shiftMilisecs));
//    }
//        tripDAO.update(beans);
//        busStatusDAO.update(beans2);
//    }
//    @Test
//    public void testInsert001() {
//        TripDAO tripDAO = (TripDAO) getBean("tripDAO");
//        BusStatusDAO busStatusDAO = (BusStatusDAO) getBean("busStatusDAO");
//        RouteDAO routeDAO = (RouteDAO) getBean("routeDAO");
//        RouteBean forwardRoute = routeDAO.getById(1);
//        RouteBean returnRoute = routeDAO.getById(2);
//        BusDAO busDAO = (BusDAO) getBean("busDAO");
//        BusBean bus = busDAO.getById(3);
//        List<TripBean> tripBeans = null;
//        TripBean tripBean = null;
//        BusStatusBean busStatusBean = null;
//        Calendar calendar = Calendar.getInstance();
//        long travelTimeTotal = 0;
//        calendar.add(Calendar.DATE, 14);
//        for (int i = 0; i < 5; i++) {
//            // insert trip for forward route
//            travelTimeTotal = 0;
//            tripBeans = new ArrayList<TripBean>();
//            busStatusBean = new BusStatusBean();
//            for (RouteDetailsBean routeDetails : forwardRoute.getRouteDetails()) {
//                tripBean = new TripBean();
//                tripBean.setRouteDetails(routeDetails);
//                tripBean.setStatus("active");
//                tripBean.setDepartureTime(new Date(calendar.getTime().getTime() + travelTimeTotal));
//                travelTimeTotal += routeDetails.getSegment().getTravelTime().getTime();
//                tripBean.setArrivalTime(new Date(calendar.getTime().getTime()  + travelTimeTotal));
//                tripBean.setBusStatus(busStatusBean);
//                tripBeans.add(tripBean);
//            }
//            busStatusBean.setBus(bus);
//            busStatusBean.setBusStatus("ontrip");
//            busStatusBean.setFromDate(tripBeans.get(0).getDepartureTime());
//            busStatusBean.setToDate(tripBeans.get(tripBeans.size() - 1).getArrivalTime());
//            busStatusBean.setEndStation(tripBeans.get(tripBeans.size() - 1).getRouteDetails().getSegment().getEndAt());
//            busStatusBean.setStatus("active");
//            busStatusDAO.insert(busStatusBean);
//            tripDAO.insert(tripBeans);
//            // forward time
//            calendar.add(Calendar.HOUR, 48);
//            // insert trip for return route
//            travelTimeTotal = 0;
//            tripBeans = new ArrayList<TripBean>();
//            busStatusBean = new BusStatusBean();
//            for (RouteDetailsBean routeDetails : returnRoute.getRouteDetails()) {
//                tripBean = new TripBean();
//                tripBean.setRouteDetails(routeDetails);
//                tripBean.setStatus("active");
//                tripBean.setDepartureTime(new Date(calendar.getTime().getTime() + travelTimeTotal));
//                travelTimeTotal += routeDetails.getSegment().getTravelTime().getTime();
//                tripBean.setArrivalTime(new Date(calendar.getTime().getTime()  + travelTimeTotal));
//                tripBean.setBusStatus(busStatusBean);
//                tripBeans.add(tripBean);
//            }
//            busStatusBean.setBus(bus);
//            busStatusBean.setBusStatus("ontrip");
//            busStatusBean.setFromDate(tripBeans.get(0).getDepartureTime());
//            busStatusBean.setToDate(tripBeans.get(tripBeans.size() - 1).getArrivalTime());
//            busStatusBean.setEndStation(tripBeans.get(tripBeans.size() - 1).getRouteDetails().getSegment().getEndAt());
//            busStatusBean.setStatus("active");
//            busStatusDAO.insert(busStatusBean);
//            tripDAO.insert(tripBeans);
//            // forward time
//            calendar.add(Calendar.HOUR, 48);
//        }
//    }
}
