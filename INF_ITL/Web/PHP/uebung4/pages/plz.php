<?php
/* Formular oder  Datenverarbeitung */
if (isset($_POST['save'])) {
    // Datenverarbeitung
    include '../pages/plz_save.php';
}
else {
    include '../pages/formular.html';
}