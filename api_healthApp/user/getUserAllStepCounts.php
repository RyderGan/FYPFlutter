<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];

$sqlQuery = "SELECT * FROM stepcounts WHERE user_id = '$userID' ORDER BY created_at DESC LIMIT 1,999999";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $allStepCountDetails[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "allStepCountData" => $allStepCountDetails,  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}
