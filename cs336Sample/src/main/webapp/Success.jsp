
<%
if ((session.getAttribute("username") == null)) {
%>
You are not logged in<br/>
<a href="Login.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("username")%> , you are now logged in <a href='Logout.jsp'>Log out</a>
<%
}
%>
