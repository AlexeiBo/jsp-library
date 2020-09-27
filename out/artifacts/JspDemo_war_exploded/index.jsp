<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Login page</title>
      <link rel="stylesheet" type="text/css" href="stylesheet/index.css">
  </head>

  <body>
  <div class="main">
      <div class="content">
          <p class="title"><span class="text"><img src="images/lib.png" width="76" height="77" hspace="10" vspace="10" align="middle"></span></p>
          <p class="title">Онлайн библиотека Ateneum</p>
          <p class="text">Добро пожаловать в онлайн библиотеку, где вы сможете найти любую книгу на ваш вкус. Доступны функции поиска, просмотра, сортировки и многие другие.</p>
          <p class="text">Проект находится в разработке, поэтому дизайн и функционал будет постоянно дорабатываться.</p>
          <p class="text">По всем вопросам обращайтесь по адресу <a href="mailto:9117744299@mail.ru">support@library.com</a></p>
          <p>&nbsp;</p>

      </div>
      <div class="login_div">
          <p class="title">Login please:</p>
          <form class="login_form" method="post" action="pages/main.jsp">
              Name: <input type="text" name="userName" placeholder="Enter your username">
              <button type="submit">Enter</button>
          </form>
      </div>
      <div class="footer">
          Developer AlexeiBo 2020
      </div>
  </div>
  </body>
</html>
