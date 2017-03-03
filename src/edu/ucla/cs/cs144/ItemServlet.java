package edu.ucla.cs.cs144;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.io.*;
import java.text.*;
import java.util.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.FactoryConfigurationError;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.w3c.dom.Text;
import org.xml.sax.InputSource;


public class ItemServlet extends HttpServlet implements Servlet {
       
    public ItemServlet() {}


    /**********copying from Myparser in Pro2 **********/
    static final String columnSeparator = "|*|";
//    static DocumentBuilder builder;

//    static final String[] typeName = {
//            "none",
//            "Element",
//            "Attr",
//            "Text",
//            "CDATA",
//            "EntityRef",
//            "Entity",
//            "ProcInstr",
//            "Comment",
//            "Document",
//            "DocType",
//            "DocFragment",
//            "Notation",
//    };

//    static class MyErrorHandler implements ErrorHandler {
//
//        public void warning(SAXParseException exception)
//                throws SAXException {
//            fatalError(exception);
//        }
//
//        public void error(SAXParseException exception)
//                throws SAXException {
//            fatalError(exception);
//        }
//
//        public void fatalError(SAXParseException exception)
//                throws SAXException {
//            exception.printStackTrace();
//            System.out.println("There should be no errors " +
//                    "in the supplied XML files.");
//            System.exit(3);
//        }
//
//    }

    /* Non-recursive (NR) version of Node.getElementsByTagName(...)
     */
    private static Element[] getElementsByTagNameNR(Element e, String tagName) {
        Vector< Element > elements = new Vector< Element >();
        Node child = e.getFirstChild();
        while (child != null) {
            if (child instanceof Element && child.getNodeName().equals(tagName))
            {
                elements.add( (Element)child );
            }
            child = child.getNextSibling();
        }
        Element[] result = new Element[elements.size()];
        elements.copyInto(result);
        return result;
    }

    /* Returns the first subelement of e matching the given tagName, or
     * null if one does not exist. NR means Non-Recursive.
     */
    private static Element getElementByTagNameNR(Element e, String tagName) {
        Node child = e.getFirstChild();
        while (child != null) {
            if (child instanceof Element && child.getNodeName().equals(tagName))
                return (Element) child;
            child = child.getNextSibling();
        }
        return null;
    }

    /* Returns the text associated with the given element (which must have
     * type #PCDATA) as child, or "" if it contains no text.
     */
    private static String getElementText(Element e) {
        if (e.getChildNodes().getLength() == 1) {
            Text elementText = (Text) e.getFirstChild();
            return elementText.getNodeValue();
        }
        else
            return "";
    }

    /* Returns the text (#PCDATA) associated with the first subelement X
     * of e with the given tagName. If no such X exists or X contains no
     * text, "" is returned. NR means Non-Recursive.
     */
    private static String getElementTextByTagNameNR(Element e, String tagName) {
        Element elem = getElementByTagNameNR(e, tagName);
        if (elem != null)
            return getElementText(elem);
        else
            return "";
    }

    /* Returns the amount (in XXXXX.xx format) denoted by a money-string
     * like $3,453.23. Returns the input if the input is an empty string.
     */
    private static String strip(String money) {
        if (money.equals(""))
            return money;
        else {
            double am = 0.0;
            NumberFormat nf = NumberFormat.getCurrencyInstance(Locale.US);
            try { am = nf.parse(money).doubleValue(); }
            catch (ParseException e) {
                System.out.println("This method should work for all " +
                        "money values you find in our data.");
                System.exit(20);
            }
            nf.setGroupingUsed(false);
            return nf.format(am).substring(1);
        }
    }

    private static String toSQLtime(String old){
        SimpleDateFormat format_xml = new SimpleDateFormat("MMM-dd-yy HH:mm:ss");
        SimpleDateFormat format_ts = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try{
            Date tempDate = format_xml.parse(old);
            return format_ts.format(tempDate);
        }
        catch (Exception e)
        {
            e.printStackTrace(System.out);
        }
        return "";
    }



    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // your codes here
        response.setContentType("text/html");
        String itemId = request.getParameter("ItemID");
        String XML = AuctionSearch.getXMLDataForItemId(itemId);
        int isEmpty = 0;

        if(XML == null || XML.length() == 0){
            isEmpty = 1;
            request.setAttribute("isEmpty", isEmpty);
            request.setAttribute("Item", new Item());
            request.getRequestDispatcher("/itemShow.jsp").forward(request, response);
            return;
        }

        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setValidating(false);
            factory.setIgnoringElementContentWhitespace(true);
            DocumentBuilder builder = factory.newDocumentBuilder();
            // builder.setErrorHandler(new MyErrorHandler());

            StringReader reader = new StringReader(XML);
            Document doc = builder.parse(new InputSource(reader));
            Element item = doc.getDocumentElement();

            String itemID = item.getAttribute("ItemID");
            String name = getElementTextByTagNameNR(item, "Name");
            Element [] category = getElementsByTagNameNR(item, "Category");
            String currently = strip(getElementTextByTagNameNR(item, "Currently"));
            String first_Bid = strip(getElementTextByTagNameNR(item, "first_Bid"));
            String buy_price = strip(getElementTextByTagNameNR(item, "Buy_Price"));
            String number_of_Bids = getElementTextByTagNameNR(item, "Number_of_Bids");
            Element loc = getElementByTagNameNR(item, "Location");
            String latitude = "";
            if (loc != null) {
                latitude = loc.getAttribute("Latitude");
            }
            String longitude = "";
            if (loc != null) {
                longitude = loc.getAttribute("Longitude");
            }
            String location = getElementTextByTagNameNR(item, "Location");
            String country = getElementTextByTagNameNR(item, "Country");
            String start = toSQLtime(getElementTextByTagNameNR(item, "Started"));
            String end = toSQLtime(getElementTextByTagNameNR(item, "Ends"));
            Element seller = getElementByTagNameNR(item, "Seller");
            String seller_rating = seller.getAttribute("Rating");
            String seller_id = seller.getAttribute("UserID");
            String description = getElementTextByTagNameNR(item, "Description");
            ArrayList<String> categoryList = new ArrayList<>();
            ArrayList<Bid> biddingList = new ArrayList<>();

            if (description.length() > 4000) {
                description = description.substring(0,4000);
            }
            //parse category
            for (Element cat : category) {
                categoryList.add(cat.getTextContent());
            }

            //parse bidders
            if(Integer.parseInt(number_of_Bids)>0){
                Element bids  = getElementByTagNameNR(item, "Bids");
                Element [] bidList = getElementsByTagNameNR(bids, "Bid");
                for(Element bid:bidList){
                    Element info = getElementByTagNameNR(bid, "Bidder");
                    String user_rating = info.getAttribute("Rating");
                    String user_id = info.getAttribute("UserID");
                    String user_loc = getElementTextByTagNameNR(info,"Location");
                    String user_country = getElementTextByTagNameNR(info,"Country");

                    String bid_time = toSQLtime(getElementTextByTagNameNR(bid,"Time"));
                    String amount = strip(getElementTextByTagNameNR(bid, "Amount"));
                    Bid newBid = new Bid(user_id, user_rating, user_loc, user_country, bid_time, amount);
                    biddingList.add(newBid);
                }
            }

            Item currentItem = new Item(itemID, name, currently, first_Bid, buy_price, number_of_Bids, latitude,
                    longitude, location, country, start, end, seller_rating, seller_id, description,
                    categoryList.toArray(new String [categoryList.size()]), biddingList);
            request.setAttribute("Item", currentItem);
            request.setAttribute("isEmpty", isEmpty);
            request.setAttribute("bidding", biddingList.toArray(new Bid [biddingList.size()]));
            request.getRequestDispatcher("/itemShow.jsp").forward(request,response);


        }catch(Exception e){
            System.exit(8);
        }

    }
}
