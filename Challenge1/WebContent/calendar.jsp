<%@ page import="com.devdaily.calendar.Month,java.io.*,java.sql.*,com.devdaily.*" errorPage="error.jsp" %>
<%@ page import="java.util.*" %>
<%-- TODO: CLEAN UP THE PAGE TAG ABOVE --%>

<%@ include file="calendarCommon.jsp" %>

<% 
try {
/*here mysqltest is the database name. you have to give the database name you have created and 3306 is the default sql port */
String connectionURL = "jdbc:mysql://localhost:8080/Postal Codes"; 

Connection connection = null; 

Class.forName("com.mysql.cj.jdbc.Driver").newInstance(); 

/* "root" and "root" are the mysql username and password . if you have a different user name and password you have to change that in code */

connection = DriverManager.getConnection(connectionURL, "root", "root");

if(!connection.isClosed())
%>
<% 
out.println("Successfully connected to " + "MySQL server using TCP/IP...");
connection.close();
}
catch(Exception ex){
%>
<%
out.println("Unable to connect to database.");
}
%>

<html>
<head>
  <title>devdaily.com calendar</title>
  <link rel="StyleSheet" href="/blog/calendar.css" type="text/css" media="screen" />
</head>

<body id="regular_page">

<div id="calendar_main_div">
<table border="1" cellspacing="0" cellpadding="4" id="calendar_table">
  <tr>
    <td width="100%" colspan="7" class="month_year_header">
      <%=monthName%>, <%=intYear%>
    </td>
  </tr>
  <tr class="week_header_row">
    <th width="14%" class="th_day_cell day">Sun</th>
    <th width="14%" class="th_day_cell day">Mon</th>
    <th width="14%" class="th_day_cell day">Tue</th>
    <th width="14%" class="th_day_cell day">Wed</th>
    <th width="14%" class="th_day_cell day">Thu</th>
    <th width="15%" class="th_day_cell day">Fri</th>
    <th width="15%" class="th_day_cell day">Sat</th>
  </tr>
<%
{
  Month aMonth = Month.getMonth( Integer.parseInt(currentMonthString), Integer.parseInt(currentYearString) );
  int [][] days = aMonth.getDays();
  for( int i=0; i<aMonth.getNumberOfWeeks(); i++ )
  {
    %><tr class="week_data_row"><%
    for( int j=0; j<7; j++ )
    {
      if( days[i][j] == 0 )
      {
        %><td class="empty_day_cell">&nbsp;</td><%
      }
      else
      {
        // this is "today"
        if( currentDayInt == days[i][j] && currentMonthInt == aMonth.getMonth() && currentYearInt == aMonth.getYear() )
        {
          %><td class="today_cell"><%=days[i][j]%></td><%
        }
        else
        {
          %><td class="day_cell"><%=days[i][j]%></td><%
        }
      } // end outer if
    } // end for
    %>
    </tr>
  <%}
}
%>
</table>

<%-- end of "calendar_div" --%>
</div>

<!-- navigation links -->
<%-- sorry, i don't know how to get this look without a table --%>
<table id="calendar_nav_table" border="0">
  <tr>
    <td id="prev_link">
      <form method="post">
        <input type="submit" name="PREV" value=" << ">
        <input type="hidden" name="month" value="<%=prevMonth%>">
        <input type="hidden" name="year" value="<%=prevYear%>">
      </form>
    </td>
    <td id="link_to_month_view">
      <form action="calendarMonthPrintView.jsp" method="post">
        <input type="submit" value="  Full-Screen Print View  " class="submit_button">
        <input type="hidden" name="month" value="<%=intMonth%>">
        <input type="hidden" name="year"  value="<%=intYear%>">
      </form>
    </td>
    <td id="next_link">
      <form method="post">
        <input type="submit" name="NEXT" value=" >> ">
        <input type="hidden" name="month" value="<%=nextMonth%>">
        <input type="hidden" name="year" value="<%=nextYear%>">
      </form>
    </td>
  </tr>
</table>
  <!-- navigation links end -->

</body>
</html>


