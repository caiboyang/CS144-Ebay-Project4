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
        boolean isEmpty = false;
        boolean isLast = false;
        // your codes here
        response.setContentType("text/html");
//        String pageTitle = "Search result";
//        request.setAttribute("title", pageTitle);

        String query = request.getParameter("q");
        String skipNumString = request.getParameter("numResultsToSkip");
        String returnNumString = request.getParameter("numResultsToReturn");

        int skipNum = Integer.parseInt(skipNumString);
        int returnNum = Integer.parseInt(returnNumString);

//        AuctionSearch searchHelper = new AuctionSearch();
        SearchResult[] searchRET = AuctionSearch.basicSearch(query,skipNum,returnNum);
//        int totalResult = returnNum;
        if(searchRET == null || searchRET.length == 0){
            isEmpty = true;
        }
        SearchResult[] nextRET = AuctionSearch.basicSearch(query, skipNum + returnNum, 1);

        if(nextRET == null || nextRET.length == 0){
            isLast = true;
        }
        request.setAttribute("searchResult", searchRET);
        request.setAttribute("numResultsToSkip", skipNum);
        request.setAttribute("numResultsToReturn",returnNum);
        request.setAttribute("query", query);
        request.setAttribute("isEmpty", isEmpty);
        request.setAttribute("isLast", isLast);
        request.getRequestDispatcher("/searchResult.jsp").forward(request,response);


    }
}
