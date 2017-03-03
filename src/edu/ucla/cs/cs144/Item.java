package edu.ucla.cs.cs144;

import com.sun.tools.corba.se.idl.StringGen;

import java.util.ArrayList;

/**
 * Created by boyang on 3/3/17.
 * This is a helper class that helps ItemServlet send data to jsp
 */
public class Item {
    private String itemID;
    private String name;
    private String currently;
    private String first_Bid;
    private String buy_price;
    private String number_of_Bids;
    private String latitude;
    private String longitude;
    private String location;
    private String country;
    private String start;
    private String end;
    private String seller_rating;
    private String seller_id;
    private String description;
    private ArrayList<String> categoryList = new ArrayList<>();

    Item(String itemID, String name, String currently, String first_Bid, String buy_price, String number_of_Bids,
         String latitude, String longitude, String location, String country, String start, String end,
         String seller_rating, String seller_id, String description, ArrayList<String> categoryList,
         ArrayList<Bid> bidList) {
        this.itemID = itemID;
        this.name = name;
        this.currently = currently;
        this.first_Bid = first_Bid;
        this.buy_price = buy_price;
        this.number_of_Bids = number_of_Bids;
        this.latitude = latitude;
        this.longitude = longitude;
        this.location = location;
        this.country = country;
        this.start = start;
        this.end = end;
        this.seller_id = seller_id;
        this.seller_rating = seller_rating;
        this.description = description;
        this.categoryList = categoryList;
    }

    Item(){}

    public String getItemID() {
        return itemID;
    }

    public String getName() {
        return name;
    }

    public String getCurrently() {
        return currently;
    }

    public String getFirst_Bid() {
        return first_Bid;
    }

    public String getBuy_price() {
        return buy_price;
    }

    public String getNumber_of_Bids() {
        return number_of_Bids;
    }

    public String getLatitude() {
        return latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public String getLocation() {
        return location;
    }

    public String getCountry() {
        return country;
    }

    public String getStart() {
        return start;
    }

    public String getEnd() {
        return end;
    }

    public String getSeller_rating(){
        return seller_rating;
    }

    public String getSeller_id(){
        return seller_id;
    }

    public String getDescription(){
        return description;
    }

    public ArrayList<String> getCategoryList(){
        return categoryList;
    }
}
