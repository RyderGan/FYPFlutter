<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$sqlQuery = "SELECT * FROM claim_rewards";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $allClaimRewards[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "claimRewardList" => $allClaimRewards,  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}