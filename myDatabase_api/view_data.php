<?php

include("./conn.php");
$conn = dbconn();

$query = "SELECT `id`, `name`, `email`, `password` FROM `users`";

$exe = mysqli_query($conn, $query);

$arr = [];

while($row = mysqli_fetch_array($exe))
{
    $arr[] = $row;
}

print(json_encode($arr));
?>