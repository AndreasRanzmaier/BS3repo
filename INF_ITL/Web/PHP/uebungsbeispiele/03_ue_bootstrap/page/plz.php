<?php
/* Formular oder Datenverarbeitung */
if(isset($_POST['save']))
{
  // Datenverarbeitung
  include 'page/plz_save.php';
} else
{
  include 'page/formular.html';
}
