<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";


if(isset($_POST["fullName"]) && isset($_POST["phoneNumber"])&& isset($_POST["password"])&& isset($_POST["emailUser"]) && isset($_POST["address"])){
	
	
 $full_name = htmlspecialchars(strip_tags($_POST["fullName"])) ;
 $phoneNumber =htmlspecialchars(strip_tags($_POST["phoneNumber"]));
 $user_password =htmlspecialchars(strip_tags($_POST["password"]));
 $email_user =htmlspecialchars(strip_tags($_POST["emailUser"]));
 $address =htmlspecialchars(strip_tags($_POST["address"]));
 
 //check username if is exist
 $selectArray = array();
 array_push($selectArray,$phoneNumber );
 $sqlCheck = "SELECT * FROM users WHERE phonenumber = ?";
 $resultCheck = dbExec($sqlCheck, $selectArray);
 if($resultCheck->rowCount() > 0){
	 
	$resJson = array("success"=>false,"message" => "المستخدم موجود بالفعل..! ", "result" => null);
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
	 
 }else{
	
 // if username not exist
 
 $insertArray = array();
 
  array_push($insertArray,$full_name);
  array_push($insertArray,$phoneNumber);
  array_push($insertArray,$user_password);
  array_push($insertArray,$email_user);
  array_push($insertArray,$address);
  
   $sqlInsert = "INSERT INTO users (full_name , phonenumber  , password ,email ,address) VALUES(? , ? , ?,?,?)";
		
   $resultInsert = dbExec($sqlInsert, $insertArray);
   // $result : is return ( true ) if success execute query or insert or update
   if($resultInsert){
	   
	   // fetch data registeration to mobile
	   
	$selectArray1 = array();
    array_push($selectArray1, $phoneNumber);
    $sqlSelect = "SELECT * FROM users WHERE phonenumber = ?";
    $result = dbExec($sqlSelect, $selectArray1);
	
	
	// $result->rowCount()  : return ( 1  ) is success or ( 0 ) is fail
	if ($result->rowCount() > 0) {
        
        $row = $result->fetch(PDO::FETCH_ASSOC);

        $arrJson =array("userId"=>$row['admin_id'] ,
                        "password"=>$row['password'], );

        $resJson = array("success"=>true,"message" => "تم التسجيل بنجاح", "result" => $arrJson);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
		
        
    }
	  
	
	
   }else{
	
    $resJson = array("success"=>false,"message" => "لم يتم التسجيل بنجاح", "result" => null);
   echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}	 
	 
 }
 
	
}else{
	 //bad request
     
     $resJson = array("success"=>false,"message" => "لم يتمكن من المصادقة ", "result" => null);
     echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}

?>