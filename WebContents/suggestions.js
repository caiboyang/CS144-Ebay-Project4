function StateSuggestions() {
    //any initializations needed go here
}
StateSuggestions.prototype.requestSuggestions = function (oAutoSuggestControl,
bTypeAhead, iKeyCode) {
    
    var sTextboxValue = oAutoSuggestControl.textbox.value;
    sTextboxValue += String.fromCharCode(iKeyCode).toLowerCase()
    var request = new XMLHttpRequest();
	


    if (sTextboxValue.length > 0){
    	var aSuggestions = [];
    	request.onreadystatechange = function () {
		    if(this.readyState == 4 && this.status == 200){
				var suggestion = this.responseXML.getElementsByTagName("CompleteSuggestion");
				for(var i=0; i<suggestion.length;i++){
					
					aSuggestions.push(suggestion[i].childNodes[0].getAttribute("data"));
				}

				oAutoSuggestControl.autosuggest(aSuggestions, bTypeAhead);
				
			}
		}

	    request.open('GET', 'suggest?query='+encodeURI(sTextboxValue), true);
		request.send(null);  // No data needs to be sent along with the request.
    }
    else {
    	var aSuggestions = [];
    	oAutoSuggestControl.autosuggest(aSuggestions, bTypeAhead);
    	return;
    }
};