<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$sqlQuery = "SELECT * FROM sets";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $allSets[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "setList" => $allSets,  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}
