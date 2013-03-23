<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<title>VinaBus - Test Google Maps API</title>
	<jsp:include page="../common/xheader.jsp" />
	<link href="<%=request.getContextPath()%>/styles/gmap.css" rel="stylesheet">
    <script type="text/javascript"
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBwRnLXPkJ6gSAug6fUJst2Nomn1fLnlAI&sensor=false&region=VN&language=vi">
    </script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/markerwithlabel_packed.js">
    </script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/customGMap.js">
    </script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/debug/dev01010.js">
    </script>
  </head>
  <body>
	<jsp:include page="../common/header.jsp" />
	<div>
		<div class="container clearfix">
   			<div class="search">
    			<div class="well">
    			<select id="location">
				  <option value="21.0409;105.7981">Ha Noi</option>
				  <option value="10.7500;106.6667">Ho Chi Minh</option>
				  <option value="11.9417;108.4383">Da Lat</option>
				  <option value="12.2500;109.1833">Nha Trang</option>
				  <option value="16.0667;108.2333">Da Nang</option>
				  <option value="16.4711;107.5858">Hue</option>
				  <option value="18.6667;105.6667">Vinh</option>
				  <option value="20.8500;106.6833">Hai Phong</option>
				  <option value="10.3500;107.0667">Vung Tau</option>
				  <option value="10.0333;105.7833">Can Tho</option>
				</select>
				<button id="add">Add</button>
				<button id="clear">Clear</button>
				</div>
   			</div>
   			<div class="slider">
    			<div id="map" class="map-container"></div>
   			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
  </body>
</html>