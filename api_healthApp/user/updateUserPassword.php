<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$password = md5($_POST['password']);
$userID = $_POST['userID'];

$sqlQuery = "UPDATE users SET user_password = '$password' WHERE id = '$userID'";
$result = $connectNow->query($sqlQuery);

$sqlQuery2 = "SELECT * FROM users WHERE id = '$userID'";
$result2 = $connectNow->query($sqlQuery2);

if($result){
    if ($result2->num_rows > 0) {
        while ($rowFound = $result2->fetch_assoc()) {
            $userDetails[] = $rowFound;
        }
        echo json_encode(array(
            "success" => true,
            "userData" => $userDetails[0],  //row number
        ));
    } else {
        echo json_encode(array("success" => false));
    }
}else{
    echo json_encode(array("success"=>false));
}
