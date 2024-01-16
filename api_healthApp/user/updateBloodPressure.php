<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['bpID'])) {
    $bpID = $_POST['bpID'];
} else {    
    $bpID = "";
}

if (isset($_POST['systolic'])) {
    $systolic = $_POST['systolic'];
} else {    
    $systolic = "";
}

if (isset($_POST['diastolic'])) {
    $diastolic = $_POST['diastolic'];
} else {    
    $diastolic = "";
}

$sqlQuery = "UPDATE blood_pressures SET systolic_pressure = '$systolic', diastolic_pressure = '$diastolic' WHERE bp_id = '$bpID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
