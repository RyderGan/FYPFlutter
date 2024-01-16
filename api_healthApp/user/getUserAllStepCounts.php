<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

$sqlQuery = "SELECT * FROM stepcounts WHERE user_id = '$userID' ORDER BY created_at DESC LIMIT 1,18446744073709551615";
$result = $connectNow->query($sqlQuery);

//$sqlQuery2 = "SELECT stepCount, LAG(stepCount, 1, 0) OVER (ORDER BY created_at DESC) AS previous_stepCount FROM stepcounts WHERE user_id = '$userID' ORDER BY created_at DESC";
$sqlQuery2 = "SELECT * FROM stepcounts WHERE user_id = '$userID' ORDER BY created_at DESC LIMIT 2,18446744073709551615";
$result2 = $connectNow->query($sqlQuery2);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $allStepCountDetails[] = $rowFound;
    }
    while($rowFound2 = $result2->fetch_assoc()){
        $allPreviousStepCounts[] = $rowFound2;
    }
    echo json_encode(array(
        "success" => true,
        "allStepCountData" => $allStepCountDetails,  //row number
        "allPreviousStepCounts" => $allPreviousStepCounts,
    ));
} else {
    echo json_encode(array("success" => false));
}
