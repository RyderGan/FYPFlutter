<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

if (isset($_POST['title'])) {
    $title = $_POST['title'];
} else {    
    $title = "";
}

if (isset($_POST['who'])) {
    $who = $_POST['who'];
} else {    
    $who = "";
}

if (isset($_POST['whoDetails'])) {
    $whoDetails = $_POST['whoDetails'];
} else {    
    $whoDetails = "";
}

if (isset($_POST['aim'])) {
    $aim = $_POST['aim'];
} else {    
    $aim = "";
}

if (isset($_POST['aimDetails'])) {
    $aimDetails = $_POST['aimDetails'];
} else {    
    $aimDetails = "";
}

if (isset($_POST['websiteName'])) {
    $websiteName = $_POST['websiteName'];
} else {    
    $websiteName = "";
}

if (isset($_POST['websiteLink'])) {
    $websiteLink = $_POST['websiteLink'];
} else {    
    $websiteLink = "";
}

if (isset($_POST['facebookLink'])) {
    $facebookLink = $_POST['facebookLink'];
} else {    
    $facebookLink = "";
}

if (isset($_POST['instagramLink'])) {
    $instagramLink = $_POST['instagramLink'];
} else {    
    $instagramLink = "";
}

if (isset($_POST['lat'])) {
    $lat = $_POST['lat'];
} else {    
    $lat = "";
}

if (isset($_POST['long'])) {
    $long = $_POST['long'];
} else {    
    $long = "";
}

if (isset($_POST['about_us_id'])) {
    $aboutUsID = $_POST['about_us_id'];
} else {    
    $aboutUsID = "";
}

$sqlQuery = "UPDATE about_us SET about_us_title = '$title', about_us_who = '$who',
 about_us_who_details = '$whoDetails', about_us_aim = '$aim', 
 about_us_aim_details = '$aimDetails',about_us_website_name = '$websiteName', 
 about_us_website_link = '$websiteLink', about_us_facebook_link = '$facebookLink',
 about_us_instagram_link = '$instagramLink', about_us_lat = '$lat',
 about_us_long = '$long' WHERE about_us_id = '$aboutUsID'";
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