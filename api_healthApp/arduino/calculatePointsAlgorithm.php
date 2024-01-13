<?php
include '../connection.php';
date_default_timezone_set("Asia/Kuala_Lumpur");

# Part 1: Calculate BMR
function calculateBMR($height, $weight, $age, $gender) {
    // Constants for Harris-Benedict equation
    $bmrConstants = [
        'male' => ['A' => 88.362, 'B' => 13.397, 'C' => 4.799, 'D' => 5.677],
        'female' => ['A' => 447.593, 'B' => 9.247, 'C' => 3.098, 'D' => 4.330]
    ];

    // Calculate BMR
    if (!in_array(strtolower($gender), ['male', 'female'])) {
        throw new InvalidArgumentException("Invalid gender. Please enter 'male' or 'female'.");
    }

    $genderConstants = $bmrConstants[strtolower($gender)];
    $bmr = (
        $genderConstants['A'] +
        ($genderConstants['B'] * $weight) +
        ($genderConstants['C'] * $height) -
        ($genderConstants['D'] * $age)
    );

    return $bmr;
}

# Part 2: Calculate Work Done and Points
function calculateWorkAndPoints($bmr, $distance, $time, $elevation, $difficulty, $stepCount) {
    # Step 1: Determine user's speed
    $speed = determineSpeed($stepCount, $distance, $time);

    # Step 2: Determine MET for walking/running
    $metWalkingRunning = determineMETWalkingRunning($speed, $difficulty);

    # Step 3: Determine MET for going up/down stairs
    $metStairs = determineMETStairs($elevation, $speed);

    # Step 4: Calculate total MET
    $totalMET = $metWalkingRunning + $metStairs;

    # Step 5: Calculate total energy expenditure (TEE) using Harris-Benedict equation
    $tee = $bmr * $totalMET;

    # Step 6: Calculate power (work done per unit time)
    $power = $tee / $time;

    # Step 7: Calculate points based on power
    $points = calculatePoints($power);

    return $points;
}

# Helper function to determine user's speed
function determineSpeed($stepCount, $distance, $time) {
    $speed = $distance / $time;

    if ($speed < 1.0) {
        return 'slow';
    } elseif ($speed < 2.0) {
        return 'normal';
    } elseif ($speed < 3.0) {
        return 'fast walk';
    } else {
        return 'run';
    }
}

# Helper function to determine MET for walking/running
function determineMETWalkingRunning($speed, $difficulty) {
    # Your logic to determine MET based on speed and difficulty
    # Example: MET increases with speed and difficulty
    $baseMET = 2.0;  // Adjust as needed
    $speedMETFactor = 0.5;  // Adjust as needed
    $difficultyMETFactor = 1.0;  // Adjust as needed

    return $baseMET + $speedMETFactor * getSpeedFactor($speed) + $difficultyMETFactor * $difficulty;
}

# Helper function to determine MET for going up/down stairs
function determineMETStairs($elevation, $speed) {
    # Your logic to determine MET based on elevation and speed
    # Example: MET increases with elevation and speed
    $elevationMETFactor = 0.1;  // Adjust as needed
    $speedMETFactor = 0.5;  // Adjust as needed

    return $elevationMETFactor * $elevation + $speedMETFactor * getSpeedFactor($speed);
}

# Helper function to calculate points based on power
function calculatePoints($power) {
    # Your logic to convert power to points
    # Example: Points increase with power
    $basePoints = 10.0;  // Adjust as needed
    $powerPointsFactor = 2.0;  // Adjust as needed

    return $basePoints + $powerPointsFactor * $power;
}

# Helper function to get a speed factor
function getSpeedFactor($speed) {
    # Your logic to convert speed to a factor
    # Example: Faster speeds have a higher factor
    $normalSpeed = 2.0;  // Adjust as needed

    return $speed / $normalSpeed;
}

function calculatePointsAlgorithm($height, $weight, $age, $gender, $distance, 
    $time, $elevation, $difficulty, $stepCount){

    echo "BMI: $age\n";

    # Part 1: Calculate BMR
    $bmr = calculateBMR($height, $weight, $age, $gender);

    # Part 2: Calculate Work Done and Points
    $points = calculateWorkAndPoints($bmr, $distance, $time, $elevation, $difficulty, $stepCount);

    # Display the result
    return $points;
}

?>