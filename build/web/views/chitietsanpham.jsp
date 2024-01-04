<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:import url="./inc/header.jsp"/>
<c:import url="./inc/navbar.jsp"/>
<c:import url="./inc/_chitietsanpham.jsp"/>
<script>  
    function addToCart(maanh) {
           var selectedSize = document.querySelector('input[name="size"]:checked');    
          var maanh = document.getElementById('addToCartButton').dataset.maanh;
           if (selectedSize) {      
            var masp = maanh + selectedSize.value;
            
           fetch('ChiTietSanPham', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'action=addToCart&masp=' + masp
        })
        .then(response => response.json())
        .then(data => {
           var giohangSize = data.count;
        // Sử dụng giá trị giohangSize theo cách bạn muốn
        console.log('Số lượng sản phẩm trong giỏ hàng: ' + giohangSize);
         var gioHangSizeElement = document.getElementById('gioHangSize');
    if (gioHangSizeElement) {
        gioHangSizeElement.innerText = giohangSize;
    }
         
        })
        .catch(error => {
            console.error('Đã xảy ra lỗi khi addToCart:', error);
        });
            
        } else {
            alert('Vui lòng chọn Size');
        }        
    }
    </script>





