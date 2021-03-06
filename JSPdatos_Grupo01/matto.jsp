<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>
<%@ page language="java" import="java.lang.*" %>
 
<%
/* Paso 1) Obtener los datos del formulario */
String ls_isbn = request.getParameter("isbn");
String ls_titulo = request.getParameter("titulo");
String ls_autor = request.getParameter("autor");
String ls_action = request.getParameter("Action");
String ls_editorial = request.getParameter("editorial");
String ls_año = request.getParameter("publicado");
 
/* Paso 2) Inicializar variables */
String ls_result = "Base de datos actualizada...";
String ls_query = "";
String filePath= getServletContext().getRealPath("\\data\\datos.mdb");
String ls_dburl = "jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ="+filePath;
String ls_usuario = "";
String ls_password = "";
String ls_dbdriver = "sun.jdbc.odbc.JdbcOdbcDriver";
 
/* Paso 3) Crear query&nbsp; */
if (ls_action.equals("Crear")) {
ls_query = " insert into libros (isbn, titulo, autor,Editorial,publicado)";
ls_query += " values (";
ls_query += "'" + ls_isbn + "',";
ls_query += "'" + ls_titulo + "',";
ls_query += "'" + ls_autor + "',";
ls_query +="'" + ls_editorial + "',";
ls_query +="'" + ls_año + "')";
}
 
if (ls_action.equals("Eliminar")) {
ls_query = " delete from libros where isbn = ";
ls_query += "'" + ls_isbn + "'";
}
 
if (ls_action.equals("Actualizar")) {
ls_query = " update libros";
ls_query += " set titulo= " + "'" + ls_titulo + "'"+ ",";
ls_query += " autor = " + "'" + ls_autor + "'"+ ",";
ls_query += "Editorial=" +"'" + ls_editorial + "'"+ ",";
ls_query += "publicado=" +"'" + ls_año + "'";
ls_query += " where isbn= " + "'" + ls_isbn + "'";
}
 
/* Paso 4) Conexi�n a la base de datos */
Connection l_dbconn = null;
 
try {
Class.forName(ls_dbdriver);
/*&nbsp; getConnection(URL,User,Pw) */
l_dbconn = DriverManager.getConnection(ls_dburl,ls_usuario,ls_password);
 
/* Creaci�n de SQL Statement */
Statement l_statement = l_dbconn.createStatement();
/* Ejecuci�n de SQL Statement */
l_statement.execute(ls_query);
} catch (ClassNotFoundException e) {
ls_result = " Error creando el driver!";
ls_result += " <br/>" + e.toString();
} catch (SQLException e) {
ls_result = " Error procesando el SQL!";
ls_result += " <br/>" + e.toString();
} finally {
/* Cerramos */
try {
if (l_dbconn != null) {
l_dbconn.close();
}
} catch (SQLException e) {
ls_result = "Error al cerrar la conexi�n.";
ls_result += " <br/>" + e.toString();
}
}
%>
<html>
<link href="data/pagAviso.css" rel="stylesheet" type="text/css">
<head><title>Actualizando la Base de Datos</title></head>
<body>
<div class="gradient-border" id="box">
La siguiente instruccion fue ejecutada:
<br/><br/>
<%=ls_query%>
<br/><br/>
 
El resultado fue:
<br/><br/>
<%=ls_result%>
<br/>
<br/>
</div>

<a id="boton" href="libros.jsp">Realizar otra acción</a>
</body>
</html>