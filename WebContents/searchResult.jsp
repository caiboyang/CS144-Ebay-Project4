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
        <script type="text/javascript" src="autosuggests.js"></script>
        <script type="text/javascript" src="suggestions.js"></script>
        <script type="text/javascript"> 
            window.onload = function () {
                var oTextbox = new AutoSuggestControl(document.getElementById("info"), new StateSuggestions());
            }
        </script>
        <style type = "text/css">
            div.suggestions {
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            border: 1px solid black;
            position: absolute;
            background-color: white;
            }
            div.suggestions div {
            cursor: default;
            padding: 0px 3px;
            }
            div.suggestions div.current {
            background-color: #3366cc;
            color: white;
            }
        </style>
    </head>
    <body>
        <div class= "PagePart">
            <h1><a href="index.html"><img src="ebay.png" alt="eBay Logo" height="30" width="75"></a> KeyWord Search</h1>
            <div>
                <form action="/eBay/search" method="GET">
                    <div style="input-group">
                        <input type="text" style="height:2em;width:30em" placeholder="Please enter your keyword here" autocomplete="off"
                            id="info" name="q"/>
                        <input name="numResultsToSkip" type="hidden" value="0"/>
                        <input name="numResultsToReturn" type="hidden" value="40"/>
                        <span class="input-group-btn">
                        <button class="btn btn-default">Submit</button>
                        </span>
                    </div>
                </form>
            </div>
            <div>
                <a href="getItem.html">
                <button class="btn btn-default">Searching by Item ID Instead</button>
                </a>
            </div>
            <div>
                <%
                    if(!isEmpty){
                    %>
                <table class="table table-hover" border="1">
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
                <a href="search?q=<%=query%>&numResultsToSkip=<%=numResultsToSkip-numResultsToReturn%>&numResultsToReturn=<%=numResultsToReturn%>">
                <button class="button">Previous Page</button></a>
                <% } %>
                <%
                    if (!isLast)
                    {
                    %>
                <a href="search?q=<%=query%>&numResultsToSkip=<%=numResultsToSkip+numResultsToReturn%>&numResultsToReturn=<%=numResultsToReturn%>"><button class="button">Next Page</button>
                </a>
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