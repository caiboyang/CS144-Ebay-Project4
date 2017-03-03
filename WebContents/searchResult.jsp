<%@ page import = "edu.ucla.cs.cs144.*, java.util.*" %>
<% 
   SearchResult[] searchRET = (SearchResult[])request.getAttribute("searchResult");
   int numResultsToSkip = (Integer)request.getAttribute("numResultsToSkip");
   int numResultsToReturn = (Integer)request.getAttribute("numResultsToReturn");
   String query = (String)request.getAttribute("query");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Keyword Search Results</title>
    </head>
    <body>
        <div class= "PagePart">    
			<div>
			<a href="keywordSearch.html"><button class="button">go to Keyword Search</button></a>
			&nbsp;
			<a href="getItem.html"><button class="button">go to ItemID Search</button></a>
			</div>
			<div>
                <form action="/eBay/search" method="GET">
                    <input name="submit" type="submit" value="Search" style="float: right"/>
                    <div style="overflow: hidden;">
                        <input name="q" type="text" id="query" placeholder="Please enter your keyword here"/>
                        <input name="numResultsToSkip" type="hidden" value="0" />
                        <input name="numResultsToReturn" type="hidden" value="40" />

                    </div>
                </form>
			</div>

			<div>
				<table>
					<thead>
					  <tr>
						<th>Item ID</th>
						<th>Item Name</th>
					  </tr>
					</thead>
					<tbody>
										  
				<% 
                   for (int i=0; i<searchRET.length; i++)  { 
				%>
					<tr>
					<td><a href="/eBay/item?ItemID=<%=searchRET[i].getItemId()%>"> <%=searchRET[i].getItemId()%>  </a> </td>
					<td><a href="/eBay/item?ItemID=<%=searchRET[i].getName()%>"> <%=searchRET[i].getName()%> </a> </td>
					</tr>
				<%
				}
				%>
					  
					</tbody>
				</table>
<!--
				
				<% if (numResultsToSkip-numResultsToReturn >=0){ %>
				<a id="Previous Page" href="search?q=<%=query%>&numResultsToSkip=<%=numResultsToSkip-numResultsToReturn%>&numResultsToReturn=<%=numResultsToReturn%>">
						Previous Page</a>
				<% } %>
				
				<%
				if (numResultsToSkip+numResultsToReturn < totalSum)
				{
				%>
				<a id="Next Page" href="search?q=<%=query%>&numResultsToSkip=<%=numResultsToSkip+numResultsToReturn%>&numResultsToReturn=<%=numResultsToReturn%>">
							Next Page</a>
				<%
				}
				%>
				<%int pageStart = numResultsToSkip+1;%>
				<%int pageEnd = numResultsToSkip+numResultsToReturn>totalSum ? totalSum: numResultsToSkip+numResultsToReturn;%>
				<p> Item Returned: <%=pageStart%> ~ <%=pageEnd%> / <%=totalSum%> </p>
-->
			</div>


        </div>
    </body>
</html>