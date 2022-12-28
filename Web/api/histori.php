<?php
header('Content-Type: application/json; charset=utf8');
require_once('koneksi.php');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['id_pengguna']) && $_GET['id_pengguna'] != "") {
        $idPenukaran = $_GET['id_pengguna'];
        $query = "SELECT * FROM penukaran WHERE id_pengguna='$idPenukaran'";
        $cek = mysqli_query($connect, $query);
        $nomer=1;
        while($data = mysqli_fetch_array($cek,MYSQLI_ASSOC)){
            echo $nomer++;
            echo $data['id_penukaran'];
            echo $data['point'];
            echo $data['nominal'];
            echo $data['tanggal'];
            echo $data['waktu']; 
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