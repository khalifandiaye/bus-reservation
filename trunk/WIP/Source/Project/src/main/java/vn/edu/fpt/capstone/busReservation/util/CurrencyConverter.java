package vn.edu.fpt.capstone.busReservation.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLConnection;
import java.util.Calendar;
import java.util.Collections;
import java.util.Currency;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class CurrencyConverter {
    private static class CurrencyPair {
        private final Currency fromCurrency;
        private final Currency toCurrency;

        public CurrencyPair(Currency fromCurrency, Currency toCurrency)
                throws InstantiationException {
            if (fromCurrency == null || toCurrency == null) {
                throw new InstantiationException(
                        "Neither sourceCurrency nor targetCurrency can be null!");
            }
            this.fromCurrency = fromCurrency;
            this.toCurrency = toCurrency;
        }

        /*
         * (non-Javadoc)
         * 
         * @see java.lang.Object#equals(java.lang.Object)
         */
        @Override
        public boolean equals(Object obj) {
            if (this == obj)
                return true;
            if (obj == null)
                return false;
            if (getClass() != obj.getClass())
                return false;
            CurrencyPair other = (CurrencyPair) obj;
            if (fromCurrency != other.fromCurrency)
                return false;
            if (toCurrency != other.toCurrency)
                return false;
            return true;
        }

        /*
         * (non-Javadoc)
         * 
         * @see java.lang.Object#hashCode()
         */
        @Override
        public int hashCode() {
            final int prime = 31;
            int result = 1;
            result = prime * result
                    + ((fromCurrency == null) ? 0 : fromCurrency.hashCode());
            result = prime * result
                    + ((toCurrency == null) ? 0 : toCurrency.hashCode());
            return result;
        }

        public CurrencyPair reverse() throws InstantiationException {
            return new CurrencyPair(toCurrency, fromCurrency);
        }
    }

    private static Map<CurrencyPair, CurrencyConverter> converterMap = Collections
            .synchronizedMap(new HashMap<CurrencyPair, CurrencyConverter>());

    private static Log log = LogFactory.getLog(CurrencyConverter.class);
    private static final String ERROR = "error:";
    private static final String NO_ERROR_FOUND = "\"\"";
    private static final String REG_EXP = "-?\\d+(.\\d+)?";
    private final static int REFRESH_INTERVAL_IN_HOURS = 24;

    private static String extract(String str) {
        StringBuffer sBuffer = new StringBuffer();
        Pattern p = Pattern.compile(REG_EXP);
        Matcher m = p.matcher(str);
        if (m.find()) {
            sBuffer.append(m.group());
        }
        return sBuffer.toString();
    }

    /**
     * If error is found within the response string, throw runtime exception to
     * report, else parse the result for extraction
     **/
    private static String extractConvertedValue(String convertedResult) {
        String[] convertedResStrings = convertedResult.split(",");
        for (int i = 0; i < convertedResStrings.length; i++) {
            if ((convertedResStrings[i].contains(ERROR))
                    && convertedResStrings[i].split(" ")[1]
                            .equals(NO_ERROR_FOUND)) {
                String convertedValue = extract(convertedResStrings[i - 1]);
                if (!(convertedValue.isEmpty())) {
                    return convertedValue;
                }
            } else if ((convertedResStrings[i].contains(ERROR))
                    && !convertedResStrings[i].split(" ")[1]
                            .equals(NO_ERROR_FOUND)) {
                throw new RuntimeException(
                        "Error occured while converting amount: "
                                + convertedResStrings[i].split(" ")[1]);
            }
        }
        return null;
    }

    private static BigDecimal getConversionRate(CurrencyPair currencyPair)
            throws IOException {
        String code = String.valueOf("/ig/calculator?h1=en&q=" + "1000" + ""
                + currencyPair.fromCurrency.getCurrencyCode() + "=?"
                + currencyPair.toCurrency.getCurrencyCode());
        URL converterUrl = new URL("http://www.google.com" + code);
        URLConnection urlConnection = converterUrl.openConnection();

        InputStream inputStream = urlConnection.getInputStream();
        BufferedReader bufferedReader = new BufferedReader(
                new InputStreamReader(inputStream));

        String conversionResult = bufferedReader.readLine();
        bufferedReader.close();
        inputStream.close();
        urlConnection = null;

        log.info("GoogleAPI return: " + conversionResult);

        return new BigDecimal(extractConvertedValue(conversionResult)).divide(
                BigDecimal.valueOf(1000), 10, BigDecimal.ROUND_HALF_UP);
    }

    /**
     * Get a converter from <tt>fromCurrency</tt> to <tt>toCurrency</tt>.<br>
     * If such converter exists and hasn't expired, it will be reused.
     * Otherwise, a call to google api will be made to create another converter.
     * <p>
     * A converter will expire after a certain amount of hours, specified by
     * <tt>REFRESH_INTERVAL_IN_HOURS</tt>
     * 
     * @param fromCurrency
     *            the currency to convert from
     * @param toCurrency
     *            the currency to convert to
     * @return a currency converter instance
     * @throws InstantiationException
     *             if either <tt>fromCurrency</tt> or <tt>toCurrency</tt> is
     *             null
     * @throws IOException
     *             if the call to google api fails
     */
    public static CurrencyConverter getInstance(Currency fromCurrency,
            Currency toCurrency) throws InstantiationException, IOException {
        CurrencyConverter converter = null;
        CurrencyPair currencyPair = null;
        Calendar expireDate = null;
        BigDecimal conversionRate = null;
        currencyPair = new CurrencyPair(fromCurrency, toCurrency);
        // converter expire after X hours
        expireDate = Calendar.getInstance();
        expireDate.add(Calendar.HOUR, -REFRESH_INTERVAL_IN_HOURS);
        converter = converterMap.get(currencyPair);
        if (converter == null
                || converter.initDate.before(expireDate.getTime())) {
            conversionRate = getConversionRate(currencyPair);
            converter = new CurrencyConverter(conversionRate);
            log.debug("A new CurrencyConverter instance has been created. initDate="
                    + converter.initDate
                    + "; fromCurrency="
                    + currencyPair.fromCurrency.getCurrencyCode()
                    + "; toCurrency="
                    + currencyPair.toCurrency.getCurrencyCode()
                    + "; conversionRate=" + conversionRate.toString());
            converterMap.put(currencyPair, converter);
            conversionRate = BigDecimal.ONE.divide(conversionRate, 10,
                    BigDecimal.ROUND_HALF_UP);
            converterMap.put(currencyPair.reverse(), new CurrencyConverter(
                    conversionRate));
            log.debug("The inversal CurrencyConverter instance has been created. initDate="
                    + converter.initDate
                    + "; conversionRate="
                    + conversionRate.toString());
        }
        return converter;
    }

    private final BigDecimal conversionRate;

    private final Date initDate;

    private CurrencyConverter(BigDecimal conversionRate) {
        initDate = new Date();
        this.conversionRate = conversionRate;
    }

    /**
     * Convert the specified amount from <tt>fromCurrency</tt> to
     * <tt>toCurrency</tt>
     * <p>
     * Please note that calling this method will not check if this converter has
     * expired or not.
     * 
     * @param amount
     *            the amount to convert
     * @return the converted amount
     */
    public Double convert(Double amount) {
        return amount != null ? BigDecimal.valueOf(amount)
                .multiply(conversionRate).doubleValue() : null;
    }

    /**
     * Convert the specified amount from <tt>fromCurrency</tt> to
     * <tt>toCurrency</tt>
     * <p>
     * Please note that calling this method will not check if this converter has
     * expired or not.
     * 
     * @param amount
     *            the amount to convert
     * @return the converted amount
     */
    public BigDecimal convert(BigDecimal amount) {
        return amount != null ? amount.multiply(conversionRate) : null;
    }

    /**
     * @return true if this converter instance should be renewed
     */
    public boolean isExpired() {
        Calendar expireDate = null;
        // converter expire after X hours
        expireDate = Calendar.getInstance();
        expireDate.add(Calendar.HOUR, -REFRESH_INTERVAL_IN_HOURS);
        return initDate.before(expireDate.getTime());
    }
}
