<section class="vh-100">
  <div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-md-9 col-lg-6 col-xl-5" onclick="window.location.href ='https://thoitrangquelam.vn/blogs/news/top-nhung-kieu-do-bo-dep-nhat-2022'">
        <img src="https://file.hstatic.net/200000315407/article/top_nhung_kieu_do_bo_dep_nhat_2022_3725a45eb70c4a3f99e23b7fcd3fb7b9_1024x1024.jpg"
          class="img-fluid" alt="Sample image">
      </div>
      <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
        <form action="" method="post">
            <h2 style=""padding:30px 0 30px 0;">Information Login</h2>
            <div class="link-danger">${error_login}</div>
          <!-- Email input -->
          <div class="form-outline mb-4">
            <input type="text" name="emailphone" id="form3Example3" class="form-control form-control-lg"
              placeholder="Enter email address or phone number" />
         
          </div>

          <!-- Password input -->
          <div class="form-outline mb-3">
            <input type="password" name="password" id="form3Example4" class="form-control form-control-lg"
              placeholder="Enter password" />
           
          </div>

          <div class="d-flex justify-content-between align-items-center">
            <!-- Checkbox -->
            <div class="form-check mb-0">
              <input class="form-check-input me-2" type="checkbox" value="" id="form2Example3" />
              <label class="form-check-label" for="form2Example3">
                Remember me
              </label>
            </div>
            <a href="#!" class="text-body">Forgot password?</a>
          </div>

          <div class="text-center text-lg-start mt-4 pt-2">
            <button type="submit" class="btn btn-primary btn-lg"
              style="padding-left: 2.5rem; padding-right: 2.5rem;">Login</button>
            <p class="small fw-bold mt-2 pt-1 mb-0">Don't have an account? 
                <a href="register"
                class="link-danger" >Register</a></p>
          </div>

        </form>
      </div>
    </div>
  </div>
  
</section>
<style>
    .divider:after,
.divider:before {
content: "";
flex: 1;
height: 1px;
background: #eee;
}
.h-custom {
height: calc(100% - 73px);
}
@media (max-width: 450px) {
.h-custom {
height: 100%;
}
}
</style>