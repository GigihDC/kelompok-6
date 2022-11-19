<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
      <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>Rushbin - BankSampah.apk</title>

    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- ANIMATE STYLE  -->
    <link href="assets/css/animate.css" rel="stylesheet" />
    <!-- FLEXSLIDER STYLE  -->
    <link href="assets/css/flexslider.css" rel="stylesheet" />
    <!-- PRETTY PHOTO FOR GALLERY  -->
    <link href="assets/css/prettyPhoto.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="assets/css/style.css" rel="stylesheet" />
    <!-- GOOGLE FONTS  -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:300' rel='stylesheet' type='text/css' />
     <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link href='http://fonts.googleapis.com/css?family=Lobster' rel='stylesheet' type='text/css' />
</head>
<body>

<?php 
session_start();
if ($_SESSION['status']!="login") {
    header("location:index.php?pesan=belum_login");
}
?>

 <div class="navbar navbar-inverse set-radius-zero" >
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="home.php">

                    <img src="assets/img/portfolio/logo.png" />
                </a>

            </div>
            <div class="right-div">
<strong>Support : </strong>  tRushMeBin@gmail.com
            </div>
          
        </div>
    </div>
    <!-- LOGO HEADER END-->
    <section class="menu-section">
        <div class="container">
            <div class="row ">
                <div class="col-md-12">
                    <div class="navbar-collapse collapse ">
                        <ul id="menu-top" class="nav navbar-nav navbar-left">
                            <li><a href="home.php">HOME</a></li>
                           
                            <li><a href="transaksi.php" class="menu-top-active">TRANSAKSI</a></li>
                            <li><a href="laporan.php">LAPORAN</a></li>
                            <li><a href="pickup.php">PICKUP</a></li>
                            <li><a href="customer.php">INFORMASI CUSTOMER</a></li>
                            <li><a href="about.php">ABOUT US</a></li>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </section>
     <!-- MENU SECTION END-->
  
    <div class="below-slideshow">
         <div class="container">
        <div class="row">
            
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="txt-block">

              
									<h1 class="head-line">TRANSAKSI</h1>
									
                      </div>
            </div>
        </div>

    </div>
    </div>
    <!-- AKHIR JUDUL -->

    <div class="container">
    <div class="col-md-9">
        <div class="card">
            <div class="card-header p-2">
                <ul class="nav nav-pills">
                  <li class="nav-item"><a class="nav-link active" href="#activity" data-toggle="tab">TRANSAKSI JUAL</a></li>
                  <li class="nav-item"><a class="nav-link" href="#timeline" data-toggle="tab">TRANSAKSI BELI</a></li>
                </ul>
            </div>
            <div class="card-body">
                <div class="tab-content">
                  <div class="active tab-pane" id="activity">

                  <div>
                        <form name = "satu" action="tambah.php" method="post">
                        <!-- <div class="form-group">
                            <label for="jenis">Jenis Sampah :</label>
                            &ensp;&ensp;
                            <select name="jenis" id="Jenis" class="form" style="width: 78%;" required>
                                <option value="">- Pilih Jenis Sampah -</option>
                                <option value="sampah plastik">Sampah Plastik</option>
                                <option value="sampah kaca">Sampah Kaca</option>
                                <option value="sampah kertas">Sampah Kertas</option>
                                <option value="sampah kayu">Sampah Kayu</option>
                                <option value="sampah besi">Sampah Besi</option>
                                <option value="sampah kain">Sampah Kain</option>
                            </select>
                        </div> -->
                        <div class="form-group">
                            <label for="kode">ID Sampah :</label>
                            &ensp;&ensp;&ensp;&ensp;
                            <input type="text" name ="kode" id="kode" class="form" style="width: 30%;" 
                            placeholder="Masukan id sampah" required>
                            &ensp;&ensp;
                            <label for="nama">Nama Sampah :</label>
                            &ensp;
                            <input type="text" name ="nama" id="nama" class="form" style="width: 30%;" 
                            placeholder="Masukan nama sampah" required>
                        </div>
                        <div class="form-group">
                            <label for="quantity">Total Sampah :</label>
                            &ensp;&ensp;
                            <input type="text" name ="quantity" id="quantity" class="form" style="width: 78%;"
                            placeholder="Masukan jumlah sampah per kg" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Simpan</button>

                        <div>
                  </br></br>
                    <table border="1" class="table table-bordered">
                            <thead class="thead-dark">
                                <tr>
                                    <th class="tbl text-center">No</th>
                                    <th class="tbl text-center">ID SAMPAH</th>
                                    <th class="tbl text-center">NAMA SAMPAH</th>
                                    <th class="tbl text-center">TOTAL SAMPAH</th>
                                    <th class="tbl text-center">POINT per KG</th>
                                    <th class="tbl text-center">TOTAL POINT</th>
                                </tr>
                            </thead>
                            <tbody>
                            <?php 
                            $no=1;
                            $kode = $_POST['kode'];
                            $nama = $_POST['nama'];
                            $jumlah = $_POST['quantity'];
                            ?>
                            <tr>
                                <td>1</td>
                                <td>{{ $item->tiket->name_tiket }}</td>
                                <td>{{ $item->qty }}</td>
                                <td>{{ $item->tiket->harga_tiket }}</td>
                                <td>{{ $item->tiket->harga_tiket*$item->qty }}</td>
                                <td><button type="submit" class="btn btn-danger">Cancel</button></td></tr>
                                <?php $no++ ?>
                                <?php $total=$total+($item->tiket->harga_tiket*$item->qty) ?>
                            </tr>
                            </tbody>
                        </table>
                        </br></br><hr>
                </div>
                        
                        </div>
                        <button type="submit" class="btn btn-primary">Bayar</button>
                        </form>

                    </div>
                  <div class="tab-pane" id="timeline">
                  <div>
                  </br></br>
                    <table border="1" class="table table-bordered">
                            <thead class="thead-dark">
                                <tr>
                                    <th class="tbl text-center">No</th>
                                    <th class="tbl text-center">KODE TRANSAKSI</th>
                                    <th class="tbl text-center">TANGGAL</th>
                                    <th class="tbl text-center">WAKTU</th>
                                    <th class="tbl text-center">NAMA PEGAWAI</th>
                                    <th class="tbl text-center">TOTAL POINT</th>
                                </tr>
                            </thead>
                            <tbody>

                            <?php
                            include 'koneksi.php';
                            $sql = "SELECT * FROM transaksi_beli";
                            $hasil = mysqli_query($koneksi,$sql);
                            $nomer = 1;
                            while($data = mysqli_fetch_array($hasil,MYSQLI_ASSOC)){
                            ?>
                            
                            <tr>
                                <td class="no text-center"><?php echo $nomer++; ?></td>
                                <td><?php echo $data['kode_transaksi']; ?></td>
                                <td><?php echo $data['tanggal']; ?></td>
                                <td><?php echo $data['waktu']; ?></td>
                                <td><?php echo $data['nama_pegawai']; ?></td>
                                <td><?php echo $data['total_point']; ?></td>
                            </tr>
                            
                            <?php 
                            }
                            ?>
                            </tbody>
                        </table>
                        </br></br><hr>
                </div>
                  </div>
                </div>
              </div>
            </div>
        </div>
    </div>
     <!-- AKHIR ISI -->
     
   <div class="footer-sec">
         <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">

              
									<h3> <strong>ABOUT COMPANY</strong> </h3>
									<p style="padding-right:50px;" >
										Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sagittis felis dolor vitae.
                                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sagittis felis dolor vitae.
									</p>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 social-div">
               

              
										<h3> <strong>SOCIAL PRESENCE</strong> </h3>
                We love to be social,Catch Us On
                <a href="#" ><h4>FACEBOOK </h4></a>
                   <a href="#" ><h4>TWITTER </h4></a>
                 <a href="#" ><h4>LINKEDIN </h4></a>
									
                    
            </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
            <h3> <strong>PHYSICAL LOCATION</strong> </h3>
                Reach Us Below:
                <br />
                <h4>90/567, Raw Street Lane,</h4>
                 <h4>United States of America,</h4>
                 <h4>Pin: 309987-09</h4>
            </div>
        </div>
 <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <hr />
                <div style="text-align:right;padding:5px;">
                    &copy;2014 yourdomain.com | <a href="http://www.binarytheme.com/" style="color:#fff;" target="_blank" >Designed By: Binarytheme.com</a>
                </div>
            </div>
    </div>
    </div>
       </div>
     <!--FOOTER SECTION END-->
      <!-- WE PUT SCRIPTS AT THE END TO LOAD PAGE FASTER-->

  <!--CORE SCRIPTS PLUGIN-->
    <script src="assets/js/jquery-1.11.1.min.js"></script>
     <!--BOOTSTRAP SCRIPTS PLUGIN-->
<script src="assets/js/bootstrap.js"></script>
     <!--WOW SCRIPTS PLUGIN-->
    <script src="assets/js/wow.js"></script>
     <!--FLEXSLIDER SCRIPTS PLUGIN-->
    <script src="assets/js/jquery.flexslider.js"></script>
     <!--PRETTY PHOTO FOR GALLERY -->
    <script src="assets/js/jquery.prettyPhoto.js"></script>
     <!--PHOTO FILTER -->
    <script src="assets/js/jquery.mixitup.min.js"></script>
     <!--CUSTOM SCRIPTS -->
    <script src="assets/js/custom.js"></script>
</body>

</html>
