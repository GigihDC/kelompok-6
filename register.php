<?php
$db = mysqli_connect('localhost','root','','rushbin');
if(!$db)
{
	echo "Database connection failed";
}
$username = $_POST['username'];
$password = $_POST['password'];

$sql = "SELECT username FROM akun WHERE username = '".$username."'";
$result = mysqli_query($db,$sql);
$count = mysqli_num_rows($result);
if($count == 1){
	echo json_encode("Error");
}else{
	$insert = "INSERT INTO akun(username,password) VALUES ('".$username."','".$password."')";
		$query = mysqli_query($db,$insert);
		if($query){
			echo json_encode("Success");
		}
}
?>