<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$sqlQuery = "SELECT * FROM rfid_checkpoint";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $allCheckpoints[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "rfidCheckpointList" => $allCheckpoints,  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}
