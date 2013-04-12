/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 * 
 */
public class TripDAOTest extends DAOTest {

    @Test
    public void testGetAll001() {
        TripDAO tripDAO = (TripDAO) getBean("tripDAO");
        List<TripBean> trips = tripDAO.getAll();
        assertNotNull(trips);
    }

    // @Test
    // public void testUpdate001() {
    // TripDAO tripDAO = (TripDAO) getBean("tripDAO");
    // List<TripBean> trips = null;
    // BusStatusDAO busStatusDAO = (BusStatusDAO) getBean("busStatusDAO");
    // List<BusStatusBean> busStatusList = busStatusDAO.getAll();
    // List<Date> dates = null;
    // Iterator<Date> iterator = null;
    // for (BusStatusBean busStatus : busStatusList) {
    // trips = busStatus.getTrips();
    // dates = new ArrayList<Date>();
    // for (TripBean trip : trips) {
    // dates.add(trip.getDepartureTime());
    // dates.add(trip.getArrivalTime());
    // }
    // Collections.sort(dates);
    // Collections.sort(trips, new Comparator<TripBean>() {
    //
    // @Override
    // public int compare(TripBean o1, TripBean o2) {
    // // TODO Auto-generated method stub
    // return
    // o1.getRouteDetails().getId().compareTo(o2.getRouteDetails().getId());
    // }
    // });
    // iterator = dates.iterator();
    // for (TripBean trip : trips) {
    // trip.setDepartureTime(iterator.next());
    // trip.setArrivalTime(iterator.next());
    // }
    // tripDAO.update(trips);
    // }
    // }

    // @Test
    // public void testUpdate002() {
    // TripDAO tripDAO = (TripDAO) getBean("tripDAO");
    // List<TripBean> trips = tripDAO.getAll();
    // Calendar calendar = Calendar.getInstance();
    // long travelTime = 0;
    // BusStatusBean lastBusStatus = null;
    // calendar.add(Calendar.DATE, 12);
    // for (TripBean tripBean : trips) {
    // if (lastBusStatus != null ||
    // !tripBean.getBusStatus().equals(lastBusStatus)) {
    // lastBusStatus = tripBean.getBusStatus();
    // // forward time
    // calendar.add(Calendar.HOUR, 48);
    // }
    // tripBean.setDepartureTime(calendar.getTime());
    // travelTime =
    // DateUtils.getAbsoluteMiliseconds(tripBean.getRouteDetails().getSegment().getTravelTime());
    // calendar.setTimeInMillis(calendar.getTimeInMillis() + travelTime);
    // tripBean.setArrivalTime(calendar.getTime());
    // }
    // tripDAO.update(trips);
    // }

    @Test
    public void testInsert001() {
        TripDAO tripDAO = (TripDAO) getBean("tripDAO");
        BusStatusDAO busStatusDAO = (BusStatusDAO) getBean("busStatusDAO");
        RouteDAO routeDAO = (RouteDAO) getBean("routeDAO");
        RouteBean forwardRoute = routeDAO.getById(1);
        RouteBean returnRoute = routeDAO.getById(2);
        BusDAO busDAO = (BusDAO) getBean("busDAO");
        BusBean bus = busDAO.getById(10);
        List<TripBean> tripBeans = null;
        TripBean tripBean = null;
        BusStatusBean busStatusBean = null;
        Calendar calendar = Calendar.getInstance();
        long travelTimeTotal = 0;
        Random random = new Random();
        calendar.add(Calendar.HOUR, random.nextInt(11));
        for (int i = 0; i < 20; i++) {
            // insert trip for forward route
            travelTimeTotal = 0;
            tripBeans = new ArrayList<TripBean>();
            busStatusBean = new BusStatusBean();
            for (RouteDetailsBean routeDetails : forwardRoute.getRouteDetails()) {
                tripBean = new TripBean();
                tripBean.setRouteDetails(routeDetails);
                tripBean.setDepartureTime(new Date(calendar.getTimeInMillis()
                        + travelTimeTotal));
                travelTimeTotal += routeDetails.getSegment()
                        .getSegmentTravelTimes().get(0).getTravelTime();
                tripBean.setArrivalTime(new Date(calendar.getTimeInMillis()
                        + travelTimeTotal));
                tripBean.setBusStatus(busStatusBean);
                tripBeans.add(tripBean);
            }
            busStatusBean.setBus(bus);
            busStatusBean.setBusStatus("ontrip");
            busStatusBean.setFromDate(tripBeans.get(0).getDepartureTime());
            busStatusBean.setToDate(tripBeans.get(tripBeans.size() - 1)
                    .getArrivalTime());
            busStatusBean.setEndStation(tripBeans.get(tripBeans.size() - 1)
                    .getRouteDetails().getSegment().getEndAt());
            busStatusBean.setStatus("active");
            busStatusDAO.insert(busStatusBean);
            tripDAO.insert(tripBeans);
            // forward time
            calendar.setTimeInMillis(calendar.getTimeInMillis() + travelTimeTotal);
            calendar.add(Calendar.HOUR, 24);
            // insert trip for return route
            travelTimeTotal = 0;
            tripBeans = new ArrayList<TripBean>();
            busStatusBean = new BusStatusBean();
            for (RouteDetailsBean routeDetails : returnRoute.getRouteDetails()) {
                tripBean = new TripBean();
                tripBean.setRouteDetails(routeDetails);
                tripBean.setDepartureTime(new Date(calendar.getTimeInMillis()
                        + travelTimeTotal));
                travelTimeTotal += routeDetails.getSegment()
                        .getSegmentTravelTimes().get(0).getTravelTime();
                tripBean.setArrivalTime(new Date(calendar.getTimeInMillis()
                        + travelTimeTotal));
                tripBean.setBusStatus(busStatusBean);
                tripBeans.add(tripBean);
            }
            busStatusBean.setBus(bus);
            busStatusBean.setBusStatus("ontrip");
            busStatusBean.setFromDate(tripBeans.get(0).getDepartureTime());
            busStatusBean.setToDate(tripBeans.get(tripBeans.size() - 1)
                    .getArrivalTime());
            busStatusBean.setEndStation(tripBeans.get(tripBeans.size() - 1)
                    .getRouteDetails().getSegment().getEndAt());
            busStatusBean.setStatus("active");
            busStatusDAO.insert(busStatusBean);
            tripDAO.insert(tripBeans);
            // forward time
            calendar.setTimeInMillis(calendar.getTimeInMillis() + travelTimeTotal);
            calendar.add(Calendar.HOUR, 24);
        }
    }
}
