<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$checkpointID = $_POST['checkpointID'];

//Get Checkpoint Info
$sqlQuery = "SELECT * FROM checkpoints WHERE checkpoint_id = '$checkpointID'";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $allCheckpoints[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "checkpointData" => $allCheckpoints[0],  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}