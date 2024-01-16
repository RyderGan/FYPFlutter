<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

$sqlQuery = "SELECT * FROM stepcounts WHERE user_id = '$userID' ORDER BY created_at DESC";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $userDetails[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "stepCountData" => $userDetails[0],  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}
