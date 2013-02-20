package vn.edu.fpt.capstone.busReservation.dao.bean;

public class RouteTerminalBean extends AbstractBean<RouteBean> {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private StationBean startTerminal;
    private StationBean endTerminal;
    private StationBean endTerminalAlternative;
    /**
     * @return the startTerminal
     */
    public StationBean getStartTerminal() {
        return startTerminal;
    }
    /**
     * @param startTerminal the startTerminal to set
     */
    public void setStartTerminal(StationBean startTerminal) {
        this.startTerminal = startTerminal;
    }
    /**
     * @return the endTerminal
     */
    public StationBean getEndTerminal() {
        return endTerminal;
    }
    /**
     * @param endTerminal the endTerminal to set
     */
    public void setEndTerminal(StationBean endTerminal) {
        this.endTerminal = endTerminal;
    }
    /**
     * @return the endTerminalAlternative
     */
    public StationBean getEndTerminalAlternative() {
        return endTerminalAlternative;
    }
    /**
     * @param endTerminalAlternative the endTerminalAlternative to set
     */
    public void setEndTerminalAlternative(StationBean endTerminalAlternative) {
        this.endTerminalAlternative = endTerminalAlternative;
    }
}
