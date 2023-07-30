<?php
  header("Access-Control-Allow-Origin: *");
  header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
  header("Access-Control-Allow-Methods: POST, OPTIONS , GET");

include_once "../../library/function.php";

if(isset($_POST["userId"])){
	
 $userId = filterRequest("userId");
 $selectArray = array();
 array_push($selectArray, $userId);
 $sqlSelect = "SELECT * ,
 (SELECT  image_displaying FROM hall_table WHERE hall_Id = a.hall_id) AS 'image_displaying1' ,
 (SELECT  hall_name FROM hall_table WHERE hall_Id = a.hall_id) AS 'hallName1' ,
 (SELECT  price FROM hall_table WHERE hall_Id = a.hall_id) AS 'price1' ,
 (SELECT  address FROM hall_table WHERE hall_Id = a.hall_id) AS 'address1' 
 FROM booking_hall AS a WHERE user_id = ? ";
 $result = dbExec($sqlSelect, $selectArray);

 $arrJson = array();
	
// $result->rowCount()  : return ( 1  ) is success or ( 0 ) is fail
    if ($result->rowCount() > 0) {
    
     while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
            $temp = array(); 

           $temp['id'] = $row['id'];
           $temp['hallName'] = $row['hallName1'];
           $temp['price'] = $row['price1'];    
           $temp['image_displaying'] = $row['image_displaying1'];  
           $temp['address'] = $row['address1'];
           $temp['date_booking'] = $row['date_booking'];

          array_push($arrJson, $temp);
       
    }
    $resJson = array("success" => true, "message" => "تم جلب البيانات بنجاح", "result" => $arrJson);
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}else{
    $resJson = array("success" => false, "message" => "لم يتم جلب البيانات بنجاح", "result" => null);
    echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}

}else{
   //bad request
   $resJson = array("success" => false, "message" => "لم يتمكن من مصادقة المستخدم", "result" => null);
   echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}

?>