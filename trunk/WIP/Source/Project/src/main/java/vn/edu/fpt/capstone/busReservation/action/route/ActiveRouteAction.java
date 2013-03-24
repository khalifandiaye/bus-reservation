package vn.edu.fpt.capstone.busReservation.action.route;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.RouteDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteBean;

@ParentPackage("jsonPackage")
public class ActiveRouteAction extends BaseAction {

   private static final long serialVersionUID = -1900533216154623510L;

   private RouteDAO routeDAO;

   private int routeId;

   private String message;

   @Action(value = "/activeRoute", results = { @Result(type = "json", name = SUCCESS) })
   public String execute(){
      try {
         List<Integer> routeTerminals = routeDAO.getRouteTerminal(routeId);
         // delete route and its return
         RouteBean routeBeanForward = routeDAO.getById(routeTerminals.get(0));
         RouteBean routeBeanReturn = routeDAO.getById(routeTerminals.get(1));
         routeBeanForward.setStatus("active");
         routeBeanReturn.setStatus("active");
         routeDAO.update(routeBeanForward);
         routeDAO.update(routeBeanReturn);

         message = "Route " + routeBeanForward.getName() + " and route "
               + routeBeanReturn.getName() + " are active successfully!";
      } catch (Exception ex) {
         message = "Active route failed! Please contact admin!";
      }
      return SUCCESS;
   }

   public void setRouteDAO(RouteDAO routeDAO) {
      this.routeDAO = routeDAO;
   }

   public void setRouteId(int routeId) {
      this.routeId = routeId;
   }

   public String getMessage() {
      return message;
   }

}
