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
                        displayResult(getProduct($(".source").val()));
                    });
                    
                    function loadInitialData() {
                        var items = getAllProducts();
                        console.log(Date.now());
                        
                    }

                    function bindToSelectList(items) {
                        if (items === undefined || items === null || items.length === 0) return;
                        if (items.length === 1) {
                            $(".source").append("<option value='" + items.Id + "'>" + items.Name + "</option>");
                        } else {
                            $.each(items,
                                function(index, value) {
                                    $(".source").append("<option value='" + value.Id + "'>" + value.Name + "</option>");
                                });
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
                        .fail(function(xhr, status, ex) {
                            console.dir(xhr);
                            return ex;
                        });
                    }

                    function getProduct(pid){
                        $.ajax({
                                url: '/api/Products/GetProduct',
                                data: { id: pid },
                                type: "GET",
                                dataType: "json"
                            })
                            .done(function(data) {
                                displayResult($.parseJSON(data));
                            })
                            .fail(function(xhr, status, ex) {
                                console.log('Failed to retreive data from server');
                            })
                            .always(function() {
                                console.log('Operation Completed');
                            });

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
                });
                
                
            </script>
            
            <div class="myform">
                <select class="source"></select>
                <button id="getData">Get Data</button>
                <ul class="target"></ul>
            </div>
        </div>
    </div>
</body>
</html>