<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$sqlQuery = "SELECT * FROM users WHERE user_type = 'Student' ORDER BY reward_point DESC";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $allstudentRankingDetails[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "studentRankingData" => $allstudentRankingDetails,  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}
