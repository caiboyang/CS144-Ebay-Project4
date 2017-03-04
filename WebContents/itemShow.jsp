<%@ page import = "edu.ucla.cs.cs144.*, java.util.*" %>
<% 
   Item currentItem = (Item) request.getAttribute("Item");
   boolean isEmpty = (Boolean) request.getAttribute("isEmpty");
   Bid[] biddingList = (Bid[]) request.getAttribute("bidding")
   String ItemID = (String) request.getParameter("ItemID");
   String[] categories
   
   if(!isEmpty){
        categories = currentItem.getCategoryList();
   }
%>
    
<!DOCTYPE html>
<html> 
<head>
    <title>
        Item Details for <%=currentItem.getName()%>
    </title>
</head>
    
    
<body>
    <div>
		<div>
		&nbsp;
		<a href="keywordSearch.html"><button class="button">Keyword Search</button></a>
		&nbsp;
		<a href="getItem.html"><button class="button">ItemID Search</button></a>
		</div>
		<br>
		<div>
			<form action="/eBay/item" method="GET">				
				<input name="submit" type="submit" value="Search" style="float: right"/>			
				<div style="overflow: hidden;">
					<input name="ItemID" type="text" placeholder="Please enter your Item ID"/>    		
				</div>					
			</form>
		</div>
		<%
            if(!isEmpty){
        %>
		<div>
			<h1> Item Info </h1>
			<table>
				<tr>
					<td style=" font-weight: bold;">Tags</td>
					<th scope="col">&nbsp;Tag Information</th>
				</tr>
				<tr>
					<th scope="row">ItemID</th>
					<td>&nbsp;<%=currentItem.getItemID()%></td>
				</tr>
				<tr>
					<th scope="row">Item Name</th>
					<td>&nbsp;<%=currentItem.getName()%></td>
				</tr>
				
				<%
				for (int i=0;i<categories.length;i++)
				{
				%>
				<tr>
					<th scope="row">Categories <%=i+1%></th>
					<td>&nbsp;<%=categories[i]%></td>
				</tr>
				<%
				}
				%>
				

				<tr>
					<th scope="row">Currently($) </th>
					<td>&nbsp;<%=currentItem.getCurrently()%></td>
				</tr>
				<tr>
					<th scope="row">Buy_Price($) </th>
					<td>&nbsp;<%=currentItem.getBuy_price()%></td>
				</tr>
				<tr>
					<th scope="row">First_Bid($) </th>
					<td>&nbsp;<%=currentItem.getFirst_Bid()%></td>
				</tr>
				<tr>
					<th scope="row">NumOfBids </th>
					<td>&nbsp;<%=currentItem.getNumber_of_Bids()%></td>
				</tr>
                <tr>
					<th scope="row">Seller Latitude</th>
					<td>&nbsp;<%=currentItem.getLatitude()%></td>
				</tr>
				<tr>
					<th scope="row">Seller Longitude </th>
					<td>&nbsp;<%=currentItem.getLongitude()%></td>
				</tr>
                <tr>
					<th scope="row">Seller Location </th>
					<td>&nbsp;<%=currentItem.getLocation()%></td>
				</tr>
				<tr>
					<th scope="row">Seller Country </th>
					<td>&nbsp;<%=currentItem.getCountry()%></td>
				</tr>
				<tr>
					<th scope="row">Bidding Starting Time </th>
					<td>&nbsp;<%=currentItem.getStart()%></td>
				</tr>
				<tr>
					<th scope="row">Bidding Ending Time </th>
					<td>&nbsp;<%=currentItem.getEnd()%></td>
				</tr>
				<tr>
					<th scope="row">Seller_UserID </th>
					<td>&nbsp;<%=currentItem.getSeller_id()%></td>
				</tr>
				<tr>
					<th scope="row">Seller_Rating </th>
					<td>&nbsp;<%=currentItem.getSeller_rating()%></td>
				</tr>
			</table>		

		</div>
		<div>
			<h1>Description</h1>
			<p><%=currentItem.getDescription()%></p>
		</div>
		<div>
		    <%
			if (biddingList.length>0)
			{
			%>
			<h1>Bidding Info</h1>
			<table class="table table-hover">
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
                <p> This Item has no bid information. </p>
            <%
			}
			%>
		</div>
		<%
         } else{
        %>
         <p> We are sorry, but there is no item that match your ItemID: <%= ItemID%>.</p>
        <%
        }
        %>
	</div>
	
</body> 
</html>