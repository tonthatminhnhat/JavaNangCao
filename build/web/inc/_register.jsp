<section class="vh-80" style="background-color: pink; margin-top: 100px">
    <style>
        .formnhap{border: none; margin-bottom: 40px!important}
        
        </style>
    <div class="container h-100">
        <div class="row justify-content-center align-items-center h-100">
            <div class="col-lg-12 col-xl-11">
                <div class="card text-black" style="border-radius: 25px;">
                    <div class="card-body p-md-2">
                        <div class="row justify-content-center">
                            <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">

                                <p class="text-center h1 fw-bold mb-3 mx-1 mx-md-4 mt-4">Sign up</p>
                                <span style="color:red; margin-left: 40px;font-size:21px" >${exits_user}</span>
                                <form class="mx-1 mx-md-4" action="" method="post">

                                    <div class="d-flex flex-row align-items-center mb-3 formnhap" >
                                        <i class="fas fa-user fa-lg me-3 fa-fw"style="height: 100%;"></i>
                                        <div class="form-outline flex-fill mb-0">
                                            <label class="form-label" for="form3Example1c">Your Name:</label>
                                            <input type="text" name="name" class="form-control"  style="border: 1px solid gray;"required="required"/>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-3 formnhap">
                                        <i class="fas fa-envelope fa-lg me-3 fa-fw"style="height: 100%;"></i>
                                        <div class="form-outline flex-fill mb-0">
                                            <label class="form-label" for="form3Example3c">Your Email:</label>
                                            <input type="text" name="email" style="border: 1px solid gray;" class="form-control"required="required" />
                                            <span style="color:red" > ${err_email}</span>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-3 formnhap">
                                        <i class="fas fa-envelope fa-lg me-3 fa-fw"style="height: 100%;"></i>
                                        <div class="form-outline flex-fill mb-0">
                                            <label class="form-label" for="form3Example3c">Your Phone:</label>
                                            <input type="text" name="phone"  style="border: 1px solid gray;"class="form-control"required="required" />
                                            <span style="color:red" >${err_phone}</span>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-3 formnhap">
                                        <i class="fas fa-lock fa-lg me-3 fa-fw"style="height: 100%;"></i>
                                        <div class="form-outline flex-fill mb-0">
                                            <label class="form-label" for="form3Example4c">Password:</label>
                                            <input type="password" style="border: 1px solid gray;" name="password" class="form-control" required="required"/>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-3 formnhap">
                                        <i class="fas fa-key fa-lg me-3 fa-fw" style="height: 100%;"></i>
                                        <div class="form-outline flex-fill mb-0">
                                            <label class="form-label" for="form3Example4cd">Retype password:</label>
                                            <input type="password"  style="border: 1px solid gray;"name="repassword" class="form-control" required="required"/>
                                            <span style="color:red" >${err_pass}</span>
                                        </div>
                                    </div>

                                    <div class="form-check d-flex justify-content-center mb-3 formnhap">
                                        <input class="form-check-input me-2" type="checkbox" value="" id="form2Example3c" />
                                        <label class="form-check-label" for="form2Example3">
                                            I agree all statements in <a href="#!">Terms of service</a>
                                        </label>
                                    </div>

                                    <div class=" justify-content-center mx-4 mb-3 mb-lg-4">
                                        <button type="submit" class="btn btn-primary btn-lg">Register</button>
                                    </div>

                                </form>

                            </div>
                            <div class="col-md-10 col-lg-6 col-xl-7 align-items-center order-1 order-lg-2" style="margin-top: 100px;">

                                <img src="https://file.hstatic.net/200000315407/article/cac_kieu_do_bo_mac_nha_tro_thanh_xu_huong_2023__5__64c5ebcc56f14a8b8ebf4db3a8d04939_1024x1024.jpg"
                                     onclick="window.location.href ='https://thoitrangquelam.vn/blogs/news/cac-kieu-do-bo-mac-nha-tro-thanh-xu-huong-2023'"
                                     class="img-fluid" alt="Sample image">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <style>
        .form-label {
            font-style: normal;
        }
        *, ::after, ::before {
 font-style: normal;
}
    </style>
</section>
