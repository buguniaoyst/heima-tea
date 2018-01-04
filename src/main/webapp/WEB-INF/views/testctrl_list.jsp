<%--
  Created by IntelliJ IDEA.
  User: yst
  Date: 2017/7/20
  Time: 0:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>试卷管理列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css" media="all">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/lay/modules/laypage.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
<!-- 列表面板 -->
<div class="layui-form-pane" style="margin-top: 15px;">
    <!-- 列表操作按钮组 -->
   <%-- <div class="layui-form-item">
        <button id="exportbtn" class="layui-btn layui-btn-warm" lay-filter="exportpro">导出数据</button>&nbsp;&nbsp;&nbsp;&nbsp;
    </div>--%>
    <div class="layui-form" >
        <table class="layui-table" style="height: 58px;" lay-even="" lay-skin="row" id="personTable">
            <colgroup>
                <col width="600">
                <col width="400">
                <col width="600">
                <col width="400">
            </colgroup>
            <thead>
            <tr>
<%--
                <th align="center"><input type="checkbox" id="layui-table-checkbox" name="id" lay-skin="primary" lay-filter="allChoose"></th>
--%>
                <th align="center"style="padding: 0;text-align: center">班级名称</th>
                <th align="center">班级类型</th>
                <th align="center">试卷名称</th>
                <th align="center">试卷状态</th>
            </tr>
            </thead>
            <tbody id="tbody">
            </tbody>
        </table>
    </div>
    <div id="demo5" align="center"></div>
    <!-- <div id="demo7" align="center"></div> -->
</div>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script src="/lib/jquery-1.8.3.js"></script>
<script>
    layui.use(['laypage', 'layer','laydate','jquery','form'],function() {
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        var form = layui.form;
        var $ = layui.jquery;


        //页面初始化的时候加载分页数据
        $(function(){
            //alert("页面初始化了.......");

            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/test/listTest",
                //记得加双引号  T_T
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    nums = data.pagesize; //每页出现的数量
                    pageData = data;
                    var pages = Math.ceil(data.results.length / nums); //得到总页数
                    //调用分页
                    laypage({
                        cont: 'demo5',
                        pages: pages,
                        jump: function (obj) {
                            thisDate(obj.curr)
                            console.log( thisDate(obj.curr));
                            form.render();
                        }
                    })
                    return;
                },
                error: function (err) {
                    alert(err + "err");
                }
            });



        })

        //分页数据
        var pageData ;
        var nums = 1; //每页出现的数量
        var pages = 1;
        var thisDate = function (curr) {
            //此处只是演示，实际场景通常是返回已经当前页已经分组好的数据
            data = pageData.results;
            var str = '', last = curr * nums - 1;
            last = last >= data.length ? (data.length - 1) : last;
            var table = $("#tbody");
            $("#tbody tr").empty();//每次进来先清空table
            for (var i = (curr * nums - nums); i <= last; i++) {
                // str += '<li>' + data[i] + '</li>';
                var tr=$("<tr></tr>");
                var className;
                var classType;
                var testName;
                var testId;
                if (data[i].classTestNo == '0') {
                    testName = "基础班开班考试试卷";

                }else{
                    testName = "就业班开班考试试卷";
                }

                if (data[i].classTestNo == '0') {
                    classType = "基础班";

                }else{
                    classType = "就业班";
                }

                className = data[i].className;
                var classId = data[i].classId;
                testId = data[i].testId;
                var td1 = $("<td align='center'>"+className+"</td>")
                var td2 = $("<td align='center'>"+classType+"</td>");
                var td3 = $("<td align='center'>"+testName+"</td>");
                var td4 ;
                if(data[i].testStatus == "开启"){
                    td4 = $("<td align='center' >  <button class='layui-btn layui-btn-radius'  onclick='stopTest("+testId+","+classId+");'>已开启</button></td>");
                }else{
                    td4 = $("<td align='center' ><button  class='layui-btn layui-btn-warm layui-btn-radius' onclick='startTest("+testId+");'>已关闭</button></td>");
                }
                td1.appendTo(tr);
                td2.appendTo(tr);
                td3.appendTo(tr);
                td4.appendTo(tr);
                tr.appendTo(table);
            }
            return table;
        };


        /**
         * 导出统计数据
         */
        $('#exportbtn').click(function () {
          var form =  $("<form>").attr({
               "action":"/rest/pro/export_prolist",
               "method":"post"
           });
            $(document.body).append(form);
            form.submit();
        });


    });

    //关闭考试
    function stopTest(testid,classId) {
        //询问框
        layer.confirm('确定要结束此次考试吗？', {
            btn: ['结束','不结束'] ,//按钮
            skin: 'layui-layer-molv'
        }, function(){
            location.href = "/rest/test/stopTest?testId="+testid+"&classId="+classId;
            layer.msg('的确很重要', {icon: 1});
        }, function(){
            layer.msg('暂时不结束', {
                time: 20000, //20s后自动关闭
                btn: ['明白了', '知道了']
            });
        });
    }

    //开启考试
    function startTest(testid) {
        alert(testid);
    }
</script>
</body>
</html>
