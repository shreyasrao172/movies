<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
</head>
<style>
<style>
.container {
  margin-bottom: 15px;
}

label {
  font-weight: bold;
}

input[type="text"],
input[type="password"],
input[type="email"] {
  width: 100%;
  padding: 10px;
  margin: 5px 0;
  border: 1px solid #ccc;
  border-radius: 4px;
}

input[type="submit"] {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type="submit"]:hover {
  background-color: #45a049;
}
</style>
<body>
<h1>Enter your Details</h1>
<form>

<div class="container">
<label for="Userid"><b>Enter Your User id :</b></label><br/>
<input type="text" required name="Userid">
</div>
<div>
<label for="Username"><b>Enter Your Name :</b> </label><br/>
<input type="text" name="Username">
</div>
<div>
<label for="email"><b>Enter Your Email :</b> </label><br/>
<input type="email" name="email">
</div>
<div>
<label for="phone"><b>Enter Your Phone :</b> </label><br/>
<input type="text" name="phone">
</div>
<div>
<label for="password"><b>Enter Your Password :</b> </label><br/>
<input type="password" name="password">
</div>
<br/>
<input type="submit" value="Submit">
<form/>
<%
String Userid=request.getParameter("Userid");
String Username=request.getParameter("Username");
String email=request.getParameter("email");
String phone=request.getParameter("phone");
String password=request.getParameter("password");
String message="hiuii";
	if(Userid != null && Username!=null && email!=null&&phone!=null &&password!=null)
	{
		try	
	{
			Class.forName("com.mysql.cj.jdbc.Driver");
			//Connection
			Connection
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/login","root", "SHREYASRAO123");
			PreparedStatement ps=con.prepareStatement("INSERT INTO user_details(u_id,u_name,email,phone,password)VALUES(?,?,?,?,?)");
	
			ps.setInt(1,Integer.parseInt(Userid));
			ps.setString(2,Username);
			ps.setString(3,email);
			ps.setString(4,phone);
			ps.setString(5,password);
			int i=ps.executeUpdate();
		if(i>0)
		{
			message="Registered";
		}
		else
		{
			message="Not Registered";
		}
}
		catch(Exception e)//super class this is present in java.lang package
		//because it is a default package
		{
			message="Error";
			e.printStackTrace();
		}
}
		else
		{
			message="Please Enter The Data";
			System.out.println(message);
		}
%>
</body>
</html>