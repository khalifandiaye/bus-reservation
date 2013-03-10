<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Start admin nav -->
<section class="admin-nav"> 
    <ul class="nav nav-pills">
	  <li>
	    <a href="<%=request.getContextPath()%>/bus/list.html">Bus List</a>
	  </li>
	  <li>
  		<a href="<%=request.getContextPath()%>/route/list.html">Route List</a>
	  </li>
	  <li>
	  	<a href="<%=request.getContextPath()%>/schedule/list.html">Schedule List</a>	
	  </li>
	</ul>
</section>
<!-- End admin nav -->