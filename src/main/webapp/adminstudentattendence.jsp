<%@page import="com.klef.ep.models.Admin"%>
<%@page import="com.klef.ep.models.Event"%>
<%@include file="adminnav.jsp" %>
<%@page import="com.klef.ep.models.RegisteredEvents"%>
<%@page import="java.util.List"%>
<%@page import="com.klef.ep.services.AdminService"%>
<%@page import="javax.naming.InitialContext"%>
<%
Admin admin = (Admin)session.getAttribute("admin");
if(admin==null){
	response.sendRedirect("unauthorizedaccess.html");
}
String eid = request.getParameter("id");
InitialContext context = new InitialContext();
AdminService service = (AdminService)context.lookup("java:global/EPProject/AdminServiceImpl!com.klef.ep.services.AdminService");
List<RegisteredEvents> eventslist = service.viewRegisteredStudents(eid);
Event event = service.vieweventbyID(eid);
%>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #eef2f7;
    margin: 0;
    padding: 0;
}
.styled-table {
    width: 90%;
    border-collapse: collapse;
    margin: 20px auto;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    overflow: hidden;
}

.styled-table th,
.styled-table td {
    padding: 15px 20px;
    text-align: center;
    border-bottom: 1px solid #e1e1e1;
}

.styled-table thead {
    background-color: #007bff;
    color: #fff;
    font-weight: bold;
}

.styled-table tbody tr {
    transition: background-color 0.3s, transform 0.3s;
}

.styled-table tbody tr:hover {
    background-color: #f2f2f2;
    transform: scale(1.02);
}

.styled-table tbody tr:nth-of-type(even) {
    background-color: #f9f9f9;
}

.styled-table tbody td input[type="checkbox"] {
    transform: scale(1.5);
    cursor: pointer;
}

.delete-link {
    color: red;
    text-decoration: none;
    transition: color 0.3s;
}

.delete-link:hover {
    color: darkred;
}
.search-bar {
    margin: 20px;
    text-align: center;
}
.search-bar input[type="text"] {
    padding: 10px;
    width: 300px;
    font-size: 1em;
    border: 1px solid #007bff;
    border-radius: 5px;
    outline: none;
}
.search-bar input[type="text"]:focus {
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
}

input[type="submit"] {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    font-size: 1em;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s, transform 0.3s;
}

input[type="submit"]:hover {
    background-color: #0056b3;
    transform: scale(1.05);
}

</style>
<script type="text/javascript" src="resources/js/tablesearch.js"></script>
<h3 align="center"><u>View Registered Students</u></h3>

<div align="center" class="search-bar">
    <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search for students.."/>
</div>
<form action="adminupdateeventsattendance.jsp" method="post">
    <input type="hidden" name="eid" value="<%= eid %>" />
    <table class="styled-table" id="dataTable" border="2">
        <thead>
            <tr>
                <th>Student ID</th>
                <th>Student Name</th>
                <th>
                Attendance(Do Not check if not attended)
                </th>
            </tr>
        </thead>
        <tbody>
            <%
            for (RegisteredEvents e : eventslist) {
            %>
                <tr>
                    <td><%= e.getStudentid() %></td>
                    <td><%= e.getStudentname() %></td>
                    <td>
                        <input type="checkbox" name="attendedStudents" value="<%= e.getStudentid() %>" <%= "ATTENDED".equals(e.getStatus()) ? "checked" : "" %> />
                    </td>
                </tr>
            <%
            }
            %>
        </tbody>
    </table>
    <div align="center">
        <input type="submit" value="Update Attendance" />
    </div>
</form>
