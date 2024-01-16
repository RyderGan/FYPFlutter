<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

if (isset($_POST['rewardID'])) {
    $rewardID = $_POST['rewardID'];
} else {    
    $rewardID = "";
}

if (isset($_POST['rewardPoints'])) {
    $rewardPt = $_POST['rewardPoints'];
} else {    
    $rewardPt = "";
}

//get user reward points
$sqlQuery = "SELECT * FROM users WHERE id = '$userID'";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $userDetails[] = $rowFound;
    }
    $userDetails = $userDetails[0];
    $userPoints = $userDetails['reward_point'];
}
//subtract points
$totalPoints = $userPoints - $rewardPt;
//update user points
$sqlQuery2 = "UPDATE users SET reward_point = '$totalPoints' WHERE id = '$userID'";
$result2 = $connectNow->query($sqlQuery2);

if($result2){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
