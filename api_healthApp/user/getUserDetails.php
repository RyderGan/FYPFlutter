<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];

$sqlQuery = "SELECT * FROM users WHERE id = '$userID'";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $userDetails[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "userData" => $userDetails[0],  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}