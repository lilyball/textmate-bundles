<%
// some scriptlet code
String name = request.getParameter("name");
if (name != null) {
 %>
 <h1><%= name %></h1>
 <%
} else {
 %>
 <h1 style="color:red">Error!</h1>
<u></u>
 <%
}
%>
<h1 id=""></h1>