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
                    <div class="navbar-collapse collapse">
                        <ul id="menu-top" class="nav navbar-nav navbar-left">
                            <li><a href="home.php" class="menu-top-active">HOME</a></li>
                           
                            <li><a href="transaksi.php">TRANSAKSI</a></li>
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
    <div id="slideshow-sec">
        <div id="carousel-div" class="carousel slide" data-ride="carousel" >
                   
                    <div class="carousel-inner">
                        <div class="item active">

                            <img src="assets/img/1.jpg" alt="" />
                            <div class="carousel-caption">
                          <h1 class="wow slideInLeft" data-wow-duration="2s" > Multi Pager Template</h1>      
                                 <h2 class="wow slideInRight" data-wow-duration="2s" >Muti Purpose Use</h2>  
                            </div>
                           
                        </div>
                        <div class="item">
                            <img src="assets/img/2.jpg" alt="" />
                            <div class="carousel-caption">
                          <h1 class="wow slideInLeft" data-wow-duration="2s" >Awesome Usage</h1>      
                                 <h2 class="wow slideInRight" data-wow-duration="2s" >Bootstrap 3.2</h2>  
                            </div>
                        </div>
                        <div class="item">
                            <img src="assets/img/3.jpg" alt="" />
                            <div class="carousel-caption">
                          <h1 class="wow slideInLeft" data-wow-duration="2s" >Easy To Customize </h1>      
                                 <h2 class="wow slideInRight" data-wow-duration="2s" >Free To Download</h2>  
                            </div>
                           
                        </div>
                    </div>
                    <!--INDICATORS-->
                     <ol class="carousel-indicators">
                        <li data-target="#carousel-div" data-slide-to="0" class="active"></li>
                        <li data-target="#carousel-div" data-slide-to="1"></li>
                        <li data-target="#carousel-div" data-slide-to="2"></li>
                    </ol>
                    <!--PREVIUS-NEXT BUTTONS-->
                     <a class="left carousel-control" href="#carousel-div" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left"></span>
  </a>
  <a class="right carousel-control" href="#carousel-div" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right"></span>
  </a>
                </div>
    </div>
    <!-- SLIDESHOW SECTION END-->
    <div class="below-slideshow">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="txt-block">
                        <h1 class="head-line">Daftar Sampah</h1>	
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- BELOW SLIDESHOW SECTION END-->
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            </br></br>
            <table border="1" class="table table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th class="tbl text-center">No</th>
                        <th class="tbl text-center">ID SAMPAH</th>
                        <th class="tbl text-center">NAMA SAMPAH</th>
                        <th class="tbl text-center">JENIS SAMPAH</th>
                        <th class="tbl text-center">JUMLAH SAMPAH</th>
                        <th class="tbl text-center">POINT</th>
                    </tr>
                </thead>
                <tbody>

                    <?php
                    include 'koneksi.php';
                    $sql = "SELECT * FROM daftar_sampah";
                    $hasil = mysqli_query($koneksi,$sql);
                    $nomer = 1;
                    while($data = mysqli_fetch_array($hasil,MYSQLI_ASSOC)){
                    ?>
                    
                    <tr>
                        <td class="no text-center"><?php echo $nomer++; ?></td>
                        <td><?php echo $data['id_sampah']; ?></td>
                        <td><?php echo $data['nama_sampah']; ?></td>
                        <td><?php echo $data['jenis_sampah']; ?></td>
                        <td class="jumlah text-center"><?php echo $data['jumlah_sampah']; ?></td>
                        <td class="jumlah text-center"><?php echo $data['point']; ?></td>
                    </tr>
                    
                    <?php 
                    }
                    ?>
                </tbody>
            </table>
                <br /><hr />
            </div>
        </div>
    </div>
     <!-- TAG HOME SECTION END-->
     <div class="container " >
             <div class="row">
            <div class="col-lg-10 col-md-10 col-sm-10 col-lg-offset-1 col-md-offset-1 col-sm-offset-1 col-xs-12 set-div">
                <div class="just-txt-div text-center">
                    <h3><strong>-- Download Aplikasi Mobile rushbin --</strong> </h3>
                    <p>
                         Rushbin merupakan aplikasi berbasis mobile untuk membantu warga dalam melakukan transaksi jual sampah bekas yang dapat di daur ulang 
                      <br /><br />
                    </p>
                      <a class="btn btn-info btn-lg" href="#">Info Lebih lanjut</a>
                    &nbsp;&nbsp;
                    <a class="btn btn-success btn-lg" href="#">Download Aplikasi</a>
                </div>
               
                </div>
            </div>
         </div>
      <!--SET-DIV SECTION END-->
   
   <div class="footer-sec">
    <div class="container">
        <div class="row">
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 social-div">
                <h3> <strong>CONTACT PERSON</strong> </h3>
                <br />
                <a href="#" ><h4>WHATSAPP: 082331879753 </h4></a>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 social-div">
                <h3> <strong>SOCIAL MEDIA</strong> </h3>
                <br />
                <a href="#" ><h4>FACEBOOK </h4></a>
                <a href="#" ><h4>TWITTER </h4></a>
                <a href="#" ><h4>INSTAGRAM </h4></a>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                <h3> <strong>ALAMAT KANTOR</strong> </h3>
                <br />
                <h4>Jalan Menuju Kenangan indah no.33,</h4>
                <h4>Talangsari, JEMBER,</h4>
                <h4>INDONESIA</h4>
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
<!--CUSTOM SCRIPTS -->
<script src="assets/js/custom.js"></script>
</body>

</html>
