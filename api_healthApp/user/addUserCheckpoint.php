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

if (isset($_POST['path'])) {
    $path = $_POST['path'];
} else {    
    $path = "";
}

if (isset($_POST['checkpoint'])) {
    $checkpoint = $_POST['checkpoint'];
} else {    
    $checkpoint = "";
}

$sqlQuery2 = "SELECT * FROM paths WHERE path_id = '$pathID'";
$result2 = $connectNow->query($sqlQuery2);
while ($rowFound = $result2->fetch_assoc()) {
    $pathDetails[] = $rowFound;
}
$onepathDetails = $pathDetails[0];
$allcheckPointDetails = $onepathDetails['path_checkpoint_list'];
$allCheckPointsID = explode(",", $allcheckPointDetails);   //convert string to array
$numberOfCheckpointsInPath = count($allCheckPointsID); // get number of checkpoints exist in this path
$lastCheckpoint = $allCheckPointsID[$numberOfCheckpointsInPath - 1]; // get last checkpoint in this path
//check if it's last checkpoint
if ($checkpoint == $lastCheckpoint) {
    //add checkpoint to user_checkpoints table
    $sqlQuery = "INSERT INTO checkpoint_history SET user_id = '$userID', set_id = '$setID', path_id = '$pathID', checkpoint_id = '$checkpoint', checkpoint_type = 'qrCode'";
    $result = $connectNow->query($sqlQuery);
    if (!$result) {
        echo json_encode(array("success" => false));
    }
    //check user has all checkpoints
    $sqlQuery3 = "SELECT * FROM checkpoint_history WHERE user_id = '$userID' AND set_id = '$setID' AND path_id = '$pathID' AND checkpoint_type = 'qrCode' ORDER BY checkpoint_time desc LIMIT $numberOfCheckpointsInPath";
    $result3 = $connectNow->query($sqlQuery3);
    while ($rowFound2 = $result3->fetch_assoc()) {
        $allRecords[] = $rowFound2;
    }

    if ($result3->num_rows == $numberOfCheckpointsInPath) {
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
        $sqlQuery5 = "SELECT * FROM paths WHERE path_id = '$pathID'";
        $result5 = $connectNow->query($sqlQuery5);
        while ($rowFound4 = $result5->fetch_assoc()) {
            $pathDetails[] = $rowFound4;
        }
        $onepathDetails = $pathDetails[0];
        $totalPoints = $userPoints + $onepathDetails['path_points'];
        //update user points
        $sqlQuery6 = "UPDATE users SET reward_point = '$totalPoints' WHERE id = '$userID'";
        $result6 = $connectNow->query($sqlQuery6);
        if ($result6) {
            echo json_encode(array(
                "success" => true,
                "message" => "Completed Path" . $pathID,
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
    //add checkpoint to user_checkpoints table
    $sqlQuery = "INSERT INTO checkpoint_history SET user_id = '$userID', set_id = '$setID', path_id = '$pathID', checkpoint_id = '$checkpoint', checkpoint_type = 'qrCode'";
    $result = $connectNow->query($sqlQuery);
    if ($result) {
        echo json_encode(array(
            "success" => true,
            "message" => "Completed Path " . $pathID . " Checkpoint " . $checkpoint . "",  //row number
        ));
    } else {
        echo json_encode(array("success" => false));
    }
}
