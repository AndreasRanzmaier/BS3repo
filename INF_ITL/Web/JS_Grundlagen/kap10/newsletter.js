window.onload = function() {
    document.getElementById("anmeldeform").onsubmit = checkform;
    document.getElementById("anmeldeform").onreset = checkreset;
};

// confirm alert to reconfirm for reset
function checkreset() {
    return confirm("Wollen Sie das Formular wirklichzurücksetzen?");
}

// filling the 'status' Element
function putstatus(mytext) {
    document.getElementById('status').innerHTML = mytext;
}

// clearing the 'status' Element
function clearstatus() {
    document.getElementById('status').innerHTML = '';
}

// assessing the email input with a regex
function testemailadresse(testString) {
    var suche = /^[\w\.\-]{2,}\@[äöüa-z0-9\-\.]{1,}\.[a-z]{2,4}$/i;
    return suche.test(testString);
}

// checks all input fields if the input data is valid and write error alerts+logs
function checkform() {
    var fehlermeldung = "";
    with (document.getElementById("anmeldeform")) {
        // Namen validierung
        if (vorname.value == "") {
            fehlermeldung += "Bitte geben Sie Ihren Vornamen an!<br />";
            alert("Bitte geben Sie Ihren Vornamen an!");
        }
        if (nachname.value == "") {
            fehlermeldung += "Bitte geben Sie Ihren Nachname an!<br />";
            alert("Bitte geben Sie Ihren Nachname an!");
        }
        if(nachname.value == vorname.value){
            fehlermeldung += "Vorname und Nachname dürfen nicht gleich sein!<br />";
            alert("Vorname und Nachname dürfen nicht gleich sein!");
        }
        for (let i = 0; i < vorname.value.length; i++) {
            if(vorname.value[i].match(/[a-z]/i)) { //todo: hier noch mit oders Andere Zeichen wie çčé hinzufügen
            } else {
                fehlermeldung += "Vorname darf nur Buchstaben enthalten!<br />";
                alert("Vorname darf nur Buchstaben enthalten!");
                // Russen, Polen und Skandinavier mögen uns hald nicht 
            }
        }
        for (let i = 0; i < nachname.value.length; i++) {
            if(nachname.value[i].match(/[a-z]/i)) {
            } else {
                fehlermeldung += "Nachname darf nur Buchstaben enthalten!<br />";
                alert("Nachname darf nur Buchstaben enthalten!");
                // Russen, Polen und Skandinavier mögen uns hald nicht 
            }
        }
        // Email validierung
        if (!testemailadresse(mail.value)) {
            fehlermeldung += "Die eingegebene E-Mail-Adresse ist nicht korrekt!<br />";
            alert("Die eingegebene E-Mail-Adresse ist nicht korrekt!");
        }
        // Radiobutton validierung
        if(!r1.checked){
            fehlermeldung += "Bitte wählen sie aus wann Ihr nächster Urlaub geplant ist!<br />";
            alert("Bitte wählen sie aus wann Ihr nächster Urlaub geplant ist!");
        }
        // Textbox validierung 
        if(mitteilung.value == ""){
            fehlermeldung += "Bitte schreiben sie etwas!<br />";
            alert("Bitte schreiben sie etwas!");
        }
    }
    
    document.getElementsByName("vorname").onmouseover = function(){
        fehlermeldung += "mouseover vorname";
    }
    
    if (fehlermeldung != "") {
        putstatus(fehlermeldung);
        return false;
    } else {
        return confirm("Möchten Sie die Daten jetzt absenden?");
    }
}

