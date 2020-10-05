<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%request.setCharacterEncoding("UTF-8");%>

<%@ page import="beans.Genre" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="beans.Book" %>
<%@ page import="enums.Letters" %>

<html>
<head>
    <title>Main page</title>
    <link rel="stylesheet" type="text/css" href="../stylesheet/main.css">
</head>

<body>

<div class="container"><!--conteiner start-->

    <div class="header"><!--header start-->
        <div class="logo">
            <img src="../images/library.png" alt="Логотип" name="logo" />
        </div>

        <div class="descr">
            <h3>Онлайн библиотека проекта Ateneum</h3>
        </div>

        <div class="welcome"><!--welcome user start-->
            <%
                if (request.getParameter("userName") != null){
                    session.setAttribute("userName", request.getParameter("userName"));
                }
                String username = null;
                if (session.getAttribute("userName") != null){
                    username = (String)session.getAttribute("userName");
                }else {
                    username = "user";
                }
            %>
            <h4>Welcome to Ateneum, <%=username%>!</h4>
            <h4><a href="../index.jsp?session=0">Выход</a></h4>
        </div><!--welcome user end-->

        <div class="search_form">
            <form method="post" action="main.jsp">
                <input type="text" name="searchText" placeholder="Enter search text" value="" size="80%">
                <select name="selectOption">
                    <option name="authorName">Автор</option>
                    <option name="bookName">Название</option>
                </select>
                <button type="submit">Search</button>
            </form>
        </div>
    </div><!--header end-->

    <div class="sidebar1"><!--left menu start-->
        <h4>Жанры:</h4>
        <ul class="nav">
            <jsp:useBean id="genreList" class="beans.GenreList" scope="application"/>
            <%for (Genre genre: genreList.getGenreList()){%>
            <li><a href="main.jsp?genreId=<%=genre.getId()%>"><%=genre.getName()%></a></li>
            <%}%>
        </ul>
        <a href="main.jsp">Все книги</a>
    </div><!--left menu end-->

    <div class="letters"><!--letters start-->
        <%
            char[] letterMass = Letters.getRusLetterList();
            for (int i=0;i<letterMass.length;i++){
                String letter = String.valueOf(letterMass[i]);
                if (request.getParameter("letter") != null){
                    if (request.getParameter("letter").equals(letter)){
        %>
        <a href="main.jsp?letter=<%=letterMass[i]%>"><span style="color: red; font-size: 150%"><%=letter%></span></a>
        <%}else{%>
        <a href="main.jsp?letter=<%=letterMass[i]%>"><%=letter%></a>
        <%}%>
        <%}else{%>
        <a href="main.jsp?letter=<%=letterMass[i]%>"><%=letter%></a>
        <%}
        }%>
    </div><!--letters end-->

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
                <p style="margin:10px;"> <a href="#">Читать</a></p>
            </div>
        </div>
        <%}%>
    </div><!--booklist end-->

    <div style="clear: both; width:1100px;"><!--footer start-->
        footer
    </div><!--footer end-->

</div><!--conteiner end-->

</body>
</html>
