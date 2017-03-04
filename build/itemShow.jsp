<%@ page import = "edu.ucla.cs.cs144.*, java.util.*" %>
<% 
    Item currentItem = (Item) request.getAttribute("Item");
    boolean isEmpty = (Boolean) request.getAttribute("isEmpty");
    Bid[] biddingList = (Bid[]) request.getAttribute("bidding");
    String ItemID = (String) request.getParameter("ItemID");
    String[] categories;
    
    if(!isEmpty){
    categories = currentItem.getCategoryList();
    }
    else{
    categories = new String[1];
    }
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <style>
            #map {
            height: 400px;
            width: 100%;
            }
        </style>
        <script type="text/javascript">
            function initMap() {
                var isEmpty = '${isEmpty}';
                if(isEmpty == 'false'){
                    var latitude = <%=currentItem.getLatitude()%>;
                    var longitude = <%=currentItem.getLongitude()%>;
                    var latlng = {lat: latitude, lng: longitude};
                    var map = new google.maps.Map(document.getElementById('map'),
                        {
                       zoom: 12, // default is 8
                       center: latlng
                    });
                    var marker = new google.maps.Marker({
                        position: latlng,
                        map: map
                    });
                }
            }
            
        </script>
        <script async defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDORAeH-evnB_L32B5PPtKiGs32gJ-1tyQ&callback=initMap"></script>
        <title>
            Item Details for <%=currentItem.getItemID()%>
        </title>
    </head>
    <body onload="initMap()">
        <div>
            <div>
                <a href="index.html"><button class="button">Home</button></a>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="keywordSearch.html"><button class="button">Keyword Search</button></a>
            </div>
            <br>
            <div style="width: 300px">
                <form action="/eBay/item" method="GET">
                    <div style="overflow: hidden;">
                        <input name="ItemID" type="text" placeholder="Please enter your Item ID"/>          
                    </div>
                    <input name="submit" type="submit" value="Search"/>  
                </form>
            </div>
            <%
                if(!isEmpty){
                %>
            <div>
                <h1> Item Info </h1>
                <table class="table table-hover" border="1">
                    <tr>
                        <td scope="row">Tags</td>
                        <th scope="col">Information</th>
                    </tr>
                    <tr>
                        <th scope="row">ItemID</th>
                        <td><%=currentItem.getItemID()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Item Name</th>
                        <td><%=currentItem.getName()%></td>
                    </tr>
                    <th scope="row">Category</th>
                    <%
                        for (int i=0;i<categories.length;i++)
                        {
                        %>
                    <tr>
                        <th scope="row"></th>
                        <td><%=categories[i]%></td>
                    </tr>
                        <%
                        }
                        %>
                    <tr>
                        <th scope="row">Currently</th>
                        <%
                        if(currentItem.getCurrently() != ""){
                        %>
                        <td>$ <%=currentItem.getCurrently()%></td>                        
                        <%
                        }else{
                        %>
                        <td>N/A</td>
                        <%
                        }
                        %>  
                    </tr>
                    <tr>
                        <th scope="row">Buy_Price</th>
                        <%
                        if(currentItem.getBuy_price() != ""){
                        %>
                        <td>$ <%=currentItem.getBuy_price()%></td>
                        <%
                        }else{
                        %>
                        <td>N/A</td>
                        <%
                        }
                        %> 
                    </tr>
                    <tr>
                        <th scope="row">First_Bid</th>
                        <%
                        if(currentItem.getFirst_Bid() != ""){
                        %>
                        <td>$ <%=currentItem.getFirst_Bid()%></td>
                        <%
                        }else{
                        %>
                        <td>N/A</td>
                        <%
                        }
                        %> 
                    </tr>
                    <tr>
                        <th scope="row">NumOfBids</th>
                        <td><%=currentItem.getNumber_of_Bids()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Seller Latitude</th>
                        <td><%=currentItem.getLatitude()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Seller Longitude </th>
                        <td><%=currentItem.getLongitude()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Seller Location </th>
                        <td><%=currentItem.getLocation()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Seller Country </th>
                        <td><%=currentItem.getCountry()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Bidding Starting Time </th>
                        <td><%=currentItem.getStart()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Bidding Ending Time </th>
                        <td><%=currentItem.getEnd()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Seller_UserID </th>
                        <td><%=currentItem.getSeller_id()%></td>
                    </tr>
                    <tr>
                        <th scope="row">Seller_Rating </th>
                        <td><%=currentItem.getSeller_rating()%></td>
                    </tr>
                </table>
            </div>
            <div>
                <h1>Description</h1>
                <p><%=currentItem.getDescription()%></p>
            </div>
            <%
                if(currentItem.getLatitude() != ""){
                %>
            <div>
                <h1> Location </h1>
                <div id="map" style="width:400px; height:480px"></div>
            </div>
            <%
                }
                %>
            <div>
                <%
                    if (biddingList.length>0)
                     {
                    %>
                <h1>Bidding Info</h1>
                <table class="table table-hover" border="1">
                    <thead>
                        <tr>
                            <th>Bidder Number</th>
                            <th>User ID</th>
                            <th>Rating</th>
                            <th>Location</th>
                            <th>Country</th>
                            <th>Time of Bid</th>
                            <th>Amount($)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int i=0;i<biddingList.length;i++)
                            {
                            %>
                        <tr>
                            <td><%=i+1%></td>
                            <td><%=biddingList[i].getUser_ID()%></td>
                            <td><%=biddingList[i].getUser_rating()%></td>
                            <td><%=biddingList[i].getUser_loc()%></td>
                            <td><%=biddingList[i].getUser_country()%></td>
                            <td><%=biddingList[i].getBid_time()%></td>
                            <td><%=biddingList[i].getAmount()%></td>
                        </tr>
                        <%
                            }
                            %>
                    </tbody>
                </table>
                <%
                    }else{
                    %>
                <h3> This Item has no bid information. </h3>
                <%
                    }
                    %>
            </div>
            <%
                } else{
                %>
            <h3> We are sorry, but there is no item that match your Item ID: <%= ItemID%>.</h3>
            <%
                }
                %>
        </div>
    </body>
</html>