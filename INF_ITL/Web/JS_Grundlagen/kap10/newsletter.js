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

// checks all input fields if the input data is valid
function checkform() {
    var fehlermeldung = "";
    with (document.getElementById("anmeldeform")) {
        if (vorname.value == "") {
            fehlermeldung += "Bitte geben Sie Ihren Vornamen an!<br />";
        }
        if (nachname.value == "") {
            fehlermeldung += "Bitte geben Sie Ihren Nachname an!<br />";
        }
        if(nachname.value == vorname.value)
        {
            fehlermeldung += "Vorname und Nachname dürfen nicht gleich sein!<br />";
        }
        //todo: add Name validation
        if(/^[a-zA-Z]+$/.test(str)){
            fehlermeldung += "Bitte einen Validen Vornamen eingeben! <br />";
        }
        //if(/^[^a-zA-Z]*$/.test(nachname)){
        //    fehlermeldung += "Bitte einen Validen Nachnamen eingeben! <br />";
        //}

        if (!testemailadresse(mail.value)) {
            fehlermeldung += "Die eingegebene E-Mail-Adresse ist nicht korrekt!<br />";
        }

        
        // todo: having to check atleast on of the 3 radiobxes 
            // document.getElementById("_1234").checked = true;


        // todo: having text in the textbox

        // todo: fehlermeldungen in Alerts ausgeben

        // todo: mouseover event
    }
    if (fehlermeldung != "") {
        putstatus(fehlermeldung);
        return false;
    } else {
        return confirm("Möchten Sie die Daten jetzt absenden?");
    }
}