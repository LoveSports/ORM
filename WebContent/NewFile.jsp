<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" language="javascript" src="js/jquery-2.1.3.js"></script> 
<script type="text/javascript"> 
$().ready(function(){ 
//$(".delete").confirmer(); 
$(".delete").confirmer({msg:'Sure?'}); 
}) 
</script> 
</head> 
<body> 
<button id="btnDelete" class="delete">Delete</button> 
<a id="lnkDelete" class="delete" href="http://www.baidu.com">Delete</a> 
</body>
</html>