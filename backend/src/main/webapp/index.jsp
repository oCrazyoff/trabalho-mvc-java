<%--
Redireciona a raiz da aplicacao para a welcome.
--%>
<%
  response.sendRedirect(request.getContextPath() + "/welcome");
%>
