package servlets;

import beans.Book;
import beans.BookList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;

public class GetPdfBook extends HttpServlet {
    protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/pdf");
        OutputStream outputStream = resp.getOutputStream();
        try{
            int index = Integer.valueOf(req.getParameter("pdf_id"));
            byte[] bookPdf = new BookList().getBookContentPdf(index);
            resp.setContentLength(bookPdf.length);
            outputStream.write(bookPdf);
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
