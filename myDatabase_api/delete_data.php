<?php

include("./conn.php");

$conn = dbconn();

if(isset($_POST['id']))
{
    $id = $_POST['id'];
}
else
{
    return;
}

$query = "DELETE FROM `users` WHERE id = '$id'";

$exe = mysqli_query($conn, $query);

$arr = [];

if($exe)
{
    $arr["success"] = "true";
}
else
{
    $arr["success"] = "false";
}

print(json_encode($arr));
?>