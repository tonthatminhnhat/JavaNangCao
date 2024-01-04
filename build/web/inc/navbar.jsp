<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="nhat.utils.API" %>

<header> 
   <style>
    .navbar-collapse li{ border-radius: 20px;padding: 9px;padding-left: 10px;margin-left: 1px;
    padding-right: 10px;display: flex;color: #fd4783;height: 36px;cursor: pointer;
 }
 .me-2{margin:0!important; }
 .me-2:focus{box-shadow:none;border: 1px solid #fd4783;background:#fff;}
 .navbar-nav h5 { color:#fd4783; font-size:14px; font-weight: 600; }
 .navbar-collapse li:hover{background: #fde6ea;width: auto;}
  .navbar-collapse li:hover .menu{opacity:1;pointer-events: all;}
  .navbar-collapse li:hover #showtable1{opacity: 1; pointer-events: all;}
  .navbar-collapse li:hover #tenloai1{color:white}
.btn-outline-success:focus{box-shadow:none;}

.d-flex{border:1px solid #ced4da ;border-radius:30px; padding-left:10px;height: 36px;padding-right: 12px}
.d-flex:hover{border-color: #fd4783;}
.d-flex:focus-within{border-color: #fd4783;}

.d-flex:hover .btn-outline-success{border-color: #fd4783;border-left:none;
}
.btn-outline-success{color: #fff;font-weight: 600;background: #fd4783; border-radius:0 30px 30px 0;border:none;
}
.me-auto {
     margin-right: 0!important;
}
.btn-outline-success:hover{background-color:#fd4783}
.btn-outline-success:active:focus{background-color: #fe97a8; box-shadow: none;}
.navbar-toggler-icon{outline:none}
.navbar-toggler:focus{    box-shadow: none;}
.bg-body-tertiary{background: white; padding: 0 1% 0 1%; border-bottom: 1px solid #eee;}

@media (min-width: 1000px) {
  .my-div {width: 200px;}
  .bg-body-tertiary1{padding: 0 10% 0 10%}
}
   .menu{height: auto;width: auto; position: absolute; padding-top: 22px;transition: all 0.3s linear;opacity: 0;pointer-events: none;top: 45px;}
  .khungmenu{width: 810px;box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;
    border-radius: 15px;overflow: hidden;background-color:white;}
  .leftdobo{height: 100%;}
  .material-symbols-outlined {color: black;font-variation-settings:'FILL' 1,'wght' 400,'GRAD' 200,'opsz' 48}
  .showtable p{margin: 0;font-size: 14px;line-height: 1;
    font-weight: 600;color:white;font-family: Segoe UI,sans-serif;}
  .tenloai{margin: 0;font-size: 14px;line-height: 1;
    font-weight: 600;color:#646363;font-family: Segoe UI,sans-serif;}
  .showtable p{color: white;}
  
  .iconplay{position:absolute;width: auto;left: 162.2px;color:rgba(255, 255, 255, 0);;}
  .loai{width: 170px
  ;height:58px;background-color:#fff;border-top: 1px solid gainsboro;
    padding:6px;padding-left: 24px;display: flex;justify-content: center;flex-direction: column;
    border-right: 1px solid gainsboro;}
  .loai:hover{background-color:#fd4783;border-right: 1px solid #fd4783;}
  .loai:hover .iconplay{color: #fd4783;}
  .loai:hover .tenloai{color: white;}
  .loai:hover .tenvai{color: white;}
  .loai:hover .showtable{opacity: 1; pointer-events: all;}
  
  #loai1{background-color:#fd4783;border-right: 1px solid #fd4783; border-top: none}
  #tenloai{color:white}
  #iconplay1{color:#fd4783}

  .tenvai{margin: 0; margin-top: 5px;font-size:  12px;color: #7a7878;margin-left: 5px;font-weight: 600;}
  .tenvai span{margin-right: 5px;}
  .showtable{ height: 348px;width: 640px;position: absolute;  display: flex;
    top: 22px;border-radius: 15px;padding: 20px;padding-right: 0px;
    padding-left: 23px;flex-wrap: nowrap;overflow: auto;right: 0px;
    justify-content: flex-start;opacity: 0;pointer-events: none;
    transition: all 0.3s linear;display: flex;flex-direction: row;
    flex-wrap: wrap;justify-content: flex-start;align-items: flex-end;align-content: flex-start;}
  .anhdobo{height:120px;width: 90PX;border-radius: 15px;overflow: hidden;
  text-align: center;border: 1px solid gainsboro;margin-bottom: 10px;margin-right:10px; position: relative;
  transition: all 0.1s linear ;}
  .anhdobo:hover{border: 1px solid orange;transform: translateY(-2px);}
  .anhdobo img{ width: 100%;height: 100%;
object-fit: cover;}
  .anhdobo p{color: white; font-size: 13px;
    position: absolute;
    bottom: -4px;
    line-height: 1.2;
    font-weight: 500;
    background: linear-gradient(180deg,#fff,transparent .01%,rgba(0,0,0,.6));
    width: 100%;
    text-align: center;padding: 6px;
    padding-top: 10px;
    padding-bottom: 8px;}
  .tendanhmuc{width: 100%; margin-bottom: 15px;font-size: 16px;line-height: 1;
    font-weight: 600;color:#fd4783;font-family: Segoe UI,sans-serif;}
   </style>
   <nav class="navbar navbar-expand-lg bg-body-tertiary bg-body-tertiary1" 
   style=" position: fixed; z-index: 1041;background: white!important;
   box-shadow: rgba(0, 0, 0, 0.1) 0px 2px 8px; top:0px;   width: 100%;">
  <div class="container-fluid" style="background:white">
   <img onclick="window.location.href ='http://localhost:8080/Hoadobo/home'"
       src="https://i.gyazo.com/c08008914ec32e4c1b2742d856e89e4a.png" width=180px style="cursor:pointer;">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"><i class="fa-solid fa-bars"></i></span>
    </button>
  
    <div class="collapse navbar-collapse" id="navbarSupportedContent" style="justify-content:center;">
    
      <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="marrgin-right:0!important">      
      <!--  -->
         <li> 
         <i class="fa-solid fa-bag-shopping" style="color: #fd4783;font-size: 20px;
         margin-right: 5px; margin-bottom:2px;position: relative;top: -1px;"></i>
                 <h5>Bạn muốn mua gì ?</h5>               
                 <div class="menu">
        <div class="khungmenu">
          <div class="leftdobo">
              <div class="loai" id="loai1" 
  onclick="window.location.href ='http://localhost:8080/Hoadobo/collection?collection=BC'">
                  <p class="tenloai" id="tenloai1">ĐỒ BỘ BÁN CHẠY</p>
                  <span class="material-symbols-outlined iconplay" id="iconplay1">play_arrow</span>
                  
                  <div class="showtable" id="showtable1"> 

                      <c:forEach items="${listDSSP}" var="listDSSP">
                          <c:if test="${listDSSP.soluongban >1600 &&listDSSP.hethang==false}">
                              <!--<span class="tendanhmuc">${listDSSP.loaivai}</span>-->
                              <c:forEach items="${listAnh}" var="listAnh">
                                  <c:if test="${  listDSSP.madssp == listAnh.madssp}">           
                                      <div class="anhdobo" onclick="event.stopPropagation(); 
                                          window.location.href ='http://localhost:8080/Hoadobo/ChiTietSanPham?idsp=${listDSSP.madssp}&maanh=${ listAnh.maanh}'">
                                          <img src="./assets/images/${listAnh.path}" >
                                          <p>${listAnh.mau}</p></div>
                                      </c:if>                 
                                  </c:forEach>
                              </c:if>
                          </c:forEach>
                  </div>
              </div>
            
            <!-- /////////////Bộ đùi/////////////// -->
            <div class="loai"  onclick="window.location.href ='http://localhost:8080/Hoadobo/collection?collection=BĐ'">
                <p class="tenloai">Bộ Đùi</p>
                <p class="tenvai"> <span>Lụa Satin</span><span> Lanh Tre</span></p>
                <span class="material-symbols-outlined iconplay">play_arrow</span>
                <div class="showtable " >

                    <c:forEach items="${loaiVaiMap['BĐ']}" var="loaivai">
                        <span class="tendanhmuc">${loaivai}</span>
                        <c:forEach items="${listDSSP}" var="listDSSP">                      
                            <c:if test="${  listDSSP.idmodel=='BĐ' && listDSSP.loaivai == loaivai}">                           
                                <c:forEach items="${listAnh}" var="listAnh">
                                    <c:if test="${  listAnh.madssp == listDSSP.madssp}">           
                                        <div class="anhdobo"onclick="event.stopPropagation(); 
                                          window.location.href ='http://localhost:8080/Hoadobo/ChiTietSanPham?idsp=${listDSSP.madssp}&maanh=${ listAnh.maanh}'">
                                            <img src="./assets/images/${listAnh.path}" >
                                            <p>${listAnh.mau}</p></div>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                            </c:forEach>
                        </c:forEach>

                </div>  
            </div>
            <!-- //////////////////////////// -->
            <div class="loai"  onclick="window.location.href ='http://localhost:8080/Hoadobo/collection?collection=BL'">
                <p class="tenloai">Bộ Lửng</p>
                <p class="tenvai"> <span>Chất Đũi</span><span>Lụa Mango</span></p>
                <span class="material-symbols-outlined iconplay">play_arrow</span>
                <div class="showtable " >
                    <c:forEach items="${loaiVaiMap['BL']}" var="loaivai">
                        <span class="tendanhmuc">${loaivai}</span>
                        <c:forEach items="${listDSSP}" var="listDSSP">                      
                            <c:if test="${  listDSSP.idmodel=='BL' && listDSSP.loaivai == loaivai}">                           
                                <c:forEach items="${listAnh}" var="listAnh">
                                    <c:if test="${  listAnh.madssp == listDSSP.madssp}">           
                                        <div class="anhdobo" onclick="event.stopPropagation(); 
                                          window.location.href ='http://localhost:8080/Hoadobo/ChiTietSanPham?idsp=${listDSSP.madssp}&maanh=${ listAnh.maanh}'">
                                            <img src="./assets/images/${listAnh.path}" >
                                            <p>${listAnh.mau}</p></div>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                </div>
            </div>
            <!-- //////////////////////////// -->
            <div class="loai"  onclick="window.location.href ='http://localhost:8080/Hoadobo/collection?collection=BD'">
                <p class="tenloai">Bộ Dài</p>
                <p class="tenvai"> <span>Cotton</span><span>Lanh</span><span>Nỉ</span></p>
                <span class="material-symbols-outlined iconplay">play_arrow</span>
                <div class="showtable " >
                    <c:forEach items="${loaiVaiMap['BD']}" var="loaivai">
                        <span class="tendanhmuc">${loaivai}</span>
                        <c:forEach items="${listDSSP}" var="listDSSP">                      
                            <c:if test="${  listDSSP.idmodel=='BD' && listDSSP.loaivai == loaivai}">                           
                                <c:forEach items="${listAnh}" var="listAnh">
                                    <c:if test="${  listAnh.madssp == listDSSP.madssp}">           
                                        <div class="anhdobo" onclick="event.stopPropagation(); 
                                          window.location.href ='http://localhost:8080/Hoadobo/ChiTietSanPham?idsp=${listDSSP.madssp}&maanh=${ listAnh.maanh}'">
                                            <img src="./assets/images/${listAnh.path}" >
                                            <p>${listAnh.mau}</p></div>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                </div>
            </div>
            <!-- //////////////////////////// -->
            <div class="loai"  onclick="window.location.href ='http://localhost:8080/Hoadobo/collection?collection=BP'">
                <p class="tenloai">Bộ Pijama</p>
                <p class="tenvai"> <span>Lụa</span><span> Chất Thô</span></p>
                <span class="material-symbols-outlined iconplay">play_arrow</span>
                <div class="showtable" >
                    <c:forEach items="${loaiVaiMap['BP']}" var="loaivai">
                        <span class="tendanhmuc">${loaivai}</span>
                        <c:forEach items="${listDSSP}" var="listDSSP">                      
                            <c:if test="${  listDSSP.idmodel=='BP' && listDSSP.loaivai == loaivai}">                           
                                <c:forEach items="${listAnh}" var="listAnh">
                                    <c:if test="${  listAnh.madssp == listDSSP.madssp}">           
                                        <div class="anhdobo"onclick="event.stopPropagation(); 
                                          window.location.href ='http://localhost:8080/Hoadobo/ChiTietSanPham?idsp=${listDSSP.madssp}&maanh=${ listAnh.maanh}'">
                                            <img src="./assets/images/${listAnh.path}" >
                                            <p>${listAnh.mau}</p></div>
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                            </c:forEach>
                        </c:forEach>

                </div>
            </div>
             <!-- //////////////////////////// -->
             <div class="loai" onclick="window.location.href ='http://localhost:8080/Hoadobo/collection?collection=DL'">
                 <p class="tenloai">Đồ Lam</p>
                 <p class="tenvai"> <span>Mango</span><span> Đũi Bamboo</span></p>
                 <span class="material-symbols-outlined iconplay">play_arrow</span>
                 <div class="showtable " >
                     <c:forEach items="${loaiVaiMap['BL']}" var="loaivai">
                         <span class="tendanhmuc">${loaivai}</span>
                         <c:forEach items="${listDSSP}" var="listDSSP">                      
                             <c:if test="${  listDSSP.idmodel=='BL' && listDSSP.loaivai == loaivai}">                           
                                 <c:forEach items="${listAnh}" var="listAnh">
                                     <c:if test="${  listAnh.madssp == listDSSP.madssp}">           
                                         <div class="anhdobo" onclick="event.stopPropagation(); 
                                          window.location.href ='http://localhost:8080/Hoadobo/ChiTietSanPham?idsp=${listDSSP.madssp}&maanh=${ listAnh.maanh}'">
                                             <img src="./assets/images/${listAnh.path}" >
                                             <p>${listAnh.mau}</p></div>
                                         </c:if>
                                     </c:forEach>
                                 </c:if>
                             </c:forEach>
                         </c:forEach>
                 </div>
             </div>
            <!-- //////////////////////////// -->          
   
          </div>
        </div>
             </div>
                                                                       
                 </li>
                 <style>
                  .sale:hover .showtableSale{opacity: 1;pointer-events: all;}
                  .showtableSale{left: 0;background: white;box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;}
                  .menu0{ height: auto;width: 300px;margin-right: 23%; }
                  .khungmenu0{box-shadow: none}
                  .khungmenu1 div{ margin-bottom: 10px;}
                  .khungmenu1 div:hover p{color:#fd4783}
                  .chinhsach{margin-left: 10px;}
                    </style>
   <li class="sale" onclick="window.location.href ='http://localhost:8080/Hoadobo/collection?collection=SL'"> 
    <i class="fa-solid fa-bolt-lightning" style="margin-right: 5px;position: relative;top: 2px;"></i>
    <h5>Sale</h5>
    <div class="menu menu0" >
      <div class="khungmenu khungmenu0">
        <div class="showtable showtableSale" >
            <c:forEach items="${listSale}" var="sale">
                         <span class="tendanhmuc">Giảm ${sale}%</span>
                           <c:forEach items="${SaleAndImages}" var="anhsale">                      
                             <c:if test="${  anhsale.sale==sale}">                           
                                
                                         <div class="anhdobo" onclick="event.stopPropagation(); 
                                          window.location.href ='http://localhost:8080/Hoadobo/ChiTietSanPham?idsp=${anhsale.madssp}&maanh=${ anhsale.maanh}'">
                                             <img src="./assets/images/${anhsale.path}" >
                                             <p>${anhsale.mau}</p></div>                  
                                             
                                 </c:if>
                             </c:forEach>                    
                         </c:forEach>
            
                    </div> 
          </div>
     </div>
    </li>    

     <style>
      .menu1{ height: auto;width: auto;margin-right:25% ;}
      .khungmenu1{background-color: white; height: auto;width: auto;padding: 20px;padding-bottom: 10px;}
      .khungmenu1 div{ margin-bottom: 10px;}
      .khungmenu1 div:hover p{color:#fd4783}
      .chinhsach{margin-left: 10px;}
        </style>  


            <li> <h5>Thông tin</h5>
              <div class="menu menu1" >
                <div class="khungmenu khungmenu1">
                  <div onclick="window.location.href = 'https://www.codingnepalweb.com/login-signup-form-html-css-javascript/';">
                    <p class="tenloai">Liên hệ</p></div>
                  <div><p class="tenloai">Chính sách</p></div>
                  <div class="chinhsach"><p class="tenloai" style="font-weight: 400;">Thanh toán và giao nhận</p></div>
                  <div class="chinhsach"><p class="tenloai"style="font-weight: 400;">Đổi trả</p></div>
                    </div>
               </div>
              </li>
           
             <li onclick="window.location.href = 'https://lamia.com.vn/blog/do-bo/';"> <h5>Blog</h5></li>
            </ul>
          
            
<style>
  #DangKy{border: none;border-radius: 20px;padding: 9px;padding-left: 10px;
    margin-left: 2px; padding-right: 10px;display: flex;color: #fd4783;
    background: none;height: 36px;box-shadow: none;}
  #DangKy:hover{background: #fde6ea;}
#DangKy h5{color: #fd4783; margin-bottom: none ;font-size: 14px;font-weight: 600;}
#DangNhap{border: none;border-radius: 20px;padding: 12px;background: #fd4783;
    padding-left: 11px;margin-left: 2px;padding-top: 9px;display: flex;
   height: 36px;box-shadow: none;}
#DangNhap h5{ margin-bottom: none ;font-size: 14px;font-weight: 600;}   
</style>          
          </div>

 <!-- // tìm kiếm đăng ký đăng nhập //         -->
          <div style="display:flex; text-align:center">
            <form class="d-flex" role="search">
          <i class="fa-solid fa-magnifying-glass" style="color: #fd4783;font-size:20px; position:relative;
          margin-top:8px;"></i>
        
          <input class="form-control me-2 my-div" type="text" placeholder="Tìm theo loại vải, kiểu mẫu." 
          aria-label="Search"
         style="font-size: 13px;caret-color:#fd4783;
         margin-right:none;border:none" > 
         
     <!--    <button class="btn btn-outline-success" type="submit" >Search</button>   -->
      </form>
      <style>
        .modal-dialog{margin-top: 6%;width: 340px; }
        .modal-content{border-radius: 15px;width: 340px; }
        .modal-header{width: 100%; border: none;justify-content: center;flex-direction: column;padding: 20px;}
        .mb-3{flex-wrap: wrap;
          justify-content: start;
          display: flex;}
        .form-control:focus {border-color: #fd4783;box-shadow: none;}
        .form-control{border-radius: 20px;}
        .nutlogin{    font-family: var(--bs-font-sans-serif);width: 50%;margin-bottom: 30px;
          background: #fd4783;border: none;border-radius: 20px;
          box-shadow: 0 5px 20px 0 rgb(253 111 199 / 70%);}
          .nutlogin:focus{box-shadow: none;background-color: #f379a2;}
        .nutlogin:hover{transition: 0.2s;background-color: #f379a2;}
        .faceandgoogle a{    padding: 10px;
          padding-bottom: 16px;
          box-shadow: 0 5px 20px 0 rgba(0,0,0,.1);
          border-radius: 30px;}
          .faceandgoogle a i{width: 30px;
          height: 31px;font-size: 29px;
          position: relative;
          top: 7px;}
          .faceandgoogle{margin-bottom: 20px;}
          #exampleModalLabel{color: #4b2354;margin-top: 20px;
                          font-weight: 800;margin-bottom: 50px;}
        
      </style>      
      <style>
          #iconuser:hover .menu{opacity: 1; pointer-events: all;}
      </style>
       <c:if test="${user!=null}">                       
            <div id="iconcarts" onclick="window.location.href ='http://localhost:8080/Hoadobo/cart'"  >
              <i class="fa-regular fa-cart-shopping" style="color: #fd4783;font-weight: 600;font-size: 25px;
            display: flex; align-items: center;margin-left: 40px;margin-top: 6px; cursor: pointer">
          <p id="gioHangSize" style="    font-size: 14px;color: red;position: relative;top: -2px;right: -4px;">${giohang.size()}</p>  
          </i>                    
          </div>
            <div style="margin-left:20px"> 
                <i class="fa-solid fa-circle-user" id="iconuser" style="color:#fd4783;font-size: 40px;cursor: pointer">
                    <div class="menu menu1" style="right: -240px;" >
                <div class="khungmenu khungmenu1">
                  <div> <p class="tenloai" style="width: 127px;text-align: justify;">Thông tin cá nhân</p></div>
                  <div><p class="tenloai"style="width: 127px;text-align: justify;">Thông tin đơn hàng </p></div>
                  <div     onclick="window.location.href ='./views/logout.jsp'"  >
                      <p class="tenloai"style="width: 127px;text-align: justify;">Đăng xuất! </p></div>
                
                    </div>
               </div>
                </i>
                
                
              </div>
       </c:if>
      
    <c:if test="${user==null}">                       
            <button id="DangKy"type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#FormDangKy"
                     onclick="window.location.href ='http://localhost:8080/Hoadobo/register'"  >
                <h5>Đăng ký</h5></button>

            <button id="DangNhap" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#FormDangNhap"  
                  onclick="window.location.href ='http://localhost:8080/Hoadobo/login'"  >
              <h5 style="color:#fff">Đăng nhập</h5> 
            </button>     
       </c:if>
            

        
          
          </div>
            </div>
  
  </div>
</nav>
 <script>
  
      var listLoai=document.getElementsByClassName("loai");
      for(i=1;i<listLoai.length;i++){   	 
    	  listLoai[i].addEventListener("mouseover",()=>{
              document.getElementById("tenloai1").style.color = "#646363";
              document.getElementById("loai1").style.backgroundColor="#fff";
              document.getElementById("loai1").style.borderRight="1px solid gainsboro";
              document.getElementById("iconplay1").style.color="rgba(255, 255, 255, 0)";
              document.getElementById("showtable1").style.opacity="0"; 
           
        });   	  
    	  listLoai[i].addEventListener("mouseout",()=>{
    	      document.getElementById("tenloai1").style.color = "white";
              document.getElementById("loai1").style.backgroundColor="#fd4783";
              document.getElementById("loai1").style.borderRight="1px solid #fd4783";
              document.getElementById("iconplay1").style.color="#fd4783";
              document.getElementById("showtable1").style.opacity="1"; 
       });
    }

</script>
</header>