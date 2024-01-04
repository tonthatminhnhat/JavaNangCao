<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:import url="./inc/header.jsp"/>
<c:import url="./inc/navbar.jsp"/>
<c:import url="./inc/_cart.jsp"/>
<script>
    function removeItem(idgiohang) {
        console.log('action=removeItem&idgiohang=' + idgiohang);

        fetch('cart', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'action=removeItem&idgiohang=' + idgiohang
        })
                .then(response => {
                   if (!response.ok) {   throw new Error('Network response was not ok');  }
                    return response.json();  // Tr? v? d? li?u t? ph?n h?i c?a máy ch?
                })
                .then(data => {
                    // Xóa hàng s?n ph?m kh?i HTML
                     console.log(data);
                    document.getElementById('idgiohang:' + idgiohang).remove();
                    if (data.count === 0)      document.getElementById('cartnull').style.display = 'block';
                    // C?p nh?t count và tongtien trên trang
                    document.getElementById('sizeItem').innerText = "You have " + data.count + " items in your cart";
                    document.getElementById('gioHangSize').innerText = data.count;
                    document.getElementById('tongtien').innerText =  data.tongtien+"đ";
                })
                .catch((error) => {
                    console.error('Error:', error);
                });
    }
    function decreaseQuantity(productId) {
        let quantityInput = document.getElementById('quantity-' + productId);
        let quantity = parseInt(quantityInput.value, 10);
        if (quantity > 1) {
            quantity -= 1;
            quantityInput.value = quantity;
            updateQuantity(productId, quantity);
        }
    }

    function increaseQuantity(productId) {
        let quantityInput = document.getElementById('quantity-' + productId);
        let quantity = parseInt(quantityInput.value, 10);
        quantity += 1;
        quantityInput.value = quantity;
        updateQuantity(productId, quantity);
    }

    function updateQuantity(idgiohang, quantity) {
        console.log("Updating quantity for product with ID: " + idgiohang);
        fetch('cart', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'action=updateQuantity&idgiohang=' + idgiohang + '&quantity=' + quantity
        })
                .then(response => {
                     if (!response.ok) {   throw new Error('Network response was not ok');  }
                      return response.json();  // Tr? v? d? li?u t? ph?n h?i c?a máy ch?
                  })
                  .then(data => {
                       console.log(data.totalprice +"---" +data.tongtien);
                      // C?p nh?t VAT và total trên trang
                     
                       document.getElementById('tongtien').innerText = data.tongtien+"đ";
                         document.getElementById("totalprice" + idgiohang).innerText = data.totalprice+"đ";

                  })
                .catch((error) => {
                    console.error('Error:', error);
                });
    }

</script>




