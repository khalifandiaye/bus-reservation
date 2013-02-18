package vn.edu.fpt.capstone.busReservation.util;

import java.math.BigDecimal;
import java.util.Currency;

import org.junit.Assert;
import org.junit.Test;

public class CurrencyConverterTest {
    @Test
    public void test001() throws Exception {
        CurrencyConverter util = null;
        BigDecimal result = null;
        util = CurrencyConverter.getInstance(Currency.getInstance("VND"),
                Currency.getInstance("USD"));
        result = util.convert(BigDecimal.valueOf(10000));
        Assert.assertNotNull(result);
    }
}
