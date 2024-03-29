function AutoSuggestControl(oTextbox, oProvider) {
    this.cur = -1;
    this.layer = null;
    this.provider = oProvider;
    this.textbox = oTextbox;
    this.controlPressed = false;
    this.init(); 
}

AutoSuggestControl.prototype.autosuggest = function (aSuggestions,
bTypeAhead) {
    console.log(aSuggestions);
    console.log(aSuggestions[0]);
    console.log(this.textbox.value);
    console.log(this.textbox.value.length);
    console.log(aSuggestions[0].substring(0, this.textbox.value.length));

    if (aSuggestions.length > 0 && this.textbox.value == aSuggestions[0].substring(0, this.textbox.value.length)) {
        if (bTypeAhead) {
            this.typeAhead(aSuggestions[0]);
        }
        this.showSuggestions(aSuggestions);
    } else {
        this.hideSuggestions();
    }
};
AutoSuggestControl.prototype.typeAhead = function (sSuggestion) {
    if (this.textbox.createTextRange || this.textbox.setSelectionRange) {
        var iLen = this.textbox.value.length; 
        this.textbox.value = sSuggestion; 
        this.selectRange(iLen, sSuggestion.length);
    }
};

AutoSuggestControl.prototype.selectRange = function (iStart, iLength) {
    if (this.textbox.createTextRange) {
        var oRange = this.textbox.createTextRange(); 
        oRange.moveStart("character", iStart); 
        oRange.moveEnd("character", iLength - this.textbox.value.length); 
        oRange.select();
    } else if (this.textbox.setSelectionRange) {
        this.textbox.setSelectionRange(iStart, iLength);
    }

    this.textbox.focus(); 
};

AutoSuggestControl.prototype.handleKeyUp = function (oEvent) {

    var iKeyCode = oEvent.keyCode;

    if(oEvent.metaKey == true){
        if(iKeyCode == 65){
            this.selectRange(0, this.textbox.value.length);
        }
    }
    else{
        console.log("pressed down");
        if (iKeyCode == 8 || iKeyCode == 46) {
            this.provider.requestSuggestions(this, false);

        } else if (iKeyCode < 32 || (iKeyCode >= 33 && iKeyCode <= 46) || (iKeyCode >= 112 && iKeyCode <= 123)) {
            //ignore
        } else {
            this.provider.requestSuggestions(this, true);
    }
    }
    
};

AutoSuggestControl.prototype.init = function () {
    var oThis = this;
    this.textbox.onkeyup = function (oEvent) {
        if (!oEvent) {
            oEvent = window.event;
        }
        oThis.handleKeyUp(oEvent);
    };
};


// drop

AutoSuggestControl.prototype.hideSuggestions = function () {
    this.layer.style.visibility = "hidden";
};

AutoSuggestControl.prototype.highlightSuggestion = function (oSuggestionNode) {

    for (var i=0; i < this.layer.childNodes.length; i++) {
        var oNode = this.layer.childNodes[i];
        if (oNode == oSuggestionNode) {
            oNode.className = "current"
        } else if (oNode.className == "current") {
            oNode.className = "";
        }
    }
};

AutoSuggestControl.prototype.createDropDown = function () {

    this.layer = document.createElement("div");
    this.layer.className = "suggestions";
    this.layer.style.visibility = "hidden";
    this.layer.style.width = this.textbox.offsetWidth;
    document.body.appendChild(this.layer);

    var oThis = this;

    this.layer.onmousedown = this.layer.onmouseup = 
    this.layer.onmouseover = function (oEvent) {
        oEvent = oEvent || window.event;
        oTarget = oEvent.target || oEvent.srcElement;

        if (oEvent.type == "mousedown") {
            oThis.textbox.value = oTarget.firstChild.nodeValue;
            oThis.hideSuggestions();
        } else if (oEvent.type == "mouseover") {
            oThis.highlightSuggestion(oTarget);
        } else {
            oThis.textbox.focus();
        }
    };


};

AutoSuggestControl.prototype.getLeft = function () {

    var oNode = this.textbox;
    var iLeft = 0;

    while(oNode.tagName != "BODY") {
        iLeft += oNode.offsetLeft;
        oNode = oNode.offsetParent; 
    }

    return iLeft;
};

AutoSuggestControl.prototype.getTop = function () {

    var oNode = this.textbox;
    var iTop = 0;

    while(oNode.tagName != "BODY") {
        iTop += oNode.offsetTop;
        oNode = oNode.offsetParent; 
    }

    return iTop;
};

AutoSuggestControl.prototype.showSuggestions = function (aSuggestions) {

    var oDiv = null;
    this.layer.innerHTML = "";

    for (var i=0; i < aSuggestions.length; i++) {
        oDiv = document.createElement("div");
        oDiv.appendChild(document.createTextNode(aSuggestions[i]));
        this.layer.appendChild(oDiv);
    }

    this.layer.style.left = this.getLeft() + "px";
    this.layer.style.top = (this.getTop()+this.textbox.offsetHeight) + "px";
    this.layer.style.visibility = "visible";
};

AutoSuggestControl.prototype.nextSuggestion = function () {
    var cSuggestionNodes = this.layer.childNodes;

    if (cSuggestionNodes.length > 0 && this.cur < cSuggestionNodes.length-1) {
        var oNode = cSuggestionNodes[++this.cur];
        this.highlightSuggestion(oNode);
        this.textbox.value = oNode.firstChild.nodeValue; 
    }
};

AutoSuggestControl.prototype.previousSuggestion = function () {
    var cSuggestionNodes = this.layer.childNodes;

    if (cSuggestionNodes.length > 0 && this.cur > 0) {
        var oNode = cSuggestionNodes[--this.cur];
        this.highlightSuggestion(oNode);
        this.textbox.value = oNode.firstChild.nodeValue; 
    }
};

AutoSuggestControl.prototype.handleKeyDown = function (oEvent) {

    var iKeyCode = oEvent.keyCode;

    if(iKeyCode == 38){
        this.previousSuggestion();
    }
    else if(iKeyCode == 40){
        this.nextSuggestion();
    }
    else if(iKeyCode == 13){
        this.hideSuggestions();
    }
    else if (iKeyCode == 8 || iKeyCode == 46) {
        this.provider.requestSuggestions(this, false, iKeyCode);
    } 
    else if (iKeyCode < 32 || (iKeyCode >= 33 && iKeyCode <= 46) || (iKeyCode >= 112 && iKeyCode <= 123)) {
        //ignore
    } else {
        if (oEvent.metaKey || oEvent.ctrlKey){
            // ignore
        }else{
            this.provider.requestSuggestions(this, true, iKeyCode);
        }
    }
    
};

AutoSuggestControl.prototype.init = function () {

    var oThis = this;

    // this.textbox.onkeyup = function (oEvent) {
    //     if (!oEvent) {
    //         oEvent = window.event;
    //     } 

    //     oThis.handleKeyUp(oEvent);
    // };

    this.textbox.onkeydown = function (oEvent) {

        if (!oEvent) {
            oEvent = window.event;
        } 

        oThis.handleKeyDown(oEvent);
    };

    this.textbox.onblur = function () {
        oThis.hideSuggestions();
    };

    this.createDropDown();
};



