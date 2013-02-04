/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

/**
 * @author Yoshimi
 *
 */
public class PaymentMethodBean extends AbstractBean<Integer> {
    /**
     * 
     */
    private static final long serialVersionUID = -1985196911431206617L;
    private String name;
    private double ratio;
    private double addition;
    /**
     * @return the name
     */
    public String getName() {
        return name;
    }
    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }
    /**
     * @return the ratio
     */
    public double getRatio() {
        return ratio;
    }
    /**
     * @param ratio the ratio to set
     */
    public void setRatio(double ratio) {
        this.ratio = ratio;
    }
    /**
     * @return the addition
     */
    public double getAddition() {
        return addition;
    }
    /**
     * @param addition the addition to set
     */
    public void setAddition(double addition) {
        this.addition = addition;
    }
}
