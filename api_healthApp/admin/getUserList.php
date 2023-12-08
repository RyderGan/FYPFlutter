<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$sqlQuery = "SELECT * FROM users WHERE user_type != 'admin'";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $userList[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "userList" => $userList,  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}
