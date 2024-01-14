<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data


$userID = $_POST['userID'];

$sqlQuery = "SELECT * FROM workout WHERE workout_user_id = '$userID' AND workout_status != 'Completed' ORDER BY created_at DESC";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $workoutData[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "workoutData" => $workoutData[0],  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}