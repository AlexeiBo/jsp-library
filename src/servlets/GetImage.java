package servlets;

import beans.Book;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;

public class GetImage extends HttpServlet {

    protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        resp.setContentType("image/png");
        OutputStream outputStream = resp.getOutputStream();
        try{
            int index = Integer.valueOf(req.getParameter("book_id"));
            ArrayList<Book> bookList = (ArrayList<Book>)req.getSession().getAttribute("currentBookList");
            Book book = bookList.get(index);
            byte[] img = book.getImage();
            resp.setContentLength(img.length);
            outputStream.write(img);
        }finally {
            outputStream.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }
}
