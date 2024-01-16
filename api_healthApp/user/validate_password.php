<?php
include '../connection.php';

if (isset($_POST['password'])) {
    $userPassword = md5($_POST['password']);
} else {    
    $userPassword = md5("");
}
if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

$sqlQuery = "SELECT * FROM users WHERE id='$userID' AND user_password = '$userPassword'";

$result = $connectNow->query($sqlQuery);

if($result->num_rows > 0){
    //same email existed
    echo json_encode(array("passwordSame"=>true));
}else{
    //email not yet taken
    echo json_encode(array("passwordSame"=>false));
}