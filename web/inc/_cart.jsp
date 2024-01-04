<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<section class="h-100 h-custom" style="background-color: #eee;">
    <div class="container py-5 h-100" style="padding-top: 85px!important">
        <div class="row justify-content-center align-items-center h-100">
            <div class="col">
                <div class="card">
                    <div class="card-body p-4">

                        <div class="row">

                            <div class="col-lg-7">
                                <h5 class="mb-3" style="justify-content: space-between;">
                                    <a href="home" class="text-body"><i
                                            class="fas fa-long-arrow-alt-left me-2"></i>Continue shopping</a>
                                    <a href="cart?clear=OK" class="text-body">
                                              Empty cart</a>
                                </h5> 
                                <hr>
                                <div class=" justify-content-between align-items-center mb-4">
                                    <div style="display:flex;justify-content: space-between">                            
                                        <span class="mb-0" id="sizeItem" > You have ${giohang.size()} items in your cart</span>
                                           <span class="mb-0"><span class="text-muted">Sort by:</span> <a href="#!"
                                                                                                    class="text-body">price <i class="fas fa-angle-down mt-1"></i></a></span>
                                    </div>
                                    
                                </div>
                                <!--   comlum     -->
                         
                                <div id="cart">
                                    <h6 style="display: none" id="cartnull">Shopping cart is null!</h6>
                         
                                    <c:choose>
                                        
                                        <c:when test="${empty gioHangItems}">    <h6>Shopping cart is empty!</h6>   </c:when>
                                        <c:otherwise>
                                           <c:set var="subtotal" value="0"/>
                                            <c:forEach var="gioHangItems" items="${gioHangItems}">
                                                <c:set var="subtotal" value="${subtotal + (gioHangItems.tien*gioHangItems.soluong)}"/>
                                                <div class="card mb-3" id='idgiohang:${gioHangItems.idgiohang}'>
                                                    <div class="card-body" style=" padding: 0px">
                                                        <div  style="display:flex; justify-content: space-between">
                                                            <div style='display:flex'>
                                                            <img src="./assets/images/${gioHangItems.path}" class="img-fluid rounded-3" alt="Shopping item" style="width: 110px;">
                                                            <div style="padding: 10px;">
                                                            <h6 >${gioHangItems.namesp } </h6>           
                                                            <h6>Size: ${gioHangItems.size}</h6>
                                                            <h6>Màu: ${gioHangItems.mau}</h6>
                                                              <div style="width: 80px; display: flex; align-items: center;    position: absolute;bottom: 8%;    width: 80%;justify-content: space-between; ">         
                                                                    <div style="width: 80px;">
                                                                    <h6 class="mb-0" id="totalprice${gioHangItems.idgiohang}"
                                                                        style="color: #c40644; font-size: 18px;"
                                                                        >${gioHangItems.tien*gioHangItems.soluong}đ</h6>
                                                                </div>         
                                                                <div style="display: flex;">
                                                                <button class="btn btn-outline-secondary" type="button" 
                                                                          style="height: 28px;width: 35px;display: flex;align-items: center;
                                                                             justify-content: center;font-size: 24px; color: black;    border: 1px solid gainsboro;    border-radius: 10px 0 0 10px;" 
                                                                        onclick="increaseQuantity(${gioHangItems.idgiohang})">+</button>   
                                                                        
                                                               <input id="quantity-${gioHangItems.idgiohang}"  type="number" class="fw-normal mb-0" style=" width: 40px; text-align: center;
                                                                      border: 1px solid gainsboro;" 
                                                                       value="${gioHangItems.soluong}" onchange="updateQuantity(${gioHangItems.idgiohang}, this.value)" />
                                                               
                                                                <button class="btn btn-outline-secondary" type="button"  
                                                                        style="height: 28px;width: 35px;display: flex;align-items: center;
                                                                             justify-content: center;font-size: 24px; color: black;    border: 1px solid gainsboro;    border-radius: 0 10px 10px 0;    padding-top: 2px;" 
                                                                        onclick="decreaseQuantity(${gioHangItems.idgiohang})">-</button>     
                                                                        
                                                                         <a href="#!" style="color: #cecece; cursor: pointer;margin-left: 20px" onclick="removeItem(${gioHangItems.idgiohang})">
                                                                    <i class="fas fa-trash-alt" style="font-size:18px"></i>
                                                                </a>
                                                                      </div>  
                                                            </div>                    
                                                              </div>
                                                     </div>
                                                            
                                                                                                                  
                                                        </div>
                                                                    
                                                    </div>
                                                </div>   
                                            </c:forEach>  
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <!--=============================-->
                            </div>
                                  
                            <div style="width: 400px;">
                                <p class="mb-2"       style="font-size: 18px;">Tổng tiền:</p>
                                <p class="mb-2" id="tongtien"      style="color: #c40644; font-size: 20px;font-weight: 500;">${subtotal.intValue()}đ</p>
                                <button type="button"  style="background:#fd478a">
                                    <span>  Tiến hành đặt hàng <i class="fas fa-long-arrow-alt-right ms-2"></i></span>
                                </button>
                            </div>                                    
                        </div>
                    </div>
                </div>
            </div>
        </div>
</section>

