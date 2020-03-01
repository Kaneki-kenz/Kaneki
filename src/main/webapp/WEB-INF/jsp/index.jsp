<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Port Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="/bootstrap/jquery-1.9.1.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="/bootstrap/js/bootstrap.min.js"></script>
    <style type="text/css">
        body
        {
            margin: 0 auto;
            padding: 0;

        }
        #dataTable
        {
            width: 860px;
            border-top: none;

        }

        table
        {
            padding: 0;
            margin: 0;
            font-size: 18px;
            font-family: "Comic Sans MS";
        }

        table th,td
        {
            text-align: center;
            line-height: 40px;

        }

    </style>
</head>
<body>
<center>
<h1>Spring Boot JSP</h1>
    <input type="hidden" id="#Cname" value=""/>
    <input type="hidden" id="#IP" value=""/>
    <form class="form-inline">
        <div class="form-group">
            <label for="CountryName">CountryName</label>
            <input type="text" class="form-control" id="CountryName" placeholder="输入国家名字">
        </div>
        <div class="form-group">
            <label for="IPAddress">IP</label>
            <input type="text" class="form-control" id="IPAddress" placeholder="输入IP地址">
        </div>
        <a href="#" onclick="Search()" class="btn btn-success" >Search</a>
    </form>


    <div  id="dataTable" class="table-responsive">
        <table class="table table-bordered table-hover "   >
            <thead><th width="220px">Country</th><th width="220px">Port Number</th><th width="220px">IP Address</th><th width="170px">Operation</th></thead>
            <tbody></tbody>
        </table>

        <nav aria-label="Page navigation">
            <ul id="Page_navigation" class="pagination pagination-lg">
            </ul>
        </nav>
        <b style="font-size: 16px;">当前页: <span id="nowPage">1</span></b>
        <b style="font-size: 16px;">共有<span id="Pagecount"></span>条数据</b>
    </div>
</center>

<span id="input_country" style="display: none"></span>
<span id="input_ip" style="display: none"></span>




<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document" style="width: 400px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Change Information</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="CountryName">CountryName</label>
                    <span style="display: none" id="cid"></span>
                    <input type="text" class="form-control" id="Change_Cname" placeholder="输入国家名称">
                </div>
                <div class="form-group">
                    <label for="IPAddress">Port</label>
                    <span style="display: none" id="pid"></span>
                    <input type="text" class="form-control" id="Change_Port" placeholder="输入端口号">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="Close">Close</button>
                <button type="button" class="btn btn-primary" onclick="Save_Change()">Save changes</button>
            </div>
        </div>
    </div>
</div>

<!-- Small modal -->
<button id="changeResult" type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-sm" style="display: none" >Small modal</button>

<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog modal-sm" role="document">

        <div class="modal-content" style="text-align: center;height: 120px;">
            <div id="ResultText" style="margin-top: 40px;"></div>
            <i class="glyphicon glyphicon-ok" style="font-size: 25px; color: #4cae4c;"></i>
        </div>
    </div>
</div>

</body>
</html>


<script type="text/javascript">
    let ChangeBtn = "<button name='change_btn' class=\"btn btn-info\" data-toggle=\"modal\" data-target=\"#myModal\" onclick='TP_INFO(this)' >修改</button>";
    let DeleteBtn = "<button name='del_btn'  class=\"btn btn-danger\">删除</button>";
    let total_data_count = 0;
    window.onload = getData(null,null,0);

    function getData(CountryName,ip,skipRows)
    {
        let queryString = "?skipRows=" + skipRows;
        if (CountryName){
            queryString += "&countryName="+CountryName;
        }
        if (ip)
        {
            queryString += "&ip="+ip;
        }
        alert(CountryName+" : "+ip);
        Page_Count(CountryName,ip);

        $.ajax({
            type:"GET",
            url: "http://"+window.location.host+"/query"+queryString,
            success:function (data) {
                let HTML = "";
                for(let item of data)
                {
                    if(item.ip == null)
                    {
                        item.ip="";
                    }
                    HTML  += "<tr>" +
                        "<td name='"+item.countryId+"'>"+item.country.countryName+"</td>" +
                        "<td name='"+item.portId+"'>"+item.portString+"</td>" +
                        "<td>"+(item.ip)+"</td>" +
                        "<td>"+ChangeBtn+"&nbsp;&nbsp;&nbsp;"+DeleteBtn+"</td>"+
                        "</tr>";
                }
                $("table tbody").html(HTML);
            }
    });
    }

    function Search() {
        $("#nowPage").html("1");
        let country_name = $('#CountryName').val();
        let ip_address  = $('#IPAddress').val();
        if(country_name =="" || country_name== undefined )
        {
            country_name = null;
        }
        if(ip_address =="" || ip_address == undefined)
        {
            ip_address = null;
        }

        $("#input_country").html(country_name);
        $("#input_ip").html(ip_address);
        getData(country_name,ip_address,0);
    }

    function Page_Count(Country_Name,IP_address) {
        let params = "";
        if( (Country_Name!=null && Country_Name!="")  && (IP_address!=null && IP_address!="" ) )       // IP有  CountryName 有
        {
            params +="?countryName="+Country_Name+"&ip="+IP_address;
        }
        else
        {
            if( (Country_Name!=null || Country_Name!="") && (IP_address==null || IP_address == "" ) )   // IP无  CountryName 有
            {
                params = "?countryName="+Country_Name;
            }
            if( (Country_Name==null || Country_Name=="") && (IP_address!=null || IP_address != "" ) )   // IP有  CountryName 无
            {
                params = "?ip="+IP_address;
            }
        }

        $.ajax({
            type: "GET",
            url:  "http://"+window.location.host+"/queryNot_limit"+params,
            success:function (data) {
                total_data_count = data;
                $("#Pagecount").html(total_data_count);
                let tdc_dev = Math.floor(total_data_count/10);
                let tdc_mod = total_data_count%10;
                if(tdc_mod > 0)
                {
                    tdc_dev++;
                }
                // Clear HTML
                $("#Page_navigation").html("");

                // Prev
                $("#Page_navigation").append("<li>\n" +
                    "     <a href=\"#\" onclick='prev()' aria-label=\"Previous\">\n" +
                    "     <span aria-hidden=\"true\">&laquo;</span>\n" +
                    "     </a>\n" +
                    "     </li>");

                // Page Num
                for(let j=0;j<tdc_dev;j++)
                {
                    $("#Page_navigation").append("<li><a href='#' onclick='skip_Page(this)'>"+(j+1)+"</a></li>");
                }

                // Next Page
                $("#Page_navigation").append("<li>\n" +
                    "     <a href=\"#\" onclick='next()' aria-label=\"Next\">\n" +
                    "     <span aria-hidden=\"true\">&raquo;</span>\n" +
                    "     </a>\n" +
                    "     </li>");
            }
        });
    }

    function skip_Page(obj) {
        let i_cn =  $("#input_country").html();
        let i_ip = $("#input_ip").html();
        let to_page = $(obj).html();
        let skip_num = (to_page-1) * 10;
        $("#nowPage").html(to_page);
        getData(i_cn,i_ip,skip_num);
    }


    function prev() {
        let now_page = $("#nowPage").html();
        let i_cn =  $("#input_country").html();
        let i_ip = $("#input_ip").html();
        if((Number(now_page)-1) > 0)
        {
            $("#nowPage").html((Number(now_page)-1));
            getData(i_cn,i_ip,((Number(now_page)-1-1))*10);
        }
        // if(now_page !=min_page ) getData(G_Cname,G_IP,(now_page-2)*10);
    }

    function next() {
        let now_page = $("#nowPage").html();
        let i_cn =  $("#input_country").html();
        let i_ip = $("#input_ip").html();
        let max_page = Math.floor(total_data_count/10);
        let max_page_mod = total_data_count%10;
        if(max_page_mod > 0)
        {
            max_page++;
        }

        if( (Number(now_page)) < max_page )
        {
            // alert("nowpage : "+ now_page + "  maxpage : " + max_page);
            $("#nowPage").html((Number(now_page)+1));
            getData(i_cn,i_ip,(Number(now_page))*10);
        }
    }


    function TP_INFO(obj) {
        let $CountryID_AND_Name = $(obj).parent().prev().prev().prev();
        let cid = $CountryID_AND_Name.attr("name");
        let cn = $CountryID_AND_Name.html();

        let $PortID_AND_NUM = $(obj).parent().prev().prev();
        let pid = $PortID_AND_NUM.attr("name");
        let pn = $PortID_AND_NUM.html();

        $("#cid").html(cid);
        $("#pid").html(pid);

        $("#Change_Cname").val(cn);
        $("#Change_Port").val(pn);
    }

    function Save_Change() {
        let input_cname = $("#Change_Cname").val();
        let input_port = $("#Change_Port").val();
        let portID = $("#pid").html();
        if(input_cname!=undefined && input_cname.trim()!="" && input_port!=undefined && input_port.trim()!="")
        {
            $.ajax({
                type:"GET",
                url:"http://"+window.location.host+"/ChangeCountryInfo?countryName="+input_cname+"&portString="+input_port+"&portId="+portID,
                success:function (data) {
                    if(data == 1)
                    {
                        // 修改成功
                        $("#Close").trigger("click");
                        $("#changeResult").trigger("click");
                        $("#ResultText").html("<b style='font-size: 20px'>修改成功</b>");
                    }
                    else
                    {
                        alert("修改失败！");
                    }
                }
            });
        }
        else
        {
            alert("内容不能为空");
        }

    }


</script>
