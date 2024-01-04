<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    .khungdssp{
        display: flex;
        flex-wrap: wrap;
        justify-content: start;
        padding: 0px 9% 0 11%
    }
    .khungsp{ cursor: pointer;
        width: 280px;
        margin: 10px;
        border: 1px solid gainsboro;
        border-radius: 15px;
        overflow: hidden;
        height: 550px; transition: all 0.1s linear ;
    }
    .khungsp:hover {transform: translateY(-2px);
    }
    .giamgia{
        color: white;
        height: 27px;
        position: sticky;
        text-align: center;
        width: 48px;
        background: red;
      bottom: 100%
    }
    .tensp{margin-bottom:10px;padding: 0px 5px 0px 5px;    font-size: 15px;font-weight: 500;        display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    }
    .daban{background: rgba(63, 63, 63, 0.50);position: sticky; padding: 1px;padding-right: 5px; padding-left: 6px;font-size: 12px;
    color: white; font-weight: 600; width: fit-content;  bottom: 129px;}
    .selected{border: 2px solid deeppink;}
</style>

    <h3 style="margin-top: 30px;padding-left: 12%">Sản phẩm bán chạy</h3>

    <div class="khungdssp" >   

        <c:forEach items="${listDSSP}" var="listDSSP">   
            <c:if test="${listDSSP.soluongban >1600 &&listDSSP.hethang==false}">
                <div  class="khungsp"onclick=" window.location.href = 'http://localhost:8080/Hoadobo/ChiTietSanPham?idsp=${listDSSP.madssp}'">

                    <img  id="mainImage_${listDSSP.madssp}" src="./assets/images/${listDSSP.path}" style="    height: 420px; width: 280px;">
                    <div style="padding: 5px;" >
                    <c:forEach var="imagePath" items="${productImages[listDSSP.madssp]}">
                           <img onclick=" event.stopPropagation();  changeMainImage('${imagePath}','${listDSSP.madssp}')  " 
                                id="image_${imagePath}"
                                class="${imagePath == productImages[listDSSP.madssp][0] ? 'selected' : ''}"
                                src="./assets/images/${imagePath}" 
                                style="width: 35px;border-radius: 50px;height: 35px;object-fit: cover;">
                    </c:forEach> </div>
                    <p class="tensp" > ${listDSSP.namesp} </p>              
                    <c:if test="${ listDSSP.sale !=  0}">
                        <div>
                        <span class="giasp" style="font-weight: 700;margin-right: 10px;margin-left: 5px">${Math.round(listDSSP.gia-listDSSP.gia*listDSSP.sale/100)}đ </span>     
                        <span class="giasp" style=" text-decoration: line-through;"> ${listDSSP.gia}đ</span>      </div>
                        <div class="giasp giamgia">-${listDSSP.sale}%</div>   
                    </c:if>                

                    <c:if test="${listDSSP.sale==0}">
                        <span class="giasp" style="font-weight: 700;margin-right: 10px;margin-left: 5px"> ${listDSSP.gia}đ </span>    
                    </c:if>  
                   <div class="daban"><span style="color:yellow">★</span> <span> ${listDSSP.soluongban} đã bán</span></div>
   
                </div>
            </c:if>
        </c:forEach>
    </div>

    <!--============================-->

    <c:forEach items="${listModel}" var="listModel">   
        <h3 style="margin-top: 100px;padding-left: 12%">${listModel.namemodel}</h3>
        <div class="khungdssp" >   

            <c:forEach items="${listDSSP}" var="listDSSP">   
                <c:if test="${listDSSP.hethang==false && listDSSP.idmodel==listModel.idmodel}">
                   <div  class="khungsp"onclick=" window.location.href = 'http://localhost:8080/Hoadobo/ChiTietSanPham?idsp=${listDSSP.madssp}'">

                    <img  id="mainImage_${listDSSP.madssp}" src="./assets/images/${listDSSP.path}" style="    height: 420px; width: 280px;">
                    <div style="padding: 5px;" >
                    <c:forEach var="imagePath" items="${productImages[listDSSP.madssp]}">
                           <img onclick=" event.stopPropagation();  changeMainImage('${imagePath}','${listDSSP.madssp}')  " 
                                id="image_${imagePath}"
                                class="${imagePath == productImages[listDSSP.madssp][0] ? 'selected' : ''}"
                                src="./assets/images/${imagePath}" 
                                style="width: 35px;border-radius: 50px;height: 35px;object-fit: cover;">
                    </c:forEach> </div>
                    <p class="tensp" > ${listDSSP.namesp} </p>              
                    <c:if test="${ listDSSP.sale !=  0}">
                        <div>
                        <span class="giasp" style="font-weight: 700;margin-right: 10px;margin-left: 5px">${Math.round(listDSSP.gia-listDSSP.gia*listDSSP.sale/100)}đ </span>     
                        <span class="giasp" style=" text-decoration: line-through;"> ${listDSSP.gia}đ</span>      </div>
                        <div class="giasp giamgia">-${listDSSP.sale}%</div>   
                    </c:if>                

                    <c:if test="${listDSSP.sale==0}">
                        <span class="giasp" style="font-weight: 700;margin-right: 10px;margin-left: 5px"> ${listDSSP.gia}đ </span>    
                    </c:if>  
                   <div class="daban"><span style="color:yellow">★</span> <span> ${listDSSP.soluongban} đã bán</span></div>
   
                </div>

                </c:if>
            </c:forEach>
        </div> 
    </c:forEach>
        <script>
      var baseImagePath = "./assets/images/";

    function changeMainImage(imagePath, madssp) {  
        var parentDiv = document.getElementById('mainImage_' + madssp).parentElement;

    // Lấy ảnh hiện tại có lớp 'selected'
    var currentImage = parentDiv.querySelector('.selected');
    if (currentImage) {
        currentImage.classList.remove('selected');
    }

    // Thêm viền vào ảnh mới
    var newImage = document.getElementById('image_' + imagePath);
    newImage.classList.add('selected');
        console.log("Có hoạt động "+imagePath+"-"+madssp);
        document.getElementById('mainImage_' + madssp).src = baseImagePath + imagePath;
    }
            </script>

