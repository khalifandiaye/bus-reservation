/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

/**
 * @author Yoshimi
 * 
 */
public class SettingModel implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    public class Segment implements Serializable {
        /**
         * 
         */
        private static final long serialVersionUID = 1L;

        public class Time implements Serializable {
            /**
             * 
             */
            private static final long serialVersionUID = 1L;
            private String hour;
            private String minute;

            /**
             * 
             */
            private Time() {
                super();
            }

            /**
             * @return the hour
             */
            public String getHour() {
                return hour;
            }

            /**
             * @param hour
             *            the hour to set
             */
            public void setHour(String hour) {
                this.hour = hour;
            }

            /**
             * @return the minute
             */
            public String getMinute() {
                return minute;
            }

            /**
             * @param minute
             *            the minute to set
             */
            public void setMinute(String minute) {
                this.minute = minute;
            }
        }

        private String maxCount;
        private final Time defaultTravelTime;
        private String defaultPrice;
        private String rest;

        /**
         * 
         */
        private Segment() {
            super();
            defaultTravelTime = new Time();
        }

        /**
         * @return the maxCount
         */
        public String getMaxCount() {
            return maxCount;
        }

        /**
         * @param maxCount
         *            the maxCount to set
         */
        public void setMaxCount(String maxCount) {
            this.maxCount = maxCount;
        }

        /**
         * @return the defaultTravelTime
         */
        public Time getDefaultTravelTime() {
            return defaultTravelTime;
        }

        /**
         * @return the defaultPrice
         */
        public String getDefaultPrice() {
            return defaultPrice;
        }

        /**
         * @param defaultPrice
         *            the defaultPrice to set
         */
        public void setDefaultPrice(String defaultPrice) {
            this.defaultPrice = defaultPrice;
        }

        /**
         * @return the rest
         */
        public String getRest() {
            return rest;
        }

        /**
         * @param rest
         *            the rest to set
         */
        public void setRest(String rest) {
            this.rest = rest;
        }

    }

    public class Reservation implements Serializable {
        /**
         * 
         */
        private static final long serialVersionUID = 1L;
        private String maxSeat;
        private String timeout;
        private String refundTime1;
        private String refundRate1;
        private String refundTime2;
        private String refundRate2;

        /**
         * 
         */
        private Reservation() {
            super();
        }

        /**
         * @return the maxSeat
         */
        public String getMaxSeat() {
            return maxSeat;
        }

        /**
         * @param maxSeat
         *            the maxSeat to set
         */
        public void setMaxSeat(String maxSeat) {
            this.maxSeat = maxSeat;
        }

        /**
         * @return the timeout
         */
        public String getTimeout() {
            return timeout;
        }

        /**
         * @param timeout
         *            the timeout to set
         */
        public void setTimeout(String timeout) {
            this.timeout = timeout;
        }

        /**
         * @return the refundTime1
         */
        public String getRefundTime1() {
            return refundTime1;
        }

        /**
         * @param refundTime1
         *            the refundTime1 to set
         */
        public void setRefundTime1(String refundTime1) {
            this.refundTime1 = refundTime1;
        }

        /**
         * @return the refundRate1
         */
        public String getRefundRate1() {
            return refundRate1;
        }

        /**
         * @param refundRate1
         *            the refundRate1 to set
         */
        public void setRefundRate1(String refundRate1) {
            this.refundRate1 = refundRate1;
        }

        /**
         * @return the refundTime2
         */
        public String getRefundTime2() {
            return refundTime2;
        }

        /**
         * @param refundTime2
         *            the refundTime2 to set
         */
        public void setRefundTime2(String refundTime2) {
            this.refundTime2 = refundTime2;
        }

        /**
         * @return the refundRate2
         */
        public String getRefundRate2() {
            return refundRate2;
        }

        /**
         * @param refundRate2
         *            the refundRate2 to set
         */
        public void setRefundRate2(String refundRate2) {
            this.refundRate2 = refundRate2;
        }
    }

    public class Discount implements Serializable {
        /**
         * 
         */
        private static final long serialVersionUID = 1L;
        private String fullRoute;

        /**
         * 
         */
        private Discount() {
        }

        /**
         * @return the fullRoute
         */
        public String getFullRoute() {
            return fullRoute;
        }

        /**
         * @param fullRoute
         *            the fullRoute to set
         */
        public void setFullRoute(String fullRoute) {
            this.fullRoute = fullRoute;
        }
    }

    private boolean updateSettings;
    private final Segment segment;
    private final Reservation reservation;
    private final Discount discount;

    /**
     * 
     */
    public SettingModel() {
        super();
        segment = new Segment();
        reservation = new Reservation();
        discount = new Discount();
    }

    /**
     * @return the updateSettings
     */
    public boolean isUpdateSettings() {
        return updateSettings;
    }

    /**
     * @param updateSettings
     *            the updateSettings to set
     */
    public void setUpdateSettings(boolean updateSettings) {
        this.updateSettings = updateSettings;
    }

    /**
     * @return the segment
     */
    public Segment getSegment() {
        return segment;
    }

    /**
     * @return the reservation
     */
    public Reservation getReservation() {
        return reservation;
    }

    /**
     * @return the discount
     */
    public Discount getDiscount() {
        return discount;
    }
}
