<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>view Information</title>
<style>
table {
border-collapse: collapse;
width: 50%;
margin: auto;
}
th, td {
border: 1px solid black;
padding: 8px;
text-align: left;
}
th {
  background-color: #09ef59;
}

    body {
        font-family: Arial, sans-serif;
    }
    h2 {
        text-align: center;
    }
    table {
        background-color: #ffffff;
        border-collapse: collapse;
        width: 80%; /* Adjusted width */
        margin: 20px auto; /* Added margin for better centering */
    }
    th, td {
        border: 1px solid #ddd; /* Changed border color */
        padding: 10px; /* Increased padding for better spacing */
        text-align: left;
    }
    th {
      background-color: #09ef59;
    }
</style>
</head>
<body>
<h2>View Information</h2>
<table>
<tr>
<th>User id</th>
<th>User name</th>
<th>phone</th>
<th>Email</th>
<th>Password</th>
</tr>
<%
try {
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login","root", "SHREYASRAO123");
PreparedStatement ps = con.prepareStatement("SELECT * FROM user_details");
ResultSet rs = ps.executeQuery();
while(rs.next()) {
String u_id= rs.getString("u_id");
String u_name = rs.getString("u_name");
String phone=rs.getString("phone");
String email = rs.getString("email");
String password = rs.getString("password");
%>
<tr>
<td><%= u_id %></td>
<td><%= u_name %></td>
<td><%= phone %></td>
<td><%= email %></td>
<td><%= password %></td>
</tr>
<%
}
rs.close();
ps.close();
con.close();
} catch(Exception e) {
out.println("Error: " + e.getMessage());
}
%>
</table>
</body>
</html>