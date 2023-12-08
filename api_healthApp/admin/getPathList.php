<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$sqlQuery = "SELECT * FROM paths";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $allPaths[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "pathList" => $allPaths,  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}
