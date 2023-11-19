<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['user_id'];

$sqlQuery = "SELECT * FROM visceral_fats WHERE user_id = '$userID' ORDER BY created_at DESC";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $allVisceralFatDetails[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "visceralFatData" => $allVisceralFatDetails[0],  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}
