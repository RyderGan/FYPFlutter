<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$email = $_POST['email'];
$password = md5($_POST['password']);
$userType = $_POST['user_type'];

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
