<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$title= $_POST['title'];
$who = $_POST['who'];
$whoDetails = $_POST['whoDetails'];
$aim= $_POST['aim'];
$aimDetails = $_POST['aimDetails'];
$websiteName = $_POST['websiteName'];
$websiteLink= $_POST['websiteLink'];
$facebookLink = $_POST['facebookLink'];
$instagramLink= $_POST['instagramLink'];
$aboutUsID = $_POST['about_us_id'];

$sqlQuery = "UPDATE about_us SET about_us_title = '$title', about_us_who = '$who',
 about_us_who_details = '$whoDetails', about_us_aim = '$aim', 
 about_us_aim_details = '$aimDetails',about_us_website_name = '$websiteName', 
 about_us_website_link = '$websiteLink', about_us_facebook_link = '$facebookLink',
 about_us_instagram_link = '$instagramLink' WHERE about_us_id = '$aboutUsID'";
$result = $connectNow->query($sqlQuery);

$sqlQuery2 = "SELECT * FROM about_us WHERE about_us_id = '$aboutUsID'";
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