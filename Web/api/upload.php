<?php
header('Content-Type: application/json; charset=utf8');
require_once('koneksi.php');

// if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_FILES['image']['name'])) {
        $gambar = $_FILES['image']['name'];
        $imagePath = "uploads/".$image;
        move_uploaded_file($_FILES['image']['tmp_name'],$imagePath);

        // $query = "INSERT INTO `pickup`(`id_pengantaran`, `gambar1`) VALUES ('P-00000005','$gambar')";
        // $cek = mysqli_query($connect, $query);
        // $count = mysqli_num_rows($cek);

        // if($count == 1){
        //         $sql1 = mysqli_query($connect, "SELECT max(id_pengantaran) as kodeTerbesar FROM pickup");
        //         $data = mysqli_fetch_array($sql1);
        //         $id = $data['kodeTerbesar'];
        //         $urutan = (int) substr($id, 5, 5);
        //         $urutan++;  
        //         $huruf = "P-";
        //         $idPengguna = $huruf . sprintf("%05s", $urutan);
        //         // echo $idPengguna;
        //     echo json_encode("berhasil");
        // } else {
        //     echo json_encode("gagal");
        // }
	}
// } else {
//     echo json_encode(
//         array(
//             'code' => 400,
//             'status' => 'REQUEST METHOD GAGAL!!!',
//         )
//     );
// }
?>