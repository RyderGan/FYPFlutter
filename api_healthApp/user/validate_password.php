<?php
include '../connection.php';

$userPassword = md5($_POST['password']);
$userID = $_POST['userID'];

$sqlQuery = "SELECT * FROM users WHERE id='$userID' AND user_password = '$userPassword'";

$result = $connectNow->query($sqlQuery);

if($result->num_rows > 0){
    //same email existed
    echo json_encode(array("passwordSame"=>true));
}else{
    //email not yet taken
    echo json_encode(array("passwordSame"=>false));
}