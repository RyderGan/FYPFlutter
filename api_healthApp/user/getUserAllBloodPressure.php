<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];

$sqlQuery = "SELECT * FROM blood_pressures WHERE user_id = '$userID' ORDER BY created_at DESC";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $allBloodPressureDetails[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "allBloodPressureData" => $allBloodPressureDetails,  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}
