<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['setID'])) {
    $setID = $_POST['setID'];
} else {    
    $setID = "";
}

$sqlQuery = "SELECT * FROM sets WHERE set_id = '$setID'";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $allSetDetails[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "setData" => $allSetDetails[0],  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}