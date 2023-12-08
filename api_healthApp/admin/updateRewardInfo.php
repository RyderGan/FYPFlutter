<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$rewardTitle = $_POST['rewardTitle'];
$rewardDescription = $_POST['rewardDescription'];
$requiredPt = $_POST['requiredPt'];
$rewardId = $_POST['rewardId'];

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