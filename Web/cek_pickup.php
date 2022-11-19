<?php
require ('koneksi.php');
$data = $_GET['id_pengantaran'];
mysqli_query($koneksi, "DELETE FROM `pickup` WHERE id_pengantaran = '$data'");
header("Location:pickup.php");
?>