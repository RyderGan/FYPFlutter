<?php
include '../connection.php';
date_default_timezone_set("Asia/Kuala_Lumpur");
//POST = send/save data
//GET retrieve/read data

if (isset($_POST['rfidUID'])) {
    $rfidUID= $_POST['rfidUID']; 
} else {    
    $rfidUID= "A9 73 40 59";
}

if (isset($_POST['checkpointID'])) {
    $checkpointID= $_POST['checkpointID']; 
} else {    
    $checkpointID= "1";
}

process($connectNow, $rfidUID, $checkpointID);

// if (isset($_POST['userID'])) {
//     $userID = $_POST['userID'];
// } else {    
//     $userID = "3";
// }
function process($connectNow, $rfidUID, $checkpointID){
    //Get Checkpoint Info
    $currentCheckpoint = getCheckpointInfo($connectNow, $checkpointID);
    $currentCheckpointID = $checkpointID;
    $currentCheckpointName= $currentCheckpoint['checkpoint_name'];
    $currentCheckpointDescription = $currentCheckpoint['checkpoint_description'];
    $currentCheckpointLocation = $currentCheckpoint['checkpoint_location'];

    //Get RFID Band Info
    $rfidBand = getRfidBandInfo($connectNow, $rfidUID);
    $rfidBandID = $rfidBand['rfid_band_id'];
    $rfidBandUID = $rfidBand['rfid_band_uid'];
    $rfidBandName = $rfidBand['rfid_band_name'];
    $userID = $rfidBand['user_id'];

    //Get Workout Info
    $workoutInfo = getWorkoutInfo($connectNow, $userID);
    $setID = $workoutInfo['workout_set_id'];
    $workoutID = $workoutInfo['workout_id'];
    $pathID= 0;
    $checkpointID = 0;
    if($workoutInfo){
        //Get Checkpoint History
        $checkpointHistoryList = getCheckpointHistory($connectNow, $rfidBandID);

        if ($checkpointHistoryList){
            $previousCpID = $checkpointHistoryList[0]['checkpoint_id'];
            $previousCpTime = $checkpointHistoryList[0]['checkpoint_time'];

            //Get Previous Checkpoint Info
            $previousRfidCheckpoint = getCheckpointInfo($connectNow, $previousCpID);
            $previousRfidCheckpointID = $previousRfidCheckpoint['checkpoint_id'];
            $previousRfidCheckpointName= $previousRfidCheckpoint['checkpoint_name'];
            $previousRfidCheckpointDescription = $previousRfidCheckpoint['checkpoint_description'];
            $previousRfidCheckpointLocation = $previousRfidCheckpoint['checkpoint_location'];
        
            $nextStep = validateCheckpointHistory($connectNow, $currentCheckpointID,  $previousRfidCheckpointID, $previousCpTime, $workoutInfo);

        }else{
            $nextStep = "Restart";
        }
    }else{
        //Send Message
        $nextStep = "No Workout";
    }
    echo "Next Step: $nextStep\n";
    switch ($nextStep) {
        case "Calculate":
            // //Get User Step Count
            // $userStepCounts = getUserStepCount($connectNow, $userID, $previousCpTime);
            // echo "User Stepcount: $userStepCounts[0]";
            // //Get User Info
            // $userInfo = getUserInfo($connectNow, $userID);

            // //Get User BMI
            // $userBmi = getUserBmi($connectNow, $userID);

            // //Get Path Info
            // $pathInfo = getPathInfo($connectNow, $previousCpID, $currentCheckpointID);
            // $distance = $pathInfo ['path_distance'];
            // $elevation = $pathInfo ['path_elevation'];
            // $difficulty = $pathInfo ['path_difficulty'];

            // //Calculate Points
            // $pointsGained = startCalculatePoints($previousCpTime, $distance, $elevation, $difficulty, $userStepCounts, $userBmi, $userInfo);

            // //Insert Reward Points to DB
            // $result = insertRewardPoint($connectNow, $pointsGained, $userID);

            // //Insert current checkpoint Info
            // insertCheckpointHistory($connectNow, $userID, $setID, $pathID,$checkpointID, $rfidBandID);
            break;
        case "Next Checkpoint":

            //Next Checkpoint
            $nextCheckpointID = getNextCheckpoint($connectNow, $workoutInfo);
            $nextCheckpointInfo = getCheckpointInfo($connectNow, $nextCheckpointID);
            $nextCheckpointName = $nextCheckpointInfo['checkpoint_name'];

            //Insert Into Checkpoint History
            $result = insertCheckpointHistory($connectNow, $userID, $setID, $pathID,$checkpointID, $rfidBandID);

            //Update Workout Table
            $result1 = updateWorkout($connectNow, $currentCheckpointID, $workoutID, $workoutInfo);

            //Send Message
            // $msg = "Checkpoint($currentCheckpointName) Recorded! Please head to next checkpoint: $nextCheckpointName";
            // $result = addNotification($connectNow, $userID, $msg);
            break;
        case "Next Path":
            //Next Checkpoint
            $nextCheckpointID = getNextCheckpoint($connectNow, $workoutInfo);
            $nextCheckpointInfo = getCheckpointInfo($connectNow, $nextCheckpointID);
            $nextCheckpointName = $nextCheckpointInfo['checkpoint_name'];

            $currentPathID = getCurrentPath($connectNow, $workoutInfo);
            //Path Info
            $pathInfo = getPathInfo($connectNow, $currentPathID);
            $pathName = $pathInfo['path_name'];
            $pathName = $pathInfo['path_points'];
            
            //Insert Into Checkpoint History
            $result = insertCheckpointHistory($connectNow, $userID, $setID, $pathID,$checkpointID, $rfidBandID);
            
            //Update Workout Table
            $result1 = updateWorkout($connectNow, $currentCheckpointID, $workoutID, $workoutInfo);

            //Add Path Points
            $result2 = completePath($connectNow, $userID, $currentPathID);

            //Send Message
            $msg = "Congratulations on completing Path($pathName)! You have recieved $path_points pts";
            $result = addNotification($connectNow, $userID, $msg);
            break;
        case "Wrong Checkpoint":
            //Next Checkpoint
            $nextCheckpointID = getNextCheckpoint($connectNow, $workoutInfo);
            $nextCheckpointInfo = getCheckpointInfo($connectNow, $nextCheckpointID);
            $nextCheckpointName = $nextCheckpointInfo['checkpoint_name'];

            //Send Message
            $msg = "This is the Wrong Checkpoint! Please head to Checkpoint: $nextCheckpointName";
            $result = addNotification($connectNow, $userID, $msg);
            break;
        case "Finished":
            //Next Checkpoint
            $nextCheckpointID = getNextCheckpoint($connectNow, $workoutInfo);
            $nextCheckpointInfo = getCheckpointInfo($connectNow, $expectedCheckpointID);
            $nextCheckpointName = $expectedCheckpointInfo['checkpoint_name'];

            //Insert Into Checkpoint History
            $result = insertCheckpointHistory($connectNow, $userID, $setID, $pathID,$checkpointID, $rfidBandID);

            //Update Workout Table
            $result1 = updateWorkout($connectNow, $currentCheckpointID, $workoutID, $workoutInfo);

            //Finish Workout
            $result2 = finishWorkout($connectNow, $workoutID);
            
            //Send Message
            $msg = "Congratulations on finishing the Set!";
            $result = addNotification($connectNow, $userID, $msg);
            break;
        case "Restart":
            //Restart Activity
            $result = insertCheckpointHistory($connectNow, $userID, $setID, $pathID,$checkpointID, $rfidBandID);

            //Clear Workout Table
            $result1 = clearWorkout($connectNow, $currentCheckpointID, $workoutID, $workoutInfo);

            //Send Message
            $msg = "You were inactive for too long! The Set will now restart again!";
            $result = addNotification($connectNow, $userID, $msg);

            break;
        case "No Workout":
            //Send Message
            $msg = "Workout not Active. Please start a workout!";
            $result = addNotification($connectNow, $userID, $msg);
            break;
        default:
            //Next Checkpoint
            $nextCheckpointID = getNextCheckpoint($connectNow, $workoutInfo);
            $nextCheckpointInfo = getCheckpointInfo($connectNow, $expectedCheckpointID);
            $nextCheckpointName = $expectedCheckpointInfo['checkpoint_name'];
            //Start New Activity
            $result = insertCheckpointHistory($connectNow, $userID, $setID, $pathID,$checkpointID, $rfidBandID);
            //Send Message
            $msg = "Please Go to this Checkpoint: $nextCheckpointName";
            $result = addNotification($connectNow, $userID, $msg);
    }

    //Get Checkpoint History
    $checkpointHistoryList = getCheckpointHistory($connectNow, $rfidBandID);
    // $fromCpID = $checkpointHistoryList[1]['rfid_checkpoint_id'];
    // $fromCpTime = $checkpointHistoryList[1]['checkpoint_time'];
    // $toCpID = $checkpointHistoryList[0]['rfid_checkpoint_id'];
    // $toCpTime = $checkpointHistoryList[0]['checkpoint_time'];

    $nextStep = "";
    // if ($checkpointHistoryList){
    //     $previousCpID = $checkpointHistoryList[0]['rfid_checkpoint_id'];
    //     $previousCpTime = $checkpointHistoryList[0]['checkpoint_time'];

    //     //Get Previous Checkpoint Info
    //     $previousRfidCheckpoint = getCheckpointInfo($connectNow, $previousCpID);
    //     $previousRfidCheckpointID = $previousRfidCheckpoint['rfid_checkpoint_id'];
    //     $previousRfidCheckpointName= $previousRfidCheckpoint['rfid_checkpoint_name'];
    //     $previousRfidCheckpointDescription = $previousRfidCheckpoint['rfid_checkpoint_description'];
    //     $previousRfidCheckpointLocation = $previousRfidCheckpoint['rfid_checkpoint_location'];
      
    //     $nextStep = validateCheckpointHistory($connectNow, $currentCheckpointID,  $previousRfidCheckpointID, $previousCpTime);

    // }

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

function getCheckpointInfo($connectNow, $checkpointID) {
    //Get Checkpoint Info
    $sqlQuery = "SELECT * FROM checkpoints WHERE checkpoint_id = '$checkpointID'";
    $result = $connectNow->query($sqlQuery);

    if ($result->num_rows > 0) {
        while ($rowFound = $result->fetch_assoc()) {
            $allCheckpoints[] = $rowFound;
        }
        return $allCheckpoints[0];

    } else {
        return false;
    }
    // $result = $connectNow->query($sqlQuery);
    // if ($result->num_rows > 0) {
    //     while ($rowFound = $result->fetch_assoc()) {
    //         $rfidCheckpointList[] = $rowFound;
    //     }
    //     if($rfidCheckpointList){
    //         $rfidCheckpoint = $rfidCheckpointList[0];
    //         // $rfidBandID = $rfidCheckpoint['rfid_checkpoint_id'];
    //         // $rfidName= $rfidCheckpoint['rfid_checkpoint_name'];
    //         // $rfidDescription = $rfidCheckpoint['rfid_checkpoint_description'];
    //         // $rfidLocation = $rfidCheckpoint['rfid_checkpoint_location'];
    //         return $rfidCheckpoint;
    //     }
    // } else {
    //     return [];
    // }
}

function getRfidBandInfo($connectNow, $rfidUID) {
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

function getWorkoutInfo($connectNow, $userID) {
    //Get Workout Info
    $sqlQuery = "SELECT * FROM workout WHERE workout_user_id = '$userID' AND workout_status = 'Active' ORDER BY created_at DESC";
    $result = $connectNow->query($sqlQuery);
    if ($result->num_rows > 0) {
        while ($rowFound = $result->fetch_assoc()) {
            $workoutData[] = $rowFound;
        }
        return $workoutData[0];
    } else {
        return false;
    }
}

function getPathInfo($connectNow, $pathID){
    $sqlQuery = "SELECT * FROM paths WHERE path_id='$pathID'";
    $result = $connectNow->query($sqlQuery);

    if ($result->num_rows > 0) {
        while ($rowFound = $result->fetch_assoc()) {
            $allPaths[] = $rowFound;
        }
        return $allPaths[0];
    } else {
        return false;
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

function getCurrentCheckpoint($connectNow, $workoutInfo){
    $pathList = explode(",", str_replace("]","",str_replace("[","",$workoutInfo['workout_path_list'])));
    $checkpointList = explode("$", str_replace(" ","",str_replace("[","",str_replace("]","",str_replace("],","$",$workoutInfo['workout_checkpoint_list'])))));
    $passedList = explode("$", str_replace(" ","",str_replace("[","",str_replace("]","",str_replace("],","$",$workoutInfo['workout_passed_list'])))));

    //Find current checkpoint position
    $found = false;
    $passedPathIndex = 0;
    $passedCheckpointIndex = 0;
    foreach ($passedList as $passedMiniLists) {
        $passedMiniList = explode(",", $passedMiniLists);
        $passedCheckpointIndex = 0;
        foreach ($passedMiniList as $passedPoint) {
            if($passedPoint == 0){
                $found = true;
                break;
            }
            $passedCheckpointIndex++;
        }
        if($found){
            break;
        }else{
            $passedPathIndex++;
        }
    }
    // echo "Location: $passedPathIndex + $passedCheckpointIndex ";
    
    //Find expected checkpoint ID
    $expectedCheckpointID = 0;
    $expectedPathIndex = 0;
    $expectedCheckpointIndex = 0;
    foreach ($checkpointList as $checkpointMiniLists) {
        $checkpointMiniList = explode(",", $checkpointMiniLists);
        $expectedCheckpointIndex = 0;
        if($expectedPathIndex == $passedPathIndex){
            foreach ($checkpointMiniList as $checkpointID) {
                if($expectedCheckpointIndex == $passedCheckpointIndex){
                    $expectedCheckpointID = $checkpointID;
                    break;
                }
                $expectedCheckpointIndex++;
            }
            break;
        }
        $expectedPathIndex++;
    }

    return $expectedCheckpointID;
}

function getCurrentPath($connectNow, $workoutInfo){
    $pathList = explode(",", str_replace("]","",str_replace("[","",$workoutInfo['workout_path_list'])));
    $checkpointList = explode("$", str_replace(" ","",str_replace("[","",str_replace("]","",str_replace("],","$",$workoutInfo['workout_checkpoint_list'])))));
    $passedList = explode("$", str_replace(" ","",str_replace("[","",str_replace("]","",str_replace("],","$",$workoutInfo['workout_passed_list'])))));

    //Find current checkpoint position
    $found = false;
    $passedPathIndex = 0;
    $passedCheckpointIndex = 0;
    foreach ($passedList as $passedMiniLists) {
        $passedMiniList = explode(",", $passedMiniLists);
        $passedCheckpointIndex = 0;
        foreach ($passedMiniList as $passedPoint) {
            if($passedPoint == 0){
                $found = true;
                break;
            }
            $passedCheckpointIndex++;
        }
        if($found){
            break;
        }else{
            $passedPathIndex++;
        }
    }
    // echo "Location: $passedPathIndex + $passedCheckpointIndex ";
    
    //Find expected checkpoint ID
    $expectedPathID = 0;
    $expectedPathIndex = 0;
    foreach ($pathList as $path) {
        if($expectedPathIndex == $passedPathIndex){
            $expectedPathID = $path;
            break;
        }
        $expectedPathIndex++;
    }

    return $expectedPathID;
}

function getNextCheckpoint($connectNow, $workoutInfo){
    $pathList = explode(",", str_replace("]","",str_replace("[","",$workoutInfo['workout_path_list'])));
    $checkpointList = explode("$", str_replace(" ","",str_replace("[","",str_replace("]","",str_replace("],","$",$workoutInfo['workout_checkpoint_list'])))));
    $passedList = explode("$", str_replace(" ","",str_replace("[","",str_replace("]","",str_replace("],","$",$workoutInfo['workout_passed_list'])))));

    //Find current checkpoint position
    $found = false;
    $passedPathIndex = 0;
    $passedCheckpointIndex = 0;
    $pathLength = count($pathList);
    $checkpointLength = 0;
    foreach ($passedList as $passedMiniLists) {
        $passedMiniList = explode(",", $passedMiniLists);
        $checkpointLength = count($passedMiniList);
        $passedCheckpointIndex = 0;
        foreach ($passedMiniList as $passedPoint) {
            if($passedPoint == 0){
                $found = true;
                break;
            }
            $passedCheckpointIndex++;
        }
        if($found){
            break;
        }else{
            $passedPathIndex++;
        }
    }
    // echo "Path: $pathLength + CP: $checkpointLength ";
    if($passedCheckpointIndex==($checkpointLength-1)){
        //Last Checkpoint in path
        if($passedPathIndex==($pathLength-1)){
            //Last Path
            return false;
        }else{
            //Go to next path
            $passedPathIndex++;
            $passedCheckpointIndex==0;
        }
    }else{
        //Go to next checkpoint
        $passedCheckpointIndex++;
    }
    // echo "Location: $passedPathIndex + $passedCheckpointIndex ";
    
    //Find expected checkpoint ID
    $expectedCheckpointID = 0;
    $expectedPathIndex = 0;
    $expectedCheckpointIndex = 0;
    foreach ($checkpointList as $checkpointMiniLists) {
        $checkpointMiniList = explode(",", $checkpointMiniLists);
        $expectedCheckpointIndex = 0;
        if($expectedPathIndex == $passedPathIndex){
            foreach ($checkpointMiniList as $checkpointID) {
                if($expectedCheckpointIndex == $passedCheckpointIndex){
                    $expectedCheckpointID = $checkpointID;
                    break;
                }
                $expectedCheckpointIndex++;
            }
            break;
        }
        $expectedPathIndex++;
    }

    return $expectedCheckpointID;
}

function validateCheckpointHistory($connectNow, $currentCheckpointID,  $previousRfidCheckpointID, $previousRfidCheckpointTime, $workoutInfo){
    $action = "Restart";
    $fromCpTime = strtotime($previousRfidCheckpointTime);
    $toCpTime = time();
    //Check Timestamp between current and previous exceed 30 min
    if(($toCpTime-$fromCpTime) < 1800) {     // 1800 seconds = 30 minutes
        //Check if workoutInfo is followed

        //Find current checkpoint position
        $expectedCheckpointID = getCurrentCheckpoint($connectNow, $workoutInfo);
        $nextCheckpointID = getNextCheckpoint($connectNow, $workoutInfo);

        $pathList = explode(",", str_replace("]","",str_replace("[","",$workoutInfo['workout_path_list'])));
        $checkpointList = explode("$", str_replace(" ","",str_replace("[","",str_replace("]","",str_replace("],","$",$workoutInfo['workout_checkpoint_list'])))));
        $passedList = explode("$", str_replace(" ","",str_replace("[","",str_replace("]","",str_replace("],","$",$workoutInfo['workout_passed_list'])))));

        //Find current checkpoint position
        $found = false;
        $passedPathIndex = 0;
        $passedCheckpointIndex = 0;
        $pathLength = count($pathList);
        $checkpointLength = 0;
        foreach ($passedList as $passedMiniLists) {
            $passedMiniList = explode(",", $passedMiniLists);
            $checkpointLength = count($passedMiniList);
            $passedCheckpointIndex = 0;
            foreach ($passedMiniList as $passedPoint) {
                if($passedPoint == 0){
                    $found = true;
                    break;
                }
                $passedCheckpointIndex++;
            }
            if($found){
                break;
            }else{
                $passedPathIndex++;
            }
        }
        // echo "Path: $pathLength + CP: $checkpointLength ";

        if($expectedCheckpointID == $currentCheckpointID){
            if($passedCheckpointIndex==($checkpointLength-1)){
                //Last Checkpoint in path
                if($passedPathIndex==($pathLength-1)){
                    //Last Path
                    $action = 'Finished';
                }else{
                    //Go to next path
                    $action = 'Next Path';
                }
            }else{
                //Go to next checkpoint
                $action = 'Next Checkpoint';
            }
        }else{
            $action = "Wrong Checkpoint";
        }

    }
    return $action;
}

function clearWorkout($connectNow, $currentCheckpointID, $workoutID, $workoutInfo){
    //Update Workout
    $pathList = explode(",", str_replace("]","",str_replace("[","",$workoutInfo['workout_path_list'])));
    $checkpointList = explode("$", str_replace(" ","",str_replace("[","",str_replace("]","",str_replace("],","$",$workoutInfo['workout_checkpoint_list'])))));
    $passedList = explode("$", str_replace(" ","",str_replace("[","",str_replace("]","",str_replace("],","$",$workoutInfo['workout_passed_list'])))));

    //Find current checkpoint position
    $found = false;
    $passedPathIndex = 0;
    $passedCheckpointIndex = 0;
    foreach ($passedList as $passedMiniLists) {
        $passedMiniList = explode(",", $passedMiniLists);
        $passedCheckpointIndex = 0;
        foreach ($passedMiniList as $passedPoint) {
            if($passedPoint == 0){
                $found = true;
                break;
            }
            $passedCheckpointIndex++;
        }
        if($found){
            break;
        }else{
            $passedPathIndex++;
        }
    }
    // echo "Location: $passedPathIndex + $passedCheckpointIndex ";

    //Create New List
    $newPassedList = "[";

    $found = false;
    $expectedPathIndex = 0;
    $expectedCheckpointIndex = 0;
    $nextInBigList = false;
    foreach ($passedList as $passedMiniLists) {
        $passedMiniList = explode(",", $passedMiniLists);
        if($nextInBigList){
            $newPassedList .= ",[";
        }else{
            $newPassedList .= "[";
            $nextInBigList = true;
        }
        $nextInList = false;
        $expectedCheckpointIndex = 0;
        if($expectedPathIndex == $passedPathIndex){
            foreach ($passedMiniList as $passedPoint) {
                if($nextInList){
                    if($expectedCheckpointIndex == $passedCheckpointIndex){
                        $newPassedList .= ",";
                        $newPassedList .= 0;
                        $found = true;
                    }else{
                        $newPassedList .= ",";
                        $newPassedList .= 0;
                    }
                }else{
                    if($expectedCheckpointIndex == $passedCheckpointIndex){
                        $newPassedList .= 0;
                        $found = true;
                    }else{
                        $newPassedList .= 0;
                    }
                    $nextInList = true;
                }
                $expectedCheckpointIndex++;
            }
        }else{
            foreach ($passedMiniList as $passedPoint) {
                if($nextInList){
                    $newPassedList .= ",";
                    $newPassedList .= 0;
                }else{
                    $newPassedList .= 0;
                    $nextInList = true;
                }
                $expectedCheckpointIndex++;
            }
        }
        $newPassedList .= "]";
        $expectedPathIndex++;
    }
    $newPassedList .= "]";
    $sqlQuery = "UPDATE workout SET workout_passed_list = '$newPassedList' WHERE workout_id = '$workoutID'";
    $result = $connectNow->query($sqlQuery);
    if($result){
        return true;
    }else{
        return false;
    }
}

function updateWorkout($connectNow, $currentCheckpointID, $workoutID, $workoutInfo){
    //Update Workout
    $pathList = explode(",", str_replace("]","",str_replace("[","",$workoutInfo['workout_path_list'])));
    $checkpointList = explode("$", str_replace(" ","",str_replace("[","",str_replace("]","",str_replace("],","$",$workoutInfo['workout_checkpoint_list'])))));
    $passedList = explode("$", str_replace(" ","",str_replace("[","",str_replace("]","",str_replace("],","$",$workoutInfo['workout_passed_list'])))));

    //Find current checkpoint position
    $found = false;
    $passedPathIndex = 0;
    $passedCheckpointIndex = 0;
    foreach ($passedList as $passedMiniLists) {
        $passedMiniList = explode(",", $passedMiniLists);
        $passedCheckpointIndex = 0;
        foreach ($passedMiniList as $passedPoint) {
            if($passedPoint == 0){
                $found = true;
                break;
            }
            $passedCheckpointIndex++;
        }
        if($found){
            break;
        }else{
            $passedPathIndex++;
        }
    }
    // echo "Location: $passedPathIndex + $passedCheckpointIndex ";

    //Create New List
    $newPassedList = "[";

    $found = false;
    $expectedPathIndex = 0;
    $expectedCheckpointIndex = 0;
    $nextInBigList = false;
    foreach ($passedList as $passedMiniLists) {
        $passedMiniList = explode(",", $passedMiniLists);
        if($nextInBigList){
            $newPassedList .= ",[";
        }else{
            $newPassedList .= "[";
            $nextInBigList = true;
        }
        $nextInList = false;
        $expectedCheckpointIndex = 0;
        if($expectedPathIndex == $passedPathIndex){
            foreach ($passedMiniList as $passedPoint) {
                if($nextInList){
                    if($expectedCheckpointIndex == $passedCheckpointIndex){
                        $newPassedList .= ",";
                        $newPassedList .= $currentCheckpointID;
                        $found = true;
                    }else{
                        $newPassedList .= ",";
                        $newPassedList .= $passedPoint;
                    }
                }else{
                    if($expectedCheckpointIndex == $passedCheckpointIndex){
                        $newPassedList .= $currentCheckpointID;
                        $found = true;
                    }else{
                        $newPassedList .= $passedPoint;
                    }
                    $nextInList = true;
                }
                $expectedCheckpointIndex++;
            }
        }else{
            foreach ($passedMiniList as $passedPoint) {
                if($nextInList){
                    $newPassedList .= ",";
                    $newPassedList .= $passedPoint;
                }else{
                    $newPassedList .= $passedPoint;
                    $nextInList = true;
                }
                $expectedCheckpointIndex++;
            }
        }
        $newPassedList .= "]";
        $expectedPathIndex++;
    }
    $newPassedList .= "]";
    $sqlQuery = "UPDATE workout SET workout_passed_list = '$newPassedList' WHERE workout_id = '$workoutID'";
    $result = $connectNow->query($sqlQuery);
    if($result){
        return true;
    }else{
        return false;
    }
}

function insertCheckpointHistory($connectNow, $userID, $setID, $pathID,$checkpointID, $rfidBandID) {
    //Insert into Checkpoint History
    $sqlQuery = "INSERT INTO checkpoint_history SET user_id = '$userID', set_id = '$setID', path_id = '$pathID', checkpoint_id = '$checkpointID', checkpoint_type = 'RFID', rfid_band_id = '$rfidBandID'";
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

function addNotification($connectNow, $userID, $msg) {
    //Send Message
    $hasRead = 0;
    $sqlQuery = "INSERT INTO notifications SET user_id = '$userID', msg = '$msg', hasRead = '$hasRead'";
    $result = $connectNow->query($sqlQuery);
    if($result){
        return true;
    }else{
        return false;
    }
}

function completePath($connectNow, $userID, $pathID){
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
    if ($result5) {
        return true;
    } else {
        return false;
    }
}

function finishWorkout($connectNow, $workoutID){
    $sqlQuery = "UPDATE workout SET workout_status = 'Finished'
    WHERE workout_id = '$workoutID'";
    $result = $connectNow->query($sqlQuery);

    if($result){
        echo json_encode(array("success" => true));
    }else{
        echo json_encode(array("success"=>false));
    }
}

// $sqlQuery = "INSERT INTO checkpoint_history SET rfid_id = '$rfidID', rfid_checkpoint_id = '$checkpointID',user_id = '$userID'";
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