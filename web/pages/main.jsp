<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%request.setCharacterEncoding("UTF-8");%>

<%@include file="/WEB-INF/jspf/header.jspf" %>
<%@include file="/WEB-INF/jspf/left_menu.jspf" %>
<%@include file="/WEB-INF/jspf/letter_list.jspf" %>

<div class="book_list"><!--booklist start-->
    <jsp:useBean id="bookList" class="beans.BookList" scope="page"/>
    <%
        ArrayList<Book> currentBookList = null;
        if (request.getParameter("genreId") != null){
            currentBookList = bookList.getBookArrayListByGenre(request.getParameter("genreId"));
        }else if (request.getParameter("letter") != null){
            currentBookList = bookList.getBookArrayListByLetter(request.getParameter("letter"));
        }else if (request.getParameter("searchText") != null){
            currentBookList = bookList.getBookArrayListByText(request.getParameter("searchText"), request.getParameter("selectOption"));
        }else {
            currentBookList = bookList.getBookArrayListAll();
        }
        session.setAttribute("currentBookList", currentBookList);
    %>
    <h5 style="text-align: left; margin-top:20px;">Найдено книг: <%=currentBookList.size()%> </h5>

    <%for (Book book: currentBookList){%>
    <div class="book_info">
        <div class="book_title">
            <p> <%=book.getName()%></p>
        </div>
        <div class="book_image"><img src="<%=request.getContextPath()%>/GetImage?book_id=<%=currentBookList.indexOf(book)%>" height="250" width="200"></div>
        <div class="book_details">
            <br><strong>ISBN:</strong> <%=book.getIsbn()%>
            <br><strong>Издательство:</strong> <%=book.getPublisher() %>

            <br><strong>Количество страниц:</strong> <%=book.getPage_count() %>
            <br><strong>Год издания:</strong> <%=book.getPublish_year() %>
            <br><strong>Автор:</strong> <%=book.getAuthor() %>
            <p style="margin:10px;"> <a href="readbook.jsp?book_id=<%=currentBookList.indexOf(book)%>">Читать</a></p>
        </div>
    </div>
    <%}%>
</div><!--booklist end-->

<%@include file="/WEB-INF/jspf/footer.jspf" %>