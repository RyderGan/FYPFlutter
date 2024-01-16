<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['rewardTitle'])) {
    $rewardTitle = $_POST['rewardTitle'];
} else {    
    $rewardTitle = "";
}

if (isset($_POST['rewardDescription'])) {
    $rewardDescription = $_POST['rewardDescription'];
} else {    
    $rewardDescription = "";
}

if (isset($_POST['requiredPt'])) {
    $requiredPt = $_POST['requiredPt'];
} else {    
    $requiredPt = "";
}

if (isset($_POST['rewardId'])) {
    $rewardId = $_POST['rewardId'];
} else {    
    $rewardId = "";
}

$sqlQuery = "UPDATE rewards SET reward_title = '$rewardTitle', reward_description = '$rewardDescription',
 required_pt = '$requiredPt' WHERE reward_id = '$rewardId'";
$result = $connectNow->query($sqlQuery);

$sqlQuery2 = "SELECT * FROM rewards WHERE reward_id = '$rewardId'";
$result2 = $connectNow->query($sqlQuery2);

if($result){
    if ($result2->num_rows > 0) {
        while ($rowFound = $result2->fetch_assoc()) {
            $userDetails[] = $rowFound;
        }
        echo json_encode(array(
            "success" => true,
            "userData" => $userDetails[0],  //row number
        ));
    } else {
        echo json_encode(array("success" => false));
    }
}else{
    echo json_encode(array("success"=>false));
}