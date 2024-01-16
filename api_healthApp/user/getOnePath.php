<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['pathID'])) {
    $pathID = $_POST['pathID'];
} else {    
    $pathID = "";
}

$sqlQuery = "SELECT * FROM paths WHERE path_id = '$pathID'";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $allPathsDetails[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "pathData" => $allPathsDetails[0],  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}