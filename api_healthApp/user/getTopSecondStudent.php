<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$sqlQuery = "SELECT * FROM users WHERE user_type = 'Student' ORDER BY reward_point DESC LIMIT 1,1";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $topSecondDetails[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "secondStudentData" => $topSecondDetails[0],  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}
