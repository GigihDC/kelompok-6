<?php
require_once('koneksi.php');
$sql2 = mysqli_query($connect, "SELECT max(id_pengguna) as kodeTerbesar FROM pengguna");
$data = mysqli_fetch_array($sql2);
$idPengguna = $data['kodeTerbesar'];
$urutan = (int) substr($idPengguna, 5, 5);
$urutan++;  
$huruf = "P-";
$idPengguna = $huruf . sprintf("%05s", $urutan);
echo $idPengguna;
if (isset($_POST['kodeTerbesar'])) {
    $idPengguna=$_POST['kodeTerbesar'];
}
?>