package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SearchServlet extends HttpServlet implements Servlet {
       
    public SearchServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
        response.setContentType("text/html");
//        String pageTitle = "Search result";
//        request.setAttribute("title", pageTitle);

        String query = request.getParameter("q");
        String skipNumString = request.getParameter("numResultsToSkip");
        String returnNumString = request.getParameter("numResultsToReturn");

        int skipNum = Integer.parseInt(skipNumString);
        int returnNum = Integer.parseInt(returnNumString);

        AuctionSearch searchHelper = new AuctionSearch();
        SearchResult[] searchRET = searchHelper.basicSearch(query,skipNum,returnNum);
//        int totalResult = returnNum;
        request.setAttribute("searchResult", searchRET);
        request.setAttribute("numResultsToSkip", skipNum);
        request.setAttribute("numResultsToReturn",returnNum);
        request.setAttribute("query", query);
        request.getRequestDispatcher("/searchResult.jsp").forward(request,response);

    }
}
