<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

//1. check if it is last checkpoint
//1.1 If yes, add points to user, if no, go to step2
//2. check if it is 1st checkpoint
//2.1. If yes, insert record, if no check previous user checkpoint records

//input data
$userID = $_POST['userID'];
$road = $_POST['road'];
$checkpoint = $_POST['checkpoint'];

//check if it's last checkpoint
$sqlQuery2 = "SELECT * FROM checkpoints WHERE road_id = '$road' ORDER BY check_point DESC";
$result2 = $connectNow->query($sqlQuery2);
while ($rowFound = $result2->fetch_assoc()) {
    $allCheckPoints[] = $rowFound;
}
$checkPointDetails = $allCheckPoints[0];
$lastCheckpoint = $checkPointDetails['check_point'];

if ($checkpoint == $lastCheckpoint) {
    //add checkpoint to user_checkpoints table
    $sqlQuery = "INSERT INTO user_checkpoints SET user_id = '$userID', check_point = '$checkpoint', road_id = '$road'";
    $result = $connectNow->query($sqlQuery);
    if ($result) {
        echo json_encode(array(
            "success" => true,
            "message" => "Completed Road " . $road . " Checkpoint " . $checkpoint,  //row number
        ));
    } else {
        echo json_encode(array("success" => false));
    }
    //check user has all checkpoints
    $sqlQuery3 = "SELECT * FROM user_checkpoints WHERE road_id = '$road' AND created_at >= DATE_SUB(NOW(), INTERVAL 30 MINUTE);";
    $result3 = $connectNow->query($sqlQuery3);
    while ($rowFound2 = $result3->fetch_assoc()) {
        $allRecords[] = $rowFound2;
    }
    if ($result3->num_rows >= $lastCheckpoint) {
        //get user reward points
        $sqlQuery4 = "SELECT * FROM users WHERE id = '$userID'";
        $result4 = $connectNow->query($sqlQuery4);
        $userPoints = 0;
        if ($result4->num_rows > 0) {
            while ($rowFound3 = $result4->fetch_assoc()) {
                $userDetails[] = $rowFound3;
            }
            $userDetails = $userDetails[0];
            $userPoints = $userDetails['reward_point'];
        }
        //add points
        $sqlQuery5 = "SELECT * FROM roads WHERE road = '$road'";
        $result5 = $connectNow->query($sqlQuery5);
        while ($rowFound4 = $result5->fetch_assoc()) {
            $roadDetails[] = $rowFound4;
        }
        $roadDetails = $roadDetails[0];
        $totalPoints = $userPoints + $roadDetails['reward_pt'];
        print($totalPoints);
        //update user points
        $sqlQuery6 = "UPDATE users SET reward_point = '$totalPoints' WHERE id = '$userID'";
        $result6 = $connectNow->query($sqlQuery6);
        if ($result6) {
            echo json_encode(array(
                "success" => true,
                "message" => "Completed " . $road . "!",
            ));
        } else {
            echo json_encode(array("success" => false));
        }
    } else {
        echo json_encode(array(
            "success" => true,
            "message" => "Please complete all checkpoints",  //row number
        ));
    }
} else {
    //check same checkpoint existed
    $sqlQuery3 = "SELECT * FROM user_checkpoints WHERE road_id = '$road' AND check_point = '$checkpoint' AND created_at >= DATE_SUB(NOW(), INTERVAL 30 MINUTE);";
    $result3 = $connectNow->query($sqlQuery3);
    while ($rowFound2 = $result3->fetch_assoc()) {
        $allRecords[] = $rowFound2;
    }
    if ($result3->num_rows > 0) {
        echo json_encode(array(
            "success" => true,
            "message" => "Checkpoint existed, please proceed to next checkpoint",  //row number
        ));
    } else {
        //add checkpoint to user_checkpoints table
        $sqlQuery = "INSERT INTO user_checkpoints SET user_id = '$userID', check_point = '$checkpoint', road_id = '$road'";
        $result = $connectNow->query($sqlQuery);
        if ($result) {
            echo json_encode(array(
                "success" => true,
                "message" => "Completed Road " . $road . " Checkpoint " . $checkpoint,  //row number
            ));
        } else {
            echo json_encode(array("success" => false));
        }
    }
}
