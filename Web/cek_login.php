<?php 
require('koneksi.php');
session_start();

if(isset($_POST['submit'])){
    $email = $_POST['txt_email'];
    $pass = $_POST['txt_pass'];

    if(!empty(trim($email)) && !empty(trim($pass))){
        $query = "SELECT * FROM akun WHERE username='$email'";
        $result = mysqli_query($koneksi,$query);
        $num = mysqli_num_rows($result);

        while ($row = mysqli_fetch_array($result)){
            $userVal = $row['username'];
            $passVal =$row['password'];
            $level = $row['role'];
        }

        if($num != 0){
            if($userVal==$email && $passVal==$pass && $level=="admin"){
                header('Location:home.php?'
                // 'user='.urlencode($username)
            );
                $_SESSION['username'] = $username;
                $_SESSION['role'] = $level;
                $_SESSION['status'] = "login";
            }elseif($userVal==$email && $passVal==$pass && $level=="user"){
                header('Location:index.php?pesan=user');
            }
            else{
                header('Location:index.php?pesan=gagal');
            }
        }else{
            header('Location:index.php?pesan=salah');
        }
    }else{
        header('Location:index.php?pesan=kosong');
    }
}

?>