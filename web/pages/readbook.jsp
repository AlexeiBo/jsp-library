<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%request.setCharacterEncoding("UTF-8");%>

<%@include file="/WEB-INF/jspf/header.jspf" %>
<%@include file="/WEB-INF/jspf/left_menu.jspf" %>
<%@include file="/WEB-INF/jspf/letter_list.jspf" %>

<div class="pdf_viewer">
    <%
        ArrayList<Book> bookArrayList = (ArrayList<Book>)session.getAttribute("currentBookList");
        Book book = bookArrayList.get(Integer.valueOf(request.getParameter("book_id")));
    %>
    <div>
        <h5 style="text-align: left; margin-top:20px;"><%=book.getName()%></h5>
    </div>
    <div>
        <EMBED width="75%" height="900" src="<%=request.getContextPath()%>/GetPdfBook?pdf_id=<%=book.getId()%>"/>
    </div>
</div>


<%@include file="/WEB-INF/jspf/footer.jspf" %>