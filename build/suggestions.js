function SuggestionProvider() {
    //any initializations needed go here
}
StateSuggestions.prototype.requestSuggestions = function (oAutoSuggestControl,
bTypeAhead) {
    var aSuggestions = [];
    var sTextboxValue = oAutoSuggestControl.textbox.value;
    var request = new XMLHttpRequest();
	

    if (sTextboxValue.length > 0){
    	request.onreadystatechange = function () {
		    if(this.readyState == 4 && this.status == 200){
				var suggestion = this.responseXML.getElementsByTagName("Suggestion");
				for(var i=0; i<suggestion.length;i++){
					aSuggestions.push(suggestion[i].childNodes[0].getAttribute("data"))
				}
			}
		}

		oAutoSuggestControl.autosuggest(aSuggestions, bTypeAhead);
	    request.open('GET', 'suggest?query='+encodeURI(sTextboxValue), true);
		request.send(null);  // No data needs to be sent along with the request.
    }
    else{
    	oAutoSuggestControl.autosuggest(aSuggestions, bTypeAhead);
    	return
    }
};