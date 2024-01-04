<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                margin: 0;
                padding: 0;
            }
            #productDetailForm {
                background-color: #fff;
                padding: 10px 20px;
                width: 63.5%;
                box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
            }
            table {
                width: 70%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            th, td {
                font-size: 11px;
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #4CAF50;
                color: white;
            }
            tr{
                cursor: pointer;
            }
            tr.selected {
                background-color: #f0f0f0;
            }
            .btn {
                display: inline-block;
                padding: 5px 10px;
                margin: 10px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
                text-decoration: none;
            }
            .btn:hover {
                background-color: #45a049;
            }
            input{
                margin: 10px;
                padding: 5px;
            }
        </style>

    </head>
    <body >

        <a href="#userTable" class="btn"  onclick="showTable('user')">Quản lý tài khoản</a>
        <a href="#productTable" class="btn" onclick="showTable('product')">Quản lý sản phẩm</a>
        <a href="#categoryTable" class="btn" onclick="showTable('category')">Quản lý danh mục</a>
        <a href="./views/logout.jsp" class="btn">Đăng xuất!</a>

        <!--    =====================Quản lý sản phẩm==============================-->
        <div id="product">

            <div id="productDetailForm" style="display: block;">
                <h4>Chi tiết sản phẩm:</h4>
                <form  style="display: flex; flex-wrap: wrap;" id="Formproduct">
                    <div style="flex: 1;padding-right: 148px;" >

                        <label for="madssp" style="font-size: 14px;" >Mã SP:</label>
                        <input type="text" id="madssp"  readonly style="width: 40px;     border: 1px solid gainsboro;">

                        <label for="namesp" style="font-size: 14px;" >Tên SP:</label>
                        <input type="text" id="namesp" style=" width: 57%;    border: 1px solid gainsboro;">

                        <label for="gia" style="font-size: 14px;" >Giá:</label>
                        <input type="text" id="gia"  style="width: 70px;border: 1px solid gainsboro;">

                        <label for="sale"style="font-size: 14px;" >Sale:</label>
                        <input type="text" id="sale"  style="width: 30px;border: 1px solid gainsboro;">

                        <label for="hethang"style="font-size: 14px;" >Hết hàng:</label>
                        <input type="text" id="hethang" style=" width: 42px;    border: 1px solid gainsboro;">

                        <label for="soluongban"style="font-size: 14px;" >Số lượng đã bán:</label>
                        <input type="text" id="soluongban" style="width: 40px;    border: 1px solid gainsboro;">

                        <label for="loaivai"style="font-size: 14px;" >Loại vải:</label>
                        <input type="text" id="loaivai"  style="width: 100px;    border: 1px solid gainsboro;">        

                        <label for="idmodel"style="font-size: 14px;" >Mẫu :</label>
                        <input type="text" id="idmodel" style="width: 30px;    border: 1px solid gainsboro;"><br>
                        <div style="flex: 1;">    
                            <label for="path"style="font-size: 14px;" >Hình ảnh đại diện:</label>
                            <input type="text" id="path" style="width: 70%;    border: 1px solid gainsboro;">                     
                            <button type="button" id="fileInput" onclick="openFileChooser()">Chọn ảnh</button>
                            <img id="productImage" src="" alt="Hình ảnh sản phẩm" style="     width: 148px;right: 513px; border: 1px solid gray;
                                 top: 49px; height: auto; position: absolute;">

                        </div>
                    </div>                                            
                </form>
            </div>
        </div>       
        <button class="btn" onclick="resetForm()" style="background: gray">Xóa form</button>
        <button class="btn" onclick="addSP()">Add</button>
        <button class="btn" onclick="confirmDelete()" style="background:red">Delete</button>
        <button class="btn" onclick="updateSP()" style="background:blue">Update</button>
        <div style="display:flex">
            <table style="width:67%">
                <thead>
                    <tr> <th>Mã SP</th> <th>Tên SP</th><th>Giá</th> <th>Sale</th> <th>Hết hàng</th>
                        <th>Đã bán</th> <th>Loại vải</th> <th>Mẫu</th> <th>Hình ảnh đại diện</th> 
                    </tr>
                </thead>
                <tbody id="TableProduct">
                    <c:forEach items="${listDSSP}" var="product">
                        <tr id="productRow${product.madssp}" class="productRow" onclick="selectProduct('${product.madssp}')">
                            <td>${product.madssp}</td>
                            <td>${product.namesp}</td>
                            <td>${product.gia}</td>
                            <td>${product.sale}</td>
                            <td>${product.hethang}</td>
                            <td>${product.soluongban}</td>
                            <td>${product.loaivai}</td>
                            <td>${product.idmodel}</td>
                            <td>${product.path}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div>
                <table  style="width: 502px; margin-bottom: 0px">
                    <thead >
                        <tr> <th style="background: yellowgreen">Mã ảnh</th> 
                            <th style="background: yellowgreen">Màu</th>
                            <th style="background: yellowgreen">Mã SP</th> <th style="background: yellowgreen">Path</th></tr>
                    </thead>
                    <tbody id="TableAnh">
                    </tbody>
                </table>
                <div  style="    display: block;height: 225px;position: absolute;top: 48px;background: yellowgreen;padding-left: 10px;">
                    <h4 style="margin-top:15px;margin-bottom: 15px">Chi tiết ảnh:</h4>
                    <form  style="display: flex; flex-wrap: wrap;" id="Formproduct">
                        <div style="flex: 1;padding-right: 148px;" >

                            <label for="maanh" style="font-size: 13px;" >Mã Ảnh:</label>
                            <input type="text" id="maanh"  readonly style="width: 80px;      font-size: 12px;
                                   padding: 2px;   border: 1px solid gainsboro;">
                            <label for="madsspAnh" style="font-size: 13px;" >Mã SP:</label>
                            <input type="text" id="madsspAnh"   style="width: 50px;      font-size: 12px;
                                   padding: 2px;   border: 1px solid gainsboro;"><br>
                            <label for="mau" style="font-size: 13px;" >Màu</label>
                            <input type="text" id="mau" style="     width: 79%; margin-left: 14px; font-size: 12px;
                                   padding: 2px;   border: 1px solid gainsboro;"><br>

                            <div style="flex: 1;">    
                                <label for="pathAnh"style="font-size: 13px;" >Path:</label>
                                <input type="text" id="pathAnh" style="width: 79%;      font-size: 12px;
                                       padding: 2px;  border: 1px solid gainsboro;">                     
                                <button type="button" id="fileInputAnh" onclick="openFileChooserAnh()" style="margin-left: 45px;">Chọn ảnh</button>
                                <img id="productAnh" src="" alt="Hình ảnh sản phẩm" style="     font-size: 12px;width: 148px;
                                     right: 6px;    border: 1px solid gray;   top: 1px;    height: auto;position: absolute;">                              
                            </div>
                        </div>    

                    </form>
                    <div>
                        <button class="btn" onclick="resetFormAnh()" style="background: gray">Xóa form</button>
                        <button class="btn" onclick="addAnh()">Add</button>
                        <button class="btn" onclick="confirmDeleteAnh()" style="background:red">Delete</button>
                        <button class="btn" onclick="updateSize()" style="background:blue">Update</button></div>
                </div>
                <div>

                    <div  style="    display: block;width: 490px;position: relative;background: darkkhaki;padding-left: 10px;">
                        <h4 style="margin-top:30px;margin-bottom: 15px;padding-top: 10px;">Chi tiết size:</h4>
                        <form  style="display: flex; flex-wrap: wrap;" id="Formproduct">
                            <div style="flex: 1;" >

                                <label for="masp" style="font-size: 13px;" >Mã Size SP:</label>
                                <input type="text" id="masp"  readonly style="width: 80px;      font-size: 12px;
                                       padding: 2px;   border: 1px solid gainsboro;">
                                <label for="madsspsize"readonly style="font-size: 13px;" >Mã SP:</label>
                                <input type="text" id="madsspsize" style="     width: 50px; margin-left: 14px; font-size: 12px;
                                       padding: 2px;   border: 1px solid gainsboro;"><br>
                                <label for="maspanh" style="font-size: 13px;" >Mã ảnh:</label>
                                <input type="text" id="maspanh"   style="width: 50px;      font-size: 12px;
                                       padding: 2px;   border: 1px solid gainsboro;">

                                <label for="soluong"style="font-size: 13px;" >Số lượng:</label>
                                <input type="text" id="soluong" style="width: 40px;      font-size: 12px;
                                       padding: 2px;  border: 1px solid gainsboro;">      
                                <label for="size" style="font-size: 13px;">Size:</label>
                                <select id="size" style="width: 60px; font-size: 12px; padding: 2px; border: 1px solid gainsboro;">
                                    <option value="S">S</option><option value="M">M</option><option value="L">L</option>
                                    <option value="XL">XL</option><option value="XXL">XXL</option></select>

                            </div>    

                        </form>
                        <div>
                            <button class="btn" onclick="resetFormSize()" style="background: gray">Xóa form</button>
                            <button class="btn" onclick="addSize()">Add</button>
                            <button class="btn" onclick="confirmDeleteSize()" style="background:red">Delete</button>
                            <button class="btn" onclick="updateSize()" style="background:blue">Update</button></div>
                            <span style="    position: absolute; top: 137px ; font-size: 12px;right: 6px;"> 
                                (chỉ có thể cập nhật số lượng)</span>
                    </div>
                    <table  style="width: 502px; margin-top: 10px">
                        <thead>
                            <tr> <th style="background:darkkhaki">Mã Size SP</th> 
                                <th style="background:darkkhaki">Mã ảnh</th>
                                <th style="background:darkkhaki">Mã SP</th>
                                <th style="background:darkkhaki">Size</th>
                                <th style="background:darkkhaki">Số lượng</th>
                        </thead>
                        <tbody id="TableSize">
                        </tbody>
                    </table>     
                </div>
            </div>
        </div>

        <!--.intValue()-->
        <!--    =====================Quản lý danh mục==============================-->
    </body>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <script>
                                // tô đậm hàng được chọn
                                var selectedRow;
                                function selectProduct(idRow) {
                                    if (selectedRow) {
                                        selectedRow.style.background = "none";
                                    }
                                    selectedRow = document.getElementById('productRow' + idRow);
                                    selectedRow.style.background = "darkgrey";
                                    console.log("selectProduct có hoạt động");
                                    showDetails();
                                }
                                function showDetails() {
                                    var cells = selectedRow.getElementsByTagName('td');
                                    document.getElementById('madssp').value = cells[0].innerText;
                                    document.getElementById('namesp').value = cells[1].innerText;
                                    document.getElementById('gia').value = cells[2].innerText;
                                    document.getElementById('sale').value = cells[3].innerText;
                                    document.getElementById('hethang').value = cells[4].innerText;
                                    document.getElementById('soluongban').value = cells[5].innerText;
                                    document.getElementById('loaivai').value = cells[6].innerText;
                                    document.getElementById('idmodel').value = cells[7].innerText;
                                    var path = cells[8].innerText;
                                    console.log(path);
                                    document.getElementById('path').value = path;
                                    document.getElementById('productImage').src = './assets/images/' + path;
                                    resetTableAnh();
                                    $('.sizeRow').remove();
                                }
                                function updateSP() {
                                    var madssp = document.getElementById('madssp').value;
                                    var namesp = document.getElementById('namesp').value;
                                    var gia = document.getElementById('gia').value;
                                    var sale = document.getElementById('sale').value;
                                    var hethang = document.getElementById('hethang').value;
                                    var soluongban = document.getElementById('soluongban').value;
                                    var loaivai = document.getElementById('loaivai').value;
                                    var idmodel = document.getElementById('idmodel').value;
                                    var path = document.getElementById('path').value;
                                    var bodyData = "action=updateSP&madssp=" + madssp + "&namesp=" + namesp + "&gia=" + gia + "&sale="
                                            + sale + "&hethang=" + hethang + "&soluongban=" + soluongban + "&loaivai=" + loaivai + "&idmodel="
                                            + idmodel + "&path=" + path;
                                    fetch('admin', {
                                        method: 'POST',
                                        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                        body: bodyData
                                    })
                                            .then(response => response.text())
                                            .then(data => {
                                                if (data === "true") {
                                                    alert('Cập nhật thành công!');
                                                    resetForm();
                                                    resetTableSP();
                                                } else {
                                                    alert('Cập nhật không thành công!');
                                                }
                                            })
                                            .catch(error => console.error('Error:', error));
                                }
                                function confirmDelete() {
                                    var isConfirmed = confirm('Bạn có chắc chắn muốn xóa không?');
                                    if (isConfirmed) {
                                        deleteSP();
                                    } else {
                                    }
                                }
                                function deleteSP() {
                                    var madssp = document.getElementById('madssp').value;
                                    var bodyData = "action=deleteSP&madssp=" + madssp;
                                    fetch('admin', {
                                        method: 'POST',
                                        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                        body: bodyData
                                    })
                                            .then(response => response.text())
                                            .then(data => {
                                                if (data === "true") {
                                                    alert('Xóa thành công!');
                                                    resetForm();
                                                    resetTableSP();
                                                } else {
                                                    alert('Xóa không thành công!');
                                                }
                                            })
                                            .catch(error => console.error('Error:', error));
                                }
                                function addSP() {
                                    var namesp = document.getElementById('namesp').value;
                                    var gia = document.getElementById('gia').value;
                                    var sale = document.getElementById('sale').value;
                                    var hethang = document.getElementById('hethang').value;
                                    var soluongban = document.getElementById('soluongban').value;
                                    var loaivai = document.getElementById('loaivai').value;
                                    var idmodel = document.getElementById('idmodel').value;
                                    var path = document.getElementById('path').value;
                                    var bodyData = "action=addSP&namesp=" + namesp + "&sale=" + sale + "&gia=" + gia + "&hethang=" + hethang
                                            + "&soluongban=" + soluongban + "&loaivai=" + loaivai + "&idmodel=" + idmodel + "&path=" + path;
                                    fetch('admin', {method: 'POST', headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                        body: bodyData
                                    })
                                            .then(response => response.text())
                                            .then(data => {
                                                if (data === "true") {
                                                    alert('Thêm mới thành công!');
                                                    resetForm();
                                                    resetTableSP();
                                                } else
                                                    alert('Thêm mới không thành công!');
                                            })
                                            .catch(error => console.error('Error:', error));
                                }
                                function resetTableSP() {
                                    $.post('admin', {action: 'getAllSP'}, function (listDSSP) {
                                        $('.productRow').remove();
                                        // Xây dựng lại bảng với dữ liệu mới
                                        $.each(listDSSP, function (i, product) {
                                            $('#TableProduct').append(
                                                    '<tr id="productRowAnh' + product.madssp + '" class="productRow" onclick="selectProduct(\'' + product.madssp + '\')">' +
                                                    '<td>' + product.madssp + '</td>' +
                                                    '<td>' + product.namesp + '</td>' +
                                                    '<td>' + product.gia + '</td>' +
                                                    '<td>' + product.sale + '</td>' +
                                                    '<td>' + product.hethang + '</td>' +
                                                    '<td>' + product.soluongban + '</td>' +
                                                    '<td>' + product.loaivai + '</td>' +
                                                    '<td>' + product.idmodel + '</td>' +
                                                    '<td>' + product.path + '</td>' +
                                                    '</tr>'
                                                    );
                                        });
                                    }, 'json')
                                            .fail(function (error) {
                                                console.error('Error:', error);
                                            });
                                }

                                function resetForm() {
                                    // Xóa form
                                    document.getElementById('madssp').value = '';
                                    document.getElementById('namesp').value = '';
                                    document.getElementById('gia').value = '';
                                    document.getElementById('sale').value = '';
                                    document.getElementById('hethang').value = '';
                                    document.getElementById('soluongban').value = '';
                                    document.getElementById('loaivai').value = '';
                                    document.getElementById('idmodel').value = '';
                                    document.getElementById('path').value = '';
                                    document.getElementById('productImage').src = '';
                                }
                                ///////////////////Xử lý Form ảnh
                                function resetTableAnh() {
                                    var madssp = document.getElementById('madssp').value;
                                    $.post('admin', {action: 'getAllAnh', madssp: madssp}, function (listDSAnh) {
                                        $('.anhRow').remove();
                                        $.each(listDSAnh, function (i, anh) {
                                            $('#TableAnh').append(
                                                    '<tr id="productRowAnh' + anh.maanh + '" class="anhRow" onclick="selectAnh(\'' + anh.maanh + '\')">' +
                                                    '<td>' + anh.maanh + '</td>' +
                                                    '<td>' + anh.mau + '</td>' +
                                                    '<td>' + anh.madssp + '</td>' +
                                                    '<td>' + anh.path + '</td>' +
                                                    '</tr>'
                                                    );
                                        });
                                    }, 'json')
                                            .fail(function (error) {
                                                console.error('Error:', error);
                                            });
                                }
                                var selectedRowAnh;
                                function selectAnh(maanh) {
                                    if (selectedRowAnh) {
                                        selectedRowAnh.style.background = "none";
                                    }
                                    selectedRowAnh = document.getElementById('productRowAnh' + maanh);
                                    selectedRowAnh.style.background = "darkgrey";
                                    console.log("selectAnh có hoạt động");
                                    showDetailsAnh();
                                }
                                function showDetailsAnh() {
                                    var cells = selectedRowAnh.getElementsByTagName('td');
                                    document.getElementById('maanh').value = cells[0].innerText;
                                    document.getElementById('mau').value = cells[1].innerText;
                                    document.getElementById('madsspAnh').value = cells[2].innerText;
                                    var path = cells[3].innerText;
                                    document.getElementById('pathAnh').value = path;
                                    document.getElementById('productAnh').src = './assets/images/' + path;
                                    resetTableSize();
                                }
                                function resetFormAnh() { //xóa form ảnh
                                    document.getElementById('maanh').value = '';
                                    document.getElementById('mau').value = '';
                                    document.getElementById('madsspAnh').value = '';
                                    document.getElementById('pathAnh').value = '';
                                    document.getElementById('productAnh').src = '';
                                }
                                function addAnh() {
                                    var madsspAnh = document.getElementById('madsspAnh').value;
                                    var mau = document.getElementById('mau').value;
                                    var pathAnh = document.getElementById('pathAnh').value;
                                    var bodyData = "action=addAnh&madsspAnh=" + madsspAnh + "&mau=" + mau + "&pathAnh=" + pathAnh;
                                    fetch('admin', {method: 'POST', headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                        body: bodyData
                                    })
                                            .then(response => response.text())
                                            .then(data => {
                                                if (data === "true") {
                                                    alert('Thêm mới ảnh thành công!');
                                                    resetFormAnh();
                                                    resetTableAnh();
                                                } else
                                                    alert('Thêm mới không thành công!');
                                            })
                                            .catch(error => console.error('Error:', error));
                                }
                                function updateAnh() {
                                    var maanh = document.getElementById('maanh').value;
                                    var madsspAnh = document.getElementById('madsspAnh').value;
                                    var mau = document.getElementById('mau').value;
                                    var pathAnh = document.getElementById('pathAnh').value;
                                    var bodyData = "action=updateAnh&madsspAnh=" + madsspAnh + "&mau=" + mau + "&pathAnh=" + pathAnh + "&maanh=" + maanh;
                                    fetch('admin', {
                                        method: 'POST',
                                        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                        body: bodyData
                                    })
                                            .then(response => response.text())
                                            .then(data => {
                                                if (data === "true") {
                                                    alert('Cập nhật ảnh thành công!');
                                                    resetFormAnh();
                                                    resetTableAnh();
                                                } else {
                                                    alert('Cập nhật không thành công!');
                                                }
                                            })
                                            .catch(error => console.error('Error:', error));
                                }
                                function confirmDeleteAnh() {
                                    var isConfirmed = confirm('Bạn có chắc chắn muốn xóa ảnh này không?');
                                    if (isConfirmed) {
                                        deleteAnh();
                                    } else {
                                    }
                                }
                                function deleteAnh() {
                                    var maanh = document.getElementById('maanh').value;
                                    var bodyData = "action=deleteAnh&maanh=" + maanh;
                                    fetch('admin', {
                                        method: 'POST',
                                        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                        body: bodyData
                                    })
                                            .then(response => response.text())
                                            .then(data => {
                                                if (data === "true") {
                                                    alert('Xóa ảnh thành công!');
                                                    resetFormAnh();
                                                    resetTableAnh();
                                                } else {
                                                    alert('Xóa không thành công!');
                                                }
                                            })
                                            .catch(error => console.error('Error:', error));
                                }
/////////////////////// xử lý size
                                var selectedRowSize;
                                function selectSize(masp) {
                                    if (selectedRowSize) {
                                        selectedRowSize.style.background = "none";
                                    }
                                    selectedRowSize = document.getElementById('productRowSize' + masp);
                                    selectedRowSize.style.background = "darkgrey";
                                    console.log("selectAnh có hoạt động");
                                    showDetailsSize();
                                }
                                function showDetailsSize() {
                                    var cells = selectedRowSize.getElementsByTagName('td');
                                    document.getElementById('masp').value = cells[0].innerText;
                                    document.getElementById('maspanh').value = cells[1].innerText;
                                    document.getElementById('madsspsize').value = cells[2].innerText;
                                    document.getElementById('size').value = cells[3].innerText;
                                    document.getElementById('soluong').value = cells[4].innerText;
                                }
                                function resetTableSize() {
                                    var maanh = document.getElementById('maanh').value;
                                    $.post('admin', {action: 'getAllSize', maanh: maanh}, function (listSize) {
                                        $('.sizeRow').remove();
                                        $.each(listSize, function (i, size) {
                                            $('#TableSize').append(
                                                    '<tr id="productRowSize' + size.masp + '" class="sizeRow" onclick="selectSize(\'' + size.masp + '\')">' +
                                                    '<td>' + size.masp + '</td>' +
                                                    '<td>' + size.maanh + '</td>' +
                                                    '<td>' + size.madssp + '</td>' +
                                                    '<td>' + size.size + '</td>' +
                                                    '<td>' + size.soluong + '</td>' +
                                                    '</tr>'
                                                    );
                                        });
                                    }, 'json')
                                            .fail(function (error) {
                                                console.error('Error tablesize:', error);
                                            });
                                }
                                function resetFormSize() { //xóa form ảnh
                                    document.getElementById('masp').value = '';
                                    document.getElementById('maspanh').value = '';
                                    document.getElementById('madsspsize').value = '';
                                    document.getElementById('size').value = 'S';
                                    document.getElementById('soluong').value = '';
                                }
                                function addSize() {
                                    var maspanh = document.getElementById('maspanh').value;
                                    var soluong = document.getElementById('soluong').value;
                                    if (soluong === "")
                                        soluong = 0;
                                    var size = document.getElementById('size').value;
                                    var bodyData = "action=addSize&maspanh=" + maspanh + "&soluong=" + soluong + "&size=" + size;
                                    fetch('admin', {method: 'POST', headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                        body: bodyData
                                    })
                                            .then(response => response.text())
                                            .then(data => {
                                                if (data === "true") {
                                                    alert('Thêm mới Size thành công!');
                                                    resetFormSize();
                                                    resetTableSize();
                                                } else
                                                    alert('Thêm mới không thành công!');
                                            })
                                            .catch(error => console.error('Error:', error));
                                }
                                function confirmDeleteSize() {
                                    var isConfirmed = confirm('Bạn có chắc chắn muốn xóa size này không?');
                                    if (isConfirmed) {
                                        deleteSize();
                                    } else {
                                    }
                                }
                                function deleteSize() {
                                    var masp = document.getElementById('masp').value;
                                    var bodyData = "action=deleteSize&masp=" + masp;
                                    fetch('admin', {
                                        method: 'POST',
                                        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                        body: bodyData
                                    })
                                            .then(response => response.text())
                                            .then(data => {
                                                if (data === "true") {
                                                    alert('Xóa size thành công!');
                                                    resetFormSize();
                                                    resetTableSize();
                                                } else {
                                                    alert('Xóa không thành công!');
                                                }
                                            })
                                            .catch(error => console.error('Error:', error));
                                }
                                function updateSize() {
                                    var masp = document.getElementById('masp').value;
                                    var soluong = document.getElementById('soluong').value;
                                    if (soluong === "") soluong = 0;
                                    var bodyData = "action=updateSize&soluong=" + soluong + "&masp=" + masp;
                                    fetch('admin', {
                                        method: 'POST',
                                        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                        body: bodyData
                                    })
                                            .then(response => response.text())
                                            .then(data => {
                                                if (data === "true") {
                                                    alert('Cập nhật số lượng size thành công!');
                                                    resetFormSize();
                                                    resetTableSize();
                                                } else {
                                                    alert('Cập nhật không thành công!');
                                                }
                                            })
                                            .catch(error => console.error('Error:', error));
                                }

                                function openFileChooser() {
                                    var fileInput = document.createElement('input');
                                    fileInput.type = 'file';
                                    fileInput.addEventListener('change', function () {
                                        displayFilePathAndImage(fileInput);
                                    });
                                    fileInput.click();
                                }
                                function displayFilePathAndImage(input) {
                                    var productImage = document.getElementById('productImage');
                                    var pathInput = document.getElementById('path');
                                    if (input.files.length > 0) {
                                        var fileName = input.files[0].name;
                                        var reader = new FileReader();
                                        reader.onload = function (e) {
                                            productImage.src = e.target.result;
                                        };
                                        reader.readAsDataURL(input.files[0]);
                                        pathInput.value = fileName;
                                    } else {
                                        productImage.src = '';
                                        pathInput.value = '';
                                    }
                                }
                                function openFileChooserAnh() {
                                    var fileInput = document.createElement('input');
                                    fileInput.type = 'file';
                                    fileInput.addEventListener('change', function () {
                                        displayFilePathAnh(fileInput);
                                    });
                                    fileInput.click();
                                }
                                function displayFilePathAnh(input) {
                                    var productImage = document.getElementById('productAnh');
                                    var pathInput = document.getElementById('pathAnh');
                                    if (input.files.length > 0) {
                                        var fileName = input.files[0].name;
                                        var reader = new FileReader();
                                        reader.onload = function (e) {
                                            productImage.src = e.target.result;
                                        };
                                        reader.readAsDataURL(input.files[0]);
                                        pathInput.value = fileName;
                                    } else {
                                        productImage.src = '';
                                        pathInput.value = '';
                                    }
                                }
    </script>
</html>
