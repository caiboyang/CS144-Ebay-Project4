package edu.ucla.cs.cs144;

import java.io.IOException;
import java.net.HttpURLConnection;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

public class ProxyServlet extends HttpServlet implements Servlet {
       
    public ProxyServlet() {}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
        String query = request.getParameter("query");
        String encodeMethod = "UTF-8";
    	URL url = new URL(" http://google.com/complete/search?output=toolbar&q=" + URLEncoder.encode(query, encodeMethod));
    	HttpURLConnection connection = (HttpURLConnection)url.openConnection();
    	
    	BufferedReader input = new BufferedReader(new InputStreamReader(connection.getInputStream()));
    	String inputLine;
    	StringBuilder result = new StringBuilder();
    	while((inputLine = input.readLine()) != null){
    		result.append(inputLine);
    	}
    	input.close();
    	connection.disconnect();

    	response.setContentType("text/xml");
    	response.setCharacterEncoding(encodeMethod);
    	response.getWriter().write(result.toString());



    }
}
