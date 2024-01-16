<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['full_name'])) {
    $name = $_POST['full_name'];
} else {    
    $name = "";
}
if (isset($_POST['gender'])) {
    $gender = $_POST['gender'];
} else {    
    $gender = "";
}
if (isset($_POST['dob'])) {
    $dob = $_POST['dob'];
} else {    
    $dob = "";
}
if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

$sqlQuery = "UPDATE users SET full_name = '$name', gender = '$gender', dateOfBirth = '$dob' WHERE id = '$userID'";
$result = $connectNow->query($sqlQuery);

$sqlQuery2 = "SELECT * FROM users WHERE id = '$userID'";
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
