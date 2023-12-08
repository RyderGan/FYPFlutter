<?php
include '../connection.php';
date_default_timezone_set("Asia/Kuala_Lumpur");
//POST = send/save data
//GET retrieve/read data

if (isset($_POST['rfidUID'])) {
    $rfidUID= $_POST['rfidUID']; 
} else {    
    $rfidUID= "";
}

if (isset($_POST['rfidCheckpointID'])) {
    $rfidCheckpointID= $_POST['rfidCheckpointID']; 
} else {    
    $rfidCheckpointID= "1";
}

process($connectNow, $rfidUID, $rfidCheckpointID);

// if (isset($_POST['userID'])) {
//     $userID = $_POST['userID'];
// } else {    
//     $userID = "3";
// }
function process($connectNow, $rfidUID, $rfidCheckpointID){
    //Get Checkpoint Info
    $currentRfidCheckpoint = getCheckpointInfo($connectNow, $rfidCheckpointID);
    $currentRfidCheckpointID = $rfidCheckpointID;
    $currentRfidCheckpointName= $currentRfidCheckpoint['rfid_checkpoint_name'];
    $currentRfidCheckpointDescription = $currentRfidCheckpoint['rfid_checkpoint_description'];
    $currentRfidCheckpointLocation = $currentRfidCheckpoint['rfid_checkpoint_location'];

    //Get RFID Band Info
    $rfidBand = getRfidBandInfo($connectNow, $rfidUID, $currentRfidCheckpointID);
    $rfidBandID = $rfidBand['rfid_band_id'];
    $rfidBandUID = $rfidBand['rfid_band_uid'];
    $rfidBandName = $rfidBand['rfid_band_name'];
    $userID = $rfidBand['user_id'];

    //Get Checkpoint History
    $checkpointHistoryList = getCheckpointHistory($connectNow, $rfidBandID);
    // $fromCpID = $checkpointHistoryList[1]['rfid_checkpoint_id'];
    // $fromCpTime = $checkpointHistoryList[1]['checkpoint_time'];
    // $toCpID = $checkpointHistoryList[0]['rfid_checkpoint_id'];
    // $toCpTime = $checkpointHistoryList[0]['checkpoint_time'];

    $nextStep = "";
    if ($checkpointHistoryList){
        $previousCpID = $checkpointHistoryList[0]['rfid_checkpoint_id'];
        $previousCpTime = $checkpointHistoryList[0]['checkpoint_time'];

        //Get Previous Checkpoint Info
        $previousRfidCheckpoint = getCheckpointInfo($connectNow, $previousCpID);
        $previousRfidCheckpointID = $previousRfidCheckpoint['rfid_checkpoint_id'];
        $previousRfidCheckpointName= $previousRfidCheckpoint['rfid_checkpoint_name'];
        $previousRfidCheckpointDescription = $previousRfidCheckpoint['rfid_checkpoint_description'];
        $previousRfidCheckpointLocation = $previousRfidCheckpoint['rfid_checkpoint_location'];
      
        $nextStep = validateCheckpointHistory($connectNow, $currentRfidCheckpointID,  $previousRfidCheckpointID, $previousCpTime);

    }

    switch ($nextStep) {
        case "Calculate":
            //Get User Step Count
            $userStepCounts = getUserStepCount($connectNow, $userID, $previousCpTime);

            //Get User BMI
            $userBmi = getUserBmi($connectNow, $userID);

            //Get Path Info
            $pathInfo = getPathInfo($connectNow, $previousCpID, $currentRfidCheckpointID);
            $distance = $pathInfo ['path_distance'];
            $elevation = $pathInfo ['path_elevation'];
            $difficulty = $pathInfo ['path_difficulty'];

            //Calculate Points
            $pointsGained = calculatePoints($previousCpTime, $distance, $elevation, $difficulty, $userStepCounts, $userBmi);

            //Insert Reward Points to DB
            $result = insertRewardPoint($connectNow, $pointsGained, $userID);

            //Insert current checkpoint Info
            insertCheckpointHistory($connectNow, $rfidBandID, $currentRfidCheckpointID);
            break;

        case "Ignore":
            //User scan to the same Checkpoint within 30 minutes
            $result = false;
            break;
        case "Restart":
            //Restart Activity
            $result = insertCheckpointHistory($connectNow, $rfidBandID, $rfidCheckpointID);
            break;
        default:
            //Start New Activity
            $result = insertCheckpointHistory($connectNow, $rfidBandID, $rfidCheckpointID);
    }
    // //Get Path Info
    // $pathInfo = getPathInfo($connectNow, $fromCpID, $toCpID);
    // $distance = $pathInfo ['path_distance'];
    // $elevation = $pathInfo ['path_elevation'];
    // $difficulty = $pathInfo ['path_difficulty'];

    // //Calculate Points
    // $pointsGained = calculatePoints($fromCpTime, $toCpTime, $distance, $elevation, $difficulty);

    // //Insert Reward Points to DB
    // $result = insertRewardPoint($connectNow, $pointsGained, $userID);

    if($result){
        echo json_encode(array("success"=>true));
    }else{
        echo json_encode(array("success"=>false));
    }
}

function calculatePoints($previousCpTime, $distance, $elevation, $difficulty, $userStepCounts, $userBmi){
    $fromCpTime = strtotime($previousCpTime);
    $toCpTime = time();

    //Algorithm to calculate the points

    

    return 5;
}

function getUserStepCount($connectNow, $userID, $previousCpTime){
    $sqlQuery = "SELECT * FROM stepcounts WHERE user_id = '$userID' AND created_at >= '$previousCpTime' ORDER BY created_at DESC";
    $result = $connectNow->query($sqlQuery);

    if ($result->num_rows > 0) {
        while ($rowFound = $result->fetch_assoc()) {
            $userStepCounts[] = $rowFound;
        }
       return $userStepCounts;
    } else {
        return [];
    }
}

function getUserBmi($connectNow, $userID){

    $sqlQuery = "SELECT * FROM bmis WHERE user_id = '$userID' ORDER BY created_at DESC";
    $result = $connectNow->query($sqlQuery);

    if ($result->num_rows > 0) {
        while ($rowFound = $result->fetch_assoc()) {
            $allBmiDetails[] = $rowFound;
        }

        return $allBmiDetails[0];
    } else {
        return [];
    }
}

function getCheckpointInfo($connectNow, $rfidCheckpointID) {
    //Get RFID Band Info
    $sqlQuery = "SELECT * FROM rfid_checkpoint WHERE rfid_checkpoint_id = '$rfidCheckpointID'";
    $result = $connectNow->query($sqlQuery);
    if ($result->num_rows > 0) {
        while ($rowFound = $result->fetch_assoc()) {
            $rfidCheckpointList[] = $rowFound;
        }
        if($rfidCheckpointList){
            $rfidCheckpoint = $rfidCheckpointList[0];
            // $rfidBandID = $rfidCheckpoint['rfid_checkpoint_id'];
            // $rfidName= $rfidCheckpoint['rfid_checkpoint_name'];
            // $rfidDescription = $rfidCheckpoint['rfid_checkpoint_description'];
            // $rfidLocation = $rfidCheckpoint['rfid_checkpoint_location'];
            return $rfidCheckpoint;
        }
    } else {
        return [];
    }
}

function getRfidBandInfo($connectNow, $rfidUID, $rfidCheckpointID) {
    //Get RFID Band Info
    $sqlQuery = "SELECT * FROM rfid_bands WHERE rfid_band_uid = '$rfidUID'";
    $result = $connectNow->query($sqlQuery);

    if ($result->num_rows > 0) {
        while ($rowFound = $result->fetch_assoc()) {
            $rfidBandList[] = $rowFound;
        }
        if($rfidBandList){
            $rfidBand = $rfidBandList[0];
            // $rfidBandID = $rfidBand['rfid_band_id'];
            // $userID = $rfidBand['user_id'];
            return $rfidBand;
        }
    } else {
        return [];
    }
}

function getPathInfo($connectNow, $fromCpID, $toCpID){
    $sqlQuery = "SELECT * FROM paths WHERE path_from_cp_id = '$fromCpID'
    AND path_to_cp_id = '$toCpID'";
    $result = $connectNow->query($sqlQuery);
    
    if ($result->num_rows > 0) {
        while ($rowFound = $result->fetch_assoc()) {
            $allPaths[] = $rowFound;
        }
        if($allPaths){
            $pathInfo = $allPaths[0];
            return $pathInfo;
        }
    } else {
        return [];
    }
}

function getCheckpointHistory($connectNow, $rfidBandID) {
    //Get RFID Band Info
    $sqlQuery = "SELECT * FROM checkpoint_history WHERE rfid_band_id = '$rfidBandID' 
    ORDER BY checkpoint_time DESC LIMIT 3";
    $result = $connectNow->query($sqlQuery);
    if ($result->num_rows > 0) {
        while ($rowFound = $result->fetch_assoc()) {
            $checkpointHistoryList[] = $rowFound;
        }
        if($checkpointHistoryList){
            return $checkpointHistoryList;
        }
    } else {
        return [];
    }
}

function validateCheckpointHistory($connectNow, $currentRfidCheckpointID,  $previousRfidCheckpointID, $previousRfidCheckpointTime){
    $fromCpTime = strtotime($previousRfidCheckpointTime);
    $toCpTime = time();
    //Check Timestamp between current and previous exceed 30 min
    if(($toCpTime-$fromCpTime) < 1800) {     // 1800 seconds = 30 minutes
        //Check if previous checkpoint id is the same as the current ID
        if($currentRfidCheckpointID == $previousRfidCheckpointID){
            return "Ignore";
        }else{
            return "Calculate";
        }
    }else{
        return "Restart";
    }
}

function insertCheckpointHistory($connectNow, $rfidBandID, $rfidCheckpointID) {
    //Insert into Checkpoint History
    $sqlQuery = "INSERT INTO checkpoint_history SET rfid_band_id = '$rfidBandID', 
    rfid_checkpoint_id = '$rfidCheckpointID'";
    $result = $connectNow->query($sqlQuery);
    if($result){
        return true;
    }else{
        return false;
    }
}

function insertRewardPoint($connectNow, $rewardPt, $userID) {
    //Insert into Checkpoint History
    $sqlQuery = "INSERT INTO reward_points SET reward_pt = '$rewardPt', 
    user_id = '$userID'";
    $result = $connectNow->query($sqlQuery);
    if($result){
        return true;
    }else{
        return false;
    }
}



// $sqlQuery = "INSERT INTO checkpoint_history SET rfid_id = '$rfidID', rfid_checkpoint_id = '$rfidCheckpointID',user_id = '$userID'";
// $result = $connectNow->query($sqlQuery);

// if($result){
//     echo json_encode(array("success"=>true));
// }else{
//     echo json_encode(array("success"=>false));
// }

// echo json_encode(array("success"=>$sqlQuery));
