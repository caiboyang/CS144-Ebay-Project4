package edu.ucla.cs.cs144;

/**
 * Created by boyang on 3/3/17.
 */
public class Bid {
    private String user_id;
    private String user_rating;
    private String user_loc;
    private String user_country;
    private String bid_time;
    private String amount;

    public Bid(String user_id, String user_rating, String user_loc, String user_country,
               String bid_time, String amount){
        this.user_id = user_id;
        this.user_rating = user_rating;
        this.user_loc = user_loc;
        this.user_country = user_country;
        this.bid_time = bid_time;
        this.amount = amount;
    }

    public String getUser_ID(){
        return user_id;
    }

    public String getUser_rating(){
        return user_rating;
    }

    public String getUser_loc(){
        return user_loc;
    }

    public String getUser_country(){
        return user_country;
    }

    public String getBid_time(){
        return bid_time;
    }

    public String getAmount(){
        return amount;
    }
}
