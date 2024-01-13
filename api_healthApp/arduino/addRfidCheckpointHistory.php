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
    echo "Next Step: $nextStep\n";
    switch ($nextStep) {
        case "Calculate":
            //Get User Step Count
            $userStepCounts = getUserStepCount($connectNow, $userID, $previousCpTime);
            echo "User Stepcount: $userStepCounts[0]";
            //Get User Info
            $userInfo = getUserInfo($connectNow, $userID);

            //Get User BMI
            $userBmi = getUserBmi($connectNow, $userID);

            //Get Path Info
            $pathInfo = getPathInfo($connectNow, $previousCpID, $currentRfidCheckpointID);
            $distance = $pathInfo ['path_distance'];
            $elevation = $pathInfo ['path_elevation'];
            $difficulty = $pathInfo ['path_difficulty'];

            //Calculate Points
            $pointsGained = startCalculatePoints($previousCpTime, $distance, $elevation, $difficulty, $userStepCounts, $userBmi, $userInfo);

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

    if($result){
        echo json_encode(array("success"=>true));
    }else{
        echo json_encode(array("success"=>false));
    }
}

function startCalculatePoints($previousCpTime, $distance, $elevation, $difficulty, $userStepCounts, $userBmi, $userInfo){
    $fromCpTime = strtotime($previousCpTime);
    $toCpTime = time();
    $time = $toCpTime-$fromCpTime;
    $height = $userBmi['user_height'];
    $weight = $userBmi['user_weight'];
    $dateOfBirth = $userInfo['dateOfBirth'];
    $age = date("Y") - date("Y", strtotime($dateOfBirth));
    $gender = $userInfo['gender'];

    //Algorithm to calculate the points
    $points = calculatePointsAlgorithm($height, $weight, $age, $gender, $distance, 
    $time, $elevation, $difficulty, $userStepCounts);

    echo "Points earned: $points\n";
    return 5;
}

function getUserInfo($connectNow, $userID){

    $sqlQuery = "SELECT * FROM users WHERE id = '$userID'";
    $result = $connectNow->query($sqlQuery);
    
    if ($result->num_rows > 0) {
        while ($rowFound = $result->fetch_assoc()) {
            $userDetails[] = $rowFound;
        }
        return $userDetails[0];
    } else {
        return [];
    }
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


// Calculate Points Algorithm

// # Part 1: Calculate BMR
// function calculateBMR($height, $weight, $age, $gender) {
//     // Constants for Harris-Benedict equation
//    //  estimate an individual's basal metabolic rate (BMR).
//     $bmrConstants = [
//         'male' => ['A' => 88.362, 'B' => 13.397, 'C' => 4.799, 'D' => 5.677],
//         'female' => ['A' => 447.593, 'B' => 9.247, 'C' => 3.098, 'D' => 4.330]
//     ];

//     // Calculate BMR
//     if (!in_array(strtolower($gender), ['male', 'female'])) {
//         throw new InvalidArgumentException("Invalid gender. Please enter 'male' or 'female'.");
//     }

//     $genderConstants = $bmrConstants[strtolower($gender)];
//     $bmr = (
//         $genderConstants['A'] +
//         ($genderConstants['B'] * $weight) +
//         ($genderConstants['C'] * $height) -
//         ($genderConstants['D'] * $age)
//     );

//     return $bmr;
// }

// # Part 2: Calculate Work Done and Points
// function calculateWorkAndPoints($bmr, $distance, $time, $elevation, $difficulty, $stepCount) {
//     # User's speed
//     $speed = determineSpeed($stepCount, $distance, $time);

//     # MET for walking/running
//     $metWalkingRunning = determineMETWalkingRunning($speed, $difficulty);

//     # MET for going up/down stairs
//     $metStairs = determineMETStairs($elevation, $speed);

//     # Calculate total MET
//     $totalMET = $metWalkingRunning + $metStairs;

//     # Calculate total energy expenditure (TEE) using Harris-Benedict equation
//     $tee = $bmr * $totalMET;

//     # Calculate points based on power
//     $points = calculatePoints($tee);

//     return $points;
// }

// function determineSpeed($stepCount, $distance, $time) {
//     $speed = $distance / $time;
//     if ($speed > 10){
//         return 10;
//     }
//     else{
//         return $speed;
//     }
// }

// function determineMETWalkingRunning($speed, $difficulty) {
//     # MET increases with speed and difficulty
//     $baseMET = 2.0;
//     $speedMETFactor = 0.5;
//     $difficultyMETFactor = 1.0;

//     return $baseMET + $speedMETFactor * $speed + $difficultyMETFactor * $difficulty;
// }

// function determineMETStairs($elevation, $speed) {
//     # MET increases with elevation and speed
//     if(abs($elevation) == $elevation){
//         //Going up staircase
//         $elevationMETFactor = 3;  
//         $speedMETFactor = 0.5; 

//         return $elevationMETFactor * $elevation + $speedMETFactor * $speed;
//     }else{
//         //Going down staircase
//         $elevationMETFactor = 0.1;  
//         $speedMETFactor = 0.5;

//         return $elevationMETFactor * $elevation + $speedMETFactor * $speed;
//     }

// }

// function calculatePoints($tee) {
//     # Points increase with higher TEE
//     $basePoints = 5.0; 
//     $pointsFactor = 2.0; 
//     $teePoints = $basePoints + $pointsFactor * $tee;
//     echo "tee: $teePoints\n";
//     //Points Range from 40000 to 20000 (still calibrating)
//     if ($teePoints > 40000){
//         return 100;
//     }else if ($teePoints < 40000 && $teePoints > 35000){
//         return 80;
//     }else if ($teePoints < 35000 && $teePoints > 31000){
//         return 60;
//     }else if ($teePoints < 31000 && $teePoints > 29000){
//         return 40;
//     }else if ($teePoints < 29000 && $teePoints > 25000){
//         return 20;
//     }else if ($teePoints < 25000 && $teePoints > 20000){
//         return 10;
//     }else {
//         return 5;
//     }
// }


// function calculatePointsAlgorithm($height, $weight, $age, $gender, $distance, 
//     $time, $elevation, $difficulty, $stepCount){

//     # Part 1: Calculate BMR
//     $bmr = calculateBMR($height, $weight, $age, $gender);
//     # Part 2: Calculate Work Done and Points
//     $points = calculateWorkAndPoints($bmr, $distance, $time, $elevation, $difficulty, $stepCount);

//     # Display the result
//     return $points;
// }