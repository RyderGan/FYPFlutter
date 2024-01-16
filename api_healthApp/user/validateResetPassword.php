<?php
include '../connection.php';

if (isset($_POST['password'])) {
    $userPassword = md5($_POST['password']);
} else {    
    $userPassword = md5("");
}
if (isset($_POST['email'])) {
    $email = $_POST['email'];
} else {    
    $email = "";
}

$sqlQuery = "SELECT * FROM users WHERE email='$email' AND user_password = '$userPassword'";

$result = $connectNow->query($sqlQuery);

if($result->num_rows > 0){
    //same email existed
    echo json_encode(array("passwordSame"=>true));
}else{
    //email not yet taken
    echo json_encode(array("passwordSame"=>false));
}