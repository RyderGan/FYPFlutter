<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

//1. check if it is last checkpoint
//1.1 If yes, add points to user, if no, go to step2
//2. check if it is 1st checkpoint
//2.1. If yes, insert record, if no check previous user checkpoint records

//input data
if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

if (isset($_POST['setID'])) {
    $setID = $_POST['setID'];
} else {    
    $setID = "";
}

//get user reward points
$sqlQuery1 = "SELECT * FROM users WHERE id = '$userID'";
$result1 = $connectNow->query($sqlQuery1);
$userPoints = 0;
if ($result1->num_rows > 0) {
    while ($rowFound1 = $result1->fetch_assoc()) {
        $userDetails[] = $rowFound1;
    }
    $userDetails = $userDetails[0];
    $userPoints = $userDetails['reward_point'];
}
//add points
$sqlQuery2 = "SELECT * FROM sets WHERE set_id = '$setID'";
$result2 = $connectNow->query($sqlQuery2);
while ($rowFound2 = $result2->fetch_assoc()) {
    $setDetails[] = $rowFound2;
}
$oneSetDetails = $setDetails[0];
$totalPoints = $userPoints + $oneSetDetails['set_bonus_points'];
//update user points
$sqlQuery3 = "UPDATE users SET reward_point = '$totalPoints' WHERE id = '$userID'";
$result3 = $connectNow->query($sqlQuery3);
if ($result3) {
    echo json_encode(array(
        "success" => true,
        "message" => "You got extra ". $oneSetDetails['set_bonus_points']." points for completing Set ".$setID
    ));
} else {
    echo json_encode(array("success" => false));
}
