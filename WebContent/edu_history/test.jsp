<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript"	src="http://code.jquery.com/jquery-latest.js"></script>

<!-- table sorter -->
<script type="text/javascript" src="../js/jquery.tablesorter/jquery.tablesorter.min.js"></script>
<!-- option -->
<link rel="stylesheet" href="../js/jquery.tablesorter/themes/blue/style.css" type="text/css">

<script type="text/javascript">
	aa = '';
	$(function() {
		setTimeout("window.self.focus();", 1000);

		$('#dd').focus(function() {
			aa = $(this).val();
		}).change(function() {
			$('#dd').trigger("blur");
			$('#test').append("before value : " + aa + "<br>");
		});
	});
	$(document).ready(function() 
		    { 
		        $("#myTable").tablesorter(); 
		    } 
		); 
		    
	
</script>
<body>
	<select id='dd'>
		<option value=1>1</option>
		<option value=2>2</option>
		<option value=3>3</option>
	</select>



	<div id='test'></div>
	<table id="menu">
		<tr>
			<td>
				<table id="myTable" class="tablesorter"> 
					<thead> 
					<tr> 
					    <th>Last Name</th> 
					    <th>First Name</th> 
					    <th>Email</th> 
					    <th>Due</th> 
					    <th>Web Site</th> 
					</tr> 
					</thead> 
					<tbody> 
					<tr> 
					    <td>Smith</td> 
					    <td>John</td> 
					    <td>jsmith@gmail.com</td> 
					    <td>$50.00</td> 
					    <td>http://www.jsmith.com</td> 
					</tr> 
					<tr> 
					    <td>Bach</td> 
					    <td>Frank</td> 
					    <td>fbach@yahoo.com</td> 
					    <td>$50.00</td> 
					    <td>http://www.frank.com</td> 
					</tr> 
					<tr> 
					    <td>Doe</td> 
					    <td>Jason</td> 
					    <td>jdoe@hotmail.com</td> 
					    <td>$100.00</td> 
					    <td>http://www.jdoe.com</td> 
					</tr> 
					<tr> 
					    <td>Conway</td> 
					    <td>Tim</td> 
					    <td>tconway@earthlink.net</td> 
					    <td>$50.00</td> 
					    <td>http://www.timconway.com</td> 
					</tr> 
					</tbody>
				</table> 
			</td>
		</tr>
	</table>
</body>

