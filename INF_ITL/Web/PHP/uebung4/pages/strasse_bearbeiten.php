<?php
if(isset($_POST['einfuegen']))
{
    ?>
    <form method="post">
        <label for="ort">Strassenname:</label>
        <input type="text" id="strasse" name="strasse" required placeholder="z.B. Wiener Strasse">
        <br>
        <?php
        $query = 'select plz_id, concat(plz_nr, " ", ort_name)
                    from plz natural join ort
                             left join plz_strasse using (plz_id)
                   where str_id is null
                   order by plz_nr';
        $stmt = $con->prepare($query);
        $stmt->execute();
        echo '<label>Ort</label>';
        echo '<select name="plz">';
        while ($row = $stmt->fetch(PDO::FETCH_NUM))
        {
            echo '<option value="'.$row[0].'">'.$row[1];
        }
        echo '</select><br>';
        ?>
        <input type="submit" name="save_einfuegen" value="speichern">
    </form>
    <?php
}
elseif(isset($_POST['save_einfuegen']))
{
    try
    {
        $strasse = $_POST['strasse'];
        $plz = $_POST['plz'];
        $query1 = 'insert into strasse (str_name) values(?)';
        $query2 = 'insert into plz_strasse (str_id, plz_id) values(?, ?)';
        $stmt1 = $con->prepare($query1);
        $stmt1->execute([$strasse]);
        $strid = $con->lastInsertId();
        $stmt2 = $con->prepare($query2);
        $stmt2->execute([$strid, $plz]);
        echo 'Eine neue Strasse wurde erfasst';
    }
    catch (Exception $e)
    {
        echo $e->getCode().': '.$e->getMessage();
    }
}
elseif(isset($_POST['loeschen']))
{
    ?>
    <form method="post">
        <?php
        $query = 'select str_id, concat(plz_nr, " ", ort_name, " ", str_name)
                    from plz natural join ort
                             natural join plz_strasse
                             natural join strasse
                   order by plz_nr';
        $stmt = $con->prepare($query);
        $stmt->execute();
        echo '<label>Strasse</label>';
        echo '<select name="strasse">';
        while ($row = $stmt->fetch(PDO::FETCH_NUM))
        {
            echo '<option value="'.$row[0].'">'.$row[1];
        }
        echo '</select><br>';
        ?>
        <input type="submit" name="save_loeschen" value="löschen">
    </form>
    <?php
}
elseif(isset($_POST['save_loeschen']))
{
    try
    {
        $strasse = $_POST['strasse'];
        $query1 = 'delete from plz_strasse where str_id = ?';
        $query2 = 'delete from strasse where str_id = ?';
        $stmt1 = $con->prepare($query1);
        $stmt1->execute([$strasse]);
        $stmt2 = $con->prepare($query2);
        $stmt2->execute([$strasse]);
        echo 'Eine Strasse wurde gelöscht';
    }
    catch (Exception $e)
    {
        echo $e->getCode().': '.$e->getMessage();
    }
}
else
{
    ?>
    <form method="post">
        <input type="submit" name="einfuegen" value="Strasse einfügen">
        <input type="submit" name="loeschen" value="Strasse löschen">
    </form>
    <?php
}