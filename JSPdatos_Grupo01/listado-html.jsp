     <%@page contentType="text/html"  import="java.sql.*,net.ucanaccess.jdbc.*"%>
     
<%    
        response.setStatus(200);
        response.setHeader("Content-Type","text/html; charset=UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setHeader("Content-Disposition","attachment;filename=libros.html");
%>



<%! int cont=0; %>
 <html>
 <head>
 <title>Actualizar, Eliminar, Crear registros.</title>
 
  </head>
 <body>

<H1>MANTENIMIENTO DE LIBROS</H1>

<br><br>

<%!
//Conexion inicio
public Connection getConnection() throws SQLException {
String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
String filePath= getServletContext().getRealPath("\\data\\datos.mdb");
String userName="",password="";
String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

    Connection conn = null;
try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
 conn = DriverManager.getConnection(fullConnectionString,userName,password);

}
 catch (Exception e) {
System.out.println("Error: " + e);
 }
    return conn;
}
//Fin conexion
%>


<%
Connection conexion = getConnection();
   if (!conexion.isClosed()){
out.write("OK");
 cont++;
 String x;
 if(cont%2 == 0){
    x = "asc";
 }else {
    x = "desc";
 }
      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery("select * from libros order by Titulo "+x );

      // Ponemos los resultados en un table de html
      out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td> Titulo</td> <td>Autor</td> <td>Editorial</td><td>Publicado</td> </tr>");
      int i=1;
      while (rs.next())
      {
         out.println("<tr>");
         out.println("<td>"+ i +"</td>");
         String varisbn = rs.getString("isbn");
         out.println("<td>"+varisbn+"</td>");
         String url = "matto.jsp?Action=Eliminar&isbn="+varisbn;
         %><td><%=rs.getString("titulo") %></td><%
         %><td><%=rs.getString("autor") %></td><%
         %><td><%=rs.getString("Editorial") %></td><%        
         %><td><%=rs.getString("publicado")%></td><%  
         out.println("</tr>");
         i++;
      }
      out.println("</table>");

      // cierre de la conexion
      conexion.close();
   }

%>
 </body>
 </html>
 