<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['email'])) {
    $email = $_POST['email'];
} else {    
    $email = "";
}
if (isset($_POST['password'])) {
    $password = md5($_POST['password']);
} else {    
    $password = md5("");
}
if (isset($_POST['user_type'])) {
    $userType = $_POST['user_type'];
} else {    
    $userType = "";
}

$sqlQuery = "SELECT * FROM users WHERE email = '$email' AND user_password = '$password' AND user_type = '$userType'";

$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $userDetails[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "userData" => $userDetails[0] //row number
    ));
} else {
    echo json_encode(array("success" => false));
}
