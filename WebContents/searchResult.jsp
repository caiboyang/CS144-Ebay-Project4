<%@ page import = "edu.ucla.cs.cs144.*, java.util.*" %>
<% 
   SearchResult[] searchRET = (SearchResult[])request.getAttribute("searchResult");
   int numResultsToSkip = (Integer)request.getAttribute("numResultsToSkip");
   int numResultsToReturn = (Integer)request.getAttribute("numResultsToReturn");
   boolean isEmpty = (Boolean)request.getAttribute("isEmpty");
   boolean isLast = (Boolean)request.getAttribute("isLast");
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
			<div class="col-md-6 col-md-offset-3 text-center">
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
			<%
			    if(!isEmpty){
			%>
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
					<td><a href="/eBay/item?ItemID=<%=searchRET[i].getItemId()%>"> <%=searchRET[i].getName()%> </a> </td>
					</tr>
				<%
				}
				%>
					  
					</tbody>
				</table>

				
				<% if (numResultsToSkip-numResultsToReturn >=0){ %>
				<a id="Previous Page" href="search?q=<%=query%>&numResultsToSkip=<%=numResultsToSkip-numResultsToReturn%>&numResultsToReturn=<%=numResultsToReturn%>">
						Previous Page</a>
				<% } %>
				
				<%
				if (!isLast)
				{
				%>
				<a id="Next Page" href="search?q=<%=query%>&numResultsToSkip=<%=numResultsToSkip+numResultsToReturn%>&numResultsToReturn=<%=numResultsToReturn%>">
							Next Page</a>
				<%
				}
				%>
				<%int pageStart = numResultsToSkip + 1;%>
				<%int pageEnd = numResultsToSkip + searchRET.length;%>
				<p> Current Item Number: <%=pageStart%> - <%=pageEnd%> </p>

				<%
                	} else{
                %>
                	<p>We are sorry, but there is no item that match your keyword <%= query%></p>
                <%
                	}
                %>
			</div>


        </div>
    </body>
</html>