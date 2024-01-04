<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="row d-flex justify-content-center">
    <div class="col-md-10" style="margin-top: 80px;width: 64.333333%;">
        <div class="card">
            <div class="row">
                <div class="col-md-6">
                    <div class="images p-3">
                        <div class="text-center p-4"> 
                            <img id="main-image" src="./assets/images/${anhdautien.path}" width="440" /> </div>

                    </div>
                </div>
                <div class="col-md-6" style="padding: 40px 50px 40px 3px;">
                    <div class="product p-4" style="height: 100%;">
                        <div class="d-flex justify-cntent-between align-items-center" style=" border-color: #eee; ">
                            <div class=" align-items-center" onclick=" window.location.href = 'http://localhost:8080/Hoadobo/home'" style="cursor: pointer;">
                                <i class="fa fa-long-arrow-left"></i> 
                                <span class="ml-1">Back</span> 
                                 <i class="fa fa-shopping-cart text-muted"></i>
                            </div> 
                           
                        </div>
                        <div class="mt-4 mb-3"> 

                            <h5 class="text-uppercase">${chitietdssp.namesp}</h5>
                            <c:if test="${chitietdssp.sale ==0}">
                                <span class="act-price" style="font-size:25px">${chitietdssp.gia}đ</span>                                    
                            </c:if>
                            <c:if test="${chitietdssp.sale !=0}">
                                <span class="act-price"style="font-size:25px;margin-right: 20px">${Math.round(chitietdssp.gia-chitietdssp.gia*chitietdssp.sale/100)}đ</span>        
                                <div class="ml-2"style="font-size:25px;margin-right: 20px"> <small class="dis-price">${chitietdssp.gia}đ</small>                        
                                </c:if>                           
                            </div>

                            <div class="thumbnail text-center" style="width: 100%; display: flex;justify-content: flex-start; margin-top: 20px">                         
                                <c:forEach items="${chitietanh}" var="chitietanh">                          
                                    <img onclick="change_image(this)"  data-maanh="${chitietanh.maanh}"  data-mau="${chitietanh.mau}"
                                         src="./assets/images/${chitietanh.path}" width="70" style="margin-right:5px">
                                </c:forEach>
                            </div>
                                <h6 id="mau" style="margin-top:20px; width: 100%"> Màu: ${anhdautien.mau}</h6>
                                <h6 style="margin-top:10px; width: 100%">Size:</h6>  
                            <div class="sizes mt-5" id="khungid" style="margin-top:0px!important">

                                <c:set var="first" value="true"/>
                                <c:forEach items="${chitietsp}" var="chitietsp">    
                                    <c:if test="${anhdautien.maanh == chitietsp.maanh && chitietsp.soluong>0}">
                                        <label class="radio" >
                                            <c:choose>
                                                <c:when test="${first}">
                                                    <input type="radio" name="size" value="${chitietsp.size}" checked> 
                                                    <c:set var="first" value="false"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="radio" name="size" value="${chitietsp.size}"> 
                                                </c:otherwise>
                                            </c:choose>
                                            <span>${chitietsp.size}</span> 
                                        </label>
                                    </c:if>
                                </c:forEach>              

                            </div>
                                
                            <div class="cart mt-4 align-items-center" style="width: 100%;"> 
                                
                                     <c:choose>
                                                <c:when test="${user==null}">
                                         <button class="btn btn-danger text-uppercase mr-2 px-4" id="addToCartButton" 
                                            onclick="window.location.href ='http://localhost:8080/Hoadobo/login'"  >Add to cart</button>
                                     </c:when>
                                                 <c:otherwise>
                                    <button class="btn btn-danger text-uppercase mr-2 px-4" id="addToCartButton" 
                                            onclick="addToCart()" data-maanh="${anhdautien.maanh}">Add to cart</button>
                                             </c:otherwise>
                                            </c:choose>    

                                    <i class="fa fa-heart text-muted"></i> 
                                    <i class="fa fa-share-alt text-muted"></i> </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>

            function change_image(image) {
                var container = document.getElementById("main-image");
                container.src = image.src;
                var mauElement = document.getElementById("mau");
                mauElement.textContent = "Màu: " + image.dataset.mau;

                var maanh = image.dataset.maanh;
                var addToCartButton = document.getElementById("addToCartButton");
                addToCartButton.dataset.maanh = maanh;
                fetch('ChiTietSanPham', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'action=getSizes&maanh=' + maanh
                })
                        .then(response => response.json())
                        .then(sizes => {
                            // Lấy tất cả các radio button
                            var container = document.getElementById('khungid');
                            // Xóa tất cả các radio button hiện tại
                            while (container.firstChild) {
                                container.removeChild(container.firstChild);
                            }
                            // Duyệt qua tất cả các radio button
                            for (var i = 0; i < sizes.length; i++) {
                                var label = document.createElement('label');
                                label.className = 'radio';
                                label.style.marginRight = '5px';
                                var input = document.createElement('input');
                                input.type = 'radio';
                                input.name = 'size';
                                input.value = sizes[i];
                                if (i === 0) {
                                    input.checked = true;
                                }
                                var span = document.createElement('span');
                                span.textContent = sizes[i];
                                label.appendChild(input);
                                label.appendChild(span);
                                container.appendChild(label);
                            }
                        });
            }
            document.addEventListener("DOMContentLoaded", function (event) {});

        </script>

        <style>
            body{
                background-color: pink
            }
            .card{
                border:none
            }
            .product{
                background-color: #eee
            }
            .brand{
                font-size: 13px
            }
            .act-price{
                color:red;
                font-weight: 700
            }
            .dis-price{
                text-decoration: line-through
            }
            .about{
                font-size: 14px
            }
            .color{
                margin-bottom:10px
            }
            label.radio{
                cursor: pointer
            }
            label.radio input{
                position: absolute;
                top: 0;
                left: 0;
                visibility: hidden;
                pointer-events: none
            }
            label.radio span{
                padding: 2px 9px;
                border: 2px solid #fd4783;
                display: inline-block;
                color: #fd4783;
                border-radius: 3px;
                text-transform: uppercase
            }
            label.radio input:checked+span{
                border-color: #fd4783;
                background-color: #fd4783;
                color: #fff
            }
            .btn-danger{
                background-color: #fd4783 !important;
                border-color: #fd4783 !important
            }
            .btn-danger:hover{
                background-color: #ff8398!important;
                border-color: #ff8398!important
            }
            .btn-danger:focus{
                box-shadow: none
            }
            .cart i{
                margin-right: 10px
            }
            .d-flex:hover {
                border-color: #eee;
            }
        </style>

    </body>
</html>
