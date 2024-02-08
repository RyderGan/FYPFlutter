<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data


$sqlQuery = "SELECT * FROM checkpoints";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $allCheckpointsDetails[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "allCheckpointsData" => $allCheckpointsDetails,  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}
