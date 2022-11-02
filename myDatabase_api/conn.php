<?php

function dbconn()
{
    $conn = mysqli_connect("localhost", "root", "", "mydatabase");
    return $conn;
}

?>