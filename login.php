<?php
// include 'conn.php';
// $db = mysqli_connect('localhost','root','','rushbin');
// $username = $_POST['username'];
// $password = $_POST['password'];
// $sql = "SELECT * FROM akun WHERE username '".$username."' AND password = '".$password."'";
// $result = mysqli_query($connect,$sql);
// $count = mysqli_num_rows($result);
// if($count == 1){
// 	echo json_encode("berhasil login"); 
// } else {
// 	echo json_encode("gagal login");
// }
?>

<?php
header('Content-Type: application/json; charset=utf8');
require_once('conn.php');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['username']) && $_GET['username'] != "" && isset($_GET['password']) && $_GET['password'] != "" ) {
        $username = $_GET['username'];
        $password = $_GET['password'];
        $query = "SELECT * FROM akun WHERE username='$username' AND password ='$password'";
        $cek = mysqli_query($connect, $query);
        $count = mysqli_num_rows($cek);

        if($count == 1){
            echo json_encode("berhasil login");
        } else {
            echo json_encode("gagal login");
        }
	}
} else {
    echo json_encode(
        array(
            'code' => 400,
            'status' => 'REQUEST METHOD GAGAL!!!',
        )
    );
}
?>