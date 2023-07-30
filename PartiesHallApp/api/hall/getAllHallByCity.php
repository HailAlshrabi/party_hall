<?php
  header("Access-Control-Allow-Origin: *");
  header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With, Access-Control-Allow-Origin");
  header("Access-Control-Allow-Methods: POST, OPTIONS , GET");

include_once "../../library/function.php";

if(isset($_POST["city"])){
	
 $city = filterRequest("city");
 $selectArray = array();
 array_push($selectArray, $city);
 $sqlSelect = "SELECT * ,(SELECT AVG(rating_star) FROM star_rating_hall WHERE hall_id = a.hall_Id) AS 'hall_rating_star' FROM hall_table AS a WHERE city = ? ORDER BY hall_Id DESC";
 $result = dbExec($sqlSelect, $selectArray);

 $arrJson = array();
	
// $result->rowCount()  : return ( 1  ) is success or ( 0 ) is fail
    if ($result->rowCount() > 0) {
    
     while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
            $temp = array(); 

           $temp['hallId'] = $row['hall_Id'];
           $temp['hallName'] = $row['hall_name'];
           $temp['price'] = $row['price'];    
           $temp['address'] = $row['address'];
           $temp['addressDetails'] = $row['address_details'];
           $temp['latitude'] = $row['latitude'];
           $temp['longitude'] = $row['longitude'];
           $temp['image_displaying'] = $row['image_displaying'];
           $temp['image1'] = $row['image1'];
           $temp['image2'] = $row['image2'];
           $temp['image3'] = $row['image3'];
           $temp['phoneNumbers'] = $row['phoneNumbers'];
           $temp['info_hall'] = $row['info_hall'];
           $temp['city'] = $row['city'];
           $temp['hallRatingStar'] = $row['hall_rating_star'];
           $temp['timeStamp'] = $row['time_stamp'];

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