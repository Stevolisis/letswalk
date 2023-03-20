<?php
    require_once 'vendor/autoload.php';
    use Kreait\Firebase\Factory;
    $factory = (new Factory)->withServiceAccount('./firebase.json');
?>

<?php

    $uid = 'some-uid'.rand();
    $additionalClaims = [
        'premiumAccount' => true
    ];
    $response = new stdClass();
    global $students;
    $students = array();
    $stdOne = new stdClass();
    $stdOne->regNo = '18/000155U/2';
    $stdOne->password = 12345;
    $students[] = $stdOne;
    $stdTwo = new stdClass();
    $stdTwo->regNo = '18/000255U/2';
    $stdTwo->password = 123456;
    $students[] = $stdTwo;
    $stdThree = new stdClass();
    $stdThree->regNo = '18/000355U/2';
    $stdThree->password = 1234567;
    $students[] = $stdThree;

    try{
        $auth = $factory->createAuth();
        $customToken = $auth->createCustomToken($uid, $additionalClaims);
        $customTokenString = $customToken->toString();
        if(isset($_POST['regNo'])&&isset($_POST['password'])){
            function checkStudent(){
                global $students;
                $regNo=$_POST['regNo'];
                $password=$_POST['password'];

                foreach ($students as $student) {
                    if ($student->regNo == $regNo && $student->password == $password) {
                        return true;
                    } 
                }
            };

            $exist=checkStudent();

                if ($exist) {
                    $response->status = 'success';
                    $response->token = $customTokenString;
                    header("HTTP/1.1 200");
                    echo json_encode($response); 
                }else{
                    $response->status = 'Invalid Credentials';
                    header("HTTP/1.1 401");
                    echo json_encode($response); 
                }        
        }else{
            $response->status = 'Invalid Fields';
            header("HTTP/1.1 404");
            echo json_encode($response); 
        }

		
	}catch(Exception $e){
		$response->status = 'error';
		$response->errorMessage = $e->getMessage();
		header("HTTP/1.1 404");
		echo json_encode($response);
	}

?>