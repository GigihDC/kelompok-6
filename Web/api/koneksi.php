<?php 
$connect = new mysqli("localhost","root","","rushbin");
if($connect){
}else{
	echo "Connection Failed";
	exit();
}
?>