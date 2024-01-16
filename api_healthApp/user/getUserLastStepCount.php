<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

//$sqlQuery = "SELECT SUM(stepCount) AS TotalStepCounts FROM stepcounts WHERE user_id = '$userID' AND DATE(created_at) < CURDATE()";
$sqlQuery = "SELECT stepCount AS LastStepCount FROM stepcounts WHERE user_id = '$userID' AND DATE(created_at) < CURDATE() ORDER BY created_at DESC LIMIT 1";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $sum = $rowFound['LastStepCount'];
    }
    echo json_encode(array(
        "success" => true,
        "LastStepCount" => $sum, 
    ));
} else {
    echo json_encode(array("success" => false));
}
