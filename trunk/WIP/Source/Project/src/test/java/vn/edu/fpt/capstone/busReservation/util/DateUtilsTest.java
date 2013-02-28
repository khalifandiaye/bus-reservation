package vn.edu.fpt.capstone.busReservation.util;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class DateUtilsTest {
    @Test
    public void test001() {
        assertEquals(99 * 60 * 60 * 1000,
                DateUtils.getAbsoluteMiliseconds(DateUtils.getTime(99, 0, 0)));
//        Calendar c = Calendar.getInstance();
//        c.clear();
//        assertEquals(c.getTimeInMillis(), TimeZone.getDefault().getOffset(0));
    }
}
