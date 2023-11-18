<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$stepCount = $_POST['stepCount'];
$userID = $_POST['userID'];

//check previous record exist
$sqlQuery = "SELECT * FROM stepcounts WHERE user_id = '$userID' ORDER BY created_at DESC";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    //check previous date is today or yesterday
    while ($rowFound = $result->fetch_assoc()) {
        $stepCountResults[] = $rowFound;
    }
    $stepCountDetails = $stepCountResults[0];
    $created_at = $stepCountDetails->created_at;
    //check date diff
    $datetimeFormat = 'Y-m-d';
    $currentTimestamp = time();
    $currentDate = DateTime::createFromFormat($datetimeFormat, $timestamp);
    $stepCountDate = DateTime::createFromFormat($datetimeFormat, $timestamp);
    $interval = date_diff($currentDate, $stepCountDate);
    if ($interval == 1) {
        //one day passed, insert new row
        $sqlQuery2 = "INSERT INTO stepcounts SET user_id = '$userID', stepCount = '$stepCount'";
        $result2 = $connectNow->query($sqlQuery2);
        if ($result2) {
            echo json_encode(array("success" => true));
        } else {
            echo json_encode(array("success" => false));
        }
    } else {
        // not yet pass one day
        //get latest stepCount id
        while ($rowFound = $result->fetch_assoc()) {
            $stepCountResults[] = $rowFound;
        }
        $stepCountDetails = $stepCountResults[0];
        $stepCountID = $stepCountDetails->stepCount_id;
        //update row
        $sqlQuery3 = "UPDATE stepcounts SET stepCount = '$stepCount' WHERE stepCount_id = $stepCountID";
        $result3 = $connectNow->query($sqlQuery);
        if ($result3) {
            echo json_encode(array("success" => true));
        } else {
            echo json_encode(array("success" => false));
        }
    }
} else {
    //insert new data if no data related exists
    $sqlQuery2 = "INSERT INTO stepcounts SET user_id = '$userID', stepCount = '$stepCount'";
    $result2 = $connectNow->query($sqlQuery2);
    if ($result2) {
        echo json_encode(array("success" => true));
    } else {
        echo json_encode(array("success" => false));
    }
}

