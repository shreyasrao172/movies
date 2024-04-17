<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Information</title>
</head>
<style>
    body {
        font-family: Arial, sans-serif;
    }
    h1 {
        text-align: center;
    }
    form {
        width: 50%; /* Adjusted form width */
        margin: 0 auto; /* Centering the form */
        padding: 20px; /* Added padding for better spacing */
        border: 1px solid #ccc; /* Added border for visual separation */
        border-radius: 5px; /* Rounded corners for form */
    }
    input[type="text"],
    input[type="email"],
    input[type="password"],
    input[type="phone"],
    input[type="submit"] {
        width: 100%; /* Full width input fields */
        margin-bottom: 10px; /* Added margin between input fields */
        padding: 10px; /* Added padding for better spacing */
        box-sizing: border-box; /* Include padding and border in element's total width and height */
    }
    input[type="submit"] {
        background-color: #4CAF50; /* Green submit button */
        color: white;
        border: none;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #45a049; /* Darker green on hover */
    }
</style>
<body>
<h1>Edit Information</h1>
<form method="post">
<!-- Change method to POST -->
<label for="u_id">Enter Your UserID : </label> 
<input type="text"name="u_id"><br /><br/>
<input type="submit" value="Submit"><br /><br/>
</form>
<%
// Check if an ID parameter is provided
String u_idParam = request.getParameter("u_id");
if (u_idParam != null) {
// If ID parameter is provided, retrieve student details from the database and populate the form
try {
// Establish database connection
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login","root", "SHREYASRAO123");
PreparedStatement ps = con.prepareStatement("SELECT * FROM user_details WHERE u_id= ?");
ps.setInt(1, Integer.parseInt(u_idParam));
ResultSet rs = ps.executeQuery();
// Check if student exists
if (rs.next()) {
// Populate form fields with existing data
String u_id = rs.getString("u_id");
String u_name = rs.getString("u_name");
String email = rs.getString("email");
String phone = rs.getString("phone");
String password = rs.getString("password");
%>
<form method="post">
<!-- Change method to POST -->
<input type="hidden" name="u_id" value="<%= u_id %>">
<div>
UserId:
<%=u_id %><br><input type="text" name="u_name"value="<%= u_name %>" placeholder="Enter Your UserName"><br>
<input type="email" name="email" value="<%= email %>"placeholder="Enter Your EmailID"><br>
<input type="password" name="password"value="<%= password %>"placeholder="Enter Your Password"><br>
<input type="phone" name="phone"value="<%= phone %>"placeholder="Enter Your phone"><br>
<input type="submit" name="action" value="Update">
<input type="submit" name="action" value="Delete">
</div>
</form>
<%
} 
else 
{
out.println("User not found");
}
// Close resources
rs.close();
ps.close();
con.close();
} 
	catch(Exception e) 
{
out.println("Error: " + e.getMessage());
e.printStackTrace();
}
} 
	else {
out.println("User ID not provided");
}
	if ("POST".equalsIgnoreCase(request.getMethod())) {
// Form submitted via POST method
String action = request.getParameter("action");
	if ("Update".equals(action)) 	{
	String u_name = request.getParameter("u_name");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String password = request.getParameter("password");
	if (u_name != null && !u_name.isEmpty()) {
// Update database only if username is not null or empty
	try {
// Establish database connection
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login","root", "SHREYASRAO123");
PreparedStatement ps = con.prepareStatement("UPDATE user_details SET u_name=?,email=?,phone=?,password=? WHERE u_id=?");

ps.setString(1, u_name);
ps.setString(2, email);
ps.setString(3, phone);
ps.setString(4, password);
ps.setInt(5, Integer.parseInt(u_idParam));
int rowsAffected = ps.executeUpdate();
// Check if update was successful
if (rowsAffected > 0) 
{
			out.println("Data updated successfully.");
} 
else {
out.println("Failed to update data.");
}
// Close resources
ps.close();
con.close();
} catch(Exception e) {
out.println("Error: " + e.getMessage());
e.printStackTrace();
}
} else {
out.println("Username cannot be empty.");
}
} else if ("Delete".equals(action)) {
// Delete record
try {
// Establish database connection
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login","root", "SHREYASRAO123");
PreparedStatement ps = con.prepareStatement("DELETE FROM user_details WHERE u_id=?");
ps.setInt(1, Integer.parseInt(u_idParam));
int rowsAffected = ps.executeUpdate();
// Check if deletion was successful
if (rowsAffected > 0) {
out.println("Record deleted successfully.");
} else {
out.println("Failed to delete record.");
}
// Close resources
ps.close();
con.close();
} catch(Exception e) {
out.println("Error: " + e.getMessage());
e.printStackTrace();
}
}
}
%>
</body>
</html>