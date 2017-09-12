<%@ Page Language="C#"  AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="tstAjaxAndJQuery._Default" %>

<html>
<head>
    <title>asda</title>    
</head>
    <body>
    <div class="row">
        <div class="col-md-4">
            <%: Scripts.Render("~/bundles/jquery") %>
            <script>
                $(document).ready(function() {
                    //Init
                    loadInitialData();

                    $("#getData").click(function () {
                        console.log('sdfsd');
                        getProduct($(".source").val());
                    });
                    $("[name='addProduct']").click(function() {
                        var prod = {
                            Id: $("[name='id']").val(),
                            Name: $("[name='name']").val(),
                            Price: $("[name='price']").val(),
                            Quantity: $("[name='qty']").val()
                        };

                        addProduct(prod);
                    });
                    $("[name='deleteProduct'").click(function() {
                        deleteProduct($("[name='id']").val());
                    });
                    function loadInitialData() {
                        getAllProducts();
                        console.log(Date.now());
                        
                    }
                    function bindToSelectList(items) {
                        if (items === undefined || items === null || items.length === 0) return;
                        $(".source").html('');
                        if (items.length === 1) {
                            $(".source").append("<option value='" + items.Id + "'>" + items.Name + "</option>");
                        } else {
                            $.each(items,
                                function(index, value) {
                                    $(".source").append("<option value='" + value.Id + "'>" + value.Name + "</option>");
                                });
                        }
                    }
                    function displayResult(res) {
                        $(".target").html('');
                        if (res.length > 1) {
                            $.each(res,
                                function(index, value) {
                                    $(".target").append("<li>" + value.Name + " [ " + value.Price + " L.E.]</li>");
                                });
                        } else {
                            $(".target").append("<li>" + res.Name + " [ " + res.Price + " L.E.]</li>");
                        }
                    }
                    function getAllProducts() {
                        $.ajax({
                                url: '/api/Products/GetAllProducts',
                                type: 'GET',
                                async: false,
                                dataType: 'json'
                            })
                            .done(function (data) {
                                bindToSelectList($.parseJSON(data));
                            })
                            .fail(function (xhr, status, ex) {
                                console.dir(xhr);
                                return ex;
                            });
                    }
                    function getProduct(pid) {
                        $.ajax({
                                url: '/api/Products/GetProduct',
                                data: { id: pid },
                                type: "GET",
                                dataType: "json"
                            })
                            .done(function (data) {
                                editProduct($.parseJSON(data));
                            })
                            .fail(function (xhr, status, ex) {
                                console.log('Failed to retreive data from server');
                            })
                            .always(function () {
                                console.log('Operation Completed');
                            });

                    }
                    function editProduct(item) {
                        $("[name='id']").val(item.Id);
                        $("[name='name']").val(item.Name);
                        $("[name='price']").val(item.Price);
                        $("[name='qty']").val(item.Quantity);
                    }
                    function addProduct(prod) {
                        $.ajax({
                                url: '/api/Products/AddProduct',
                                data: prod,
                                type: 'POST'
                            })
                            .done(function(data) {
                                if (data === true) {
                                    getAllProducts();
                                    clearFields();
                                }
                            })
                            .fail(function(xhr, status, exception) {
                                console.dir(xhr);
                            });
                    }
                    function deleteProduct(pid) {
                        $.ajax({
                            url: '/api/Products/DeleteProduct',
                                data: {id: pid},
                                type: 'POST'
                            })
                            .done(function (data) {
                                if (data === true) {
                                    getAllProducts();
                                    clearFields();
                                }
                            })
                            .fail(function (xhr, status, exception) {
                                console.dir(xhr);
                            });
                    }
                    function clearFields() {
                        $("[name='id']").val('');
                        $("[name='name']").val('');
                        $("[name='price']").val('');
                        $("[name='qty']").val('');
                    }
                });
                
                
            </script>
            
            <div class="myform">
                <select class="source"></select>
                <button id="getData">Get Data</button>
                <ul class="target"></ul>
            </div>
            
            <div class ="addprod">
                ID <input type="text" name="id"/><br/>
                Name <input type="text" name="name"/><br/>
                Price <input type="text" name="price"/><br/>
                Qty <input type="text" name="qty"/><br/>
                
                <button name="addProduct">Add Product</button>
                <button name="deleteProduct">Delete Product</button>
            </div>
        </div>
    </div>
</body>
</html>