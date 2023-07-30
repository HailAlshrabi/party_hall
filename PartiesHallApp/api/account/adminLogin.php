<?php


include_once "../../library/function.php";

if(isset($_POST["phoneNumber"])&& isset($_POST["password"])){
	
 $phoneNumber =htmlspecialchars(strip_tags($_POST["phoneNumber"]));
 $user_password =htmlspecialchars(strip_tags($_POST["password"]));
 
    $selectArray = array();
    array_push($selectArray, $phoneNumber);
    array_push($selectArray, $user_password);
    $sql = "SELECT * FROM admin WHERE phonenumber = ? AND password = ? ";
    $result = dbExec($sql, $selectArray);
	
	
	// $result->rowCount()  : return ( 1  ) is success or ( 0 ) is fail
		if ($result->rowCount() > 0) {


            $row = $result->fetch(PDO::FETCH_ASSOC);

            $arrJson =array("userId"=>$row['admin_id'] ,
                            "password"=>$row['password'],
                            "Phonenumber"=>$row['phonenumber']
                            
                             );

		
        $resJson = array("success"=>true,"message" => "تم تسجيل الدخول بنجاح", "result" => $arrJson);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }else{
	
		 $resJson = array("success"=>false,"message" => " إسم المستخدم او كلمة المرور غير صحيحة", "result" => null);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
	}
		
	
}else{
	 //bad request
     
    $resJson = array("success"=>false,"message" => "لم يتمكن من المصادقة ", "result" => null);
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    
}



?>