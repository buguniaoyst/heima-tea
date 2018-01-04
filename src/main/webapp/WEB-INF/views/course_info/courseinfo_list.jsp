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
   <div class="layui-form-item">
       <button class="layui-btn " id="addCourseModuleBtn">
           <i class="layui-icon">&#xe608;</i> 新增课程模块
       </button>
    </div>
    <div class="layui-form" >
        <table class="layui-table" style="height: 58px;" lay-even="" lay-skin="row" id="personTable">
            <colgroup>
                <col width="40">
                <col width="400">
                <col width="100">
                <col width="300">
                <col width="200">
                <col width="200">
                <col width="600">
            </colgroup>
            <thead>
            <tr>
                <th align="center"style="padding: 0;text-align: center">序号</th>
                <th align="center">模块名称</th>
                <th align="center">版本</th>
                <th align="center">所属学科</th>
                <th align="center">班级类型</th>
                <th align="center">状态</th>
                <th align="center">操作</th>
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
    var form;
    layui.use(['laypage', 'layer','laydate','jquery','form'],function() {
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        form = layui.form;

        var $ = layui.jquery;
        //执行一个laydate实例
//        laydate.render({
//            elem: '#test1' //指定元素
//        });

        //新增课程模块
        $(function () {
            $("#addCourseModuleBtn").click(function () {
                console.log(this);
                //自定页
                var contentStr = '<form method="post" class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/rest/course/addCourseModule">\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">所属学科</label>\n' +
                    '      <div class="layui-input-inline">\n' +
                    '        <select name="subjectId">\n' +
                    '        <option value="1" selected="">JavaEE</option>\n' +
                    '      </select>\n' +
                    '        <input type="hidden" value="JavaEE" name="subjectName" readonly="true" id="subjectNameId"  autocomplete="off" class="layui-input">\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">模块名称</label>\n' +
                    '      <div class="layui-input-inline">\n' +
                    '        <input type="text"  name="moduleName"    autocomplete="off" class="layui-input">\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">模块版本</label>\n' +
                    '      <div class="layui-input-block">\n' +
                    '        <input type="text" name="version" id="date1" autocomplete="off" class="layui-input">\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">班级类型</label>\n' +
                    '      <div class="layui-input-inline">\n' +
                    '        <select name="classType" id="classTypeId" onchange="getClassTypeName(1)">\n' +
                    '        <option value="0" selected="">基础班</option>\n' +
                    '        <option value="1" >就业班</option>\n' +
                    '      </select>\n' +
                    '        <input type="hidden" name="classTypeName" value="基础班" id="subjectNameId"  autocomplete="off" class="layui-input">\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-form-item">\n' +
                    '      <label class="layui-form-label">模块说明</label>\n' +
                    '      <div class="layui-input-block">\n' +
                    '       <input name="remark" placeholder="请输入内容" class="layui-input">\n' +
                    '       </div>\n' +
                    '  </div>\n' +
                    '\n' +
                    '  <div class="layui-form-item" >\n' +
                    '    <input type="submit" id="addCourceBtn" class="layui-btn"  value="添加">\n' +
                    '    <input type="reset"  class="layui-btn" value="重置">\n' +
                    '  </div>\n' +
                    '</form>';
                layer.open({
                    title:'添加课程模块',
                    type: 1,
                    skin: 'layui-layer-demo', //样式类名
                    area: ['650px', '300px'],
                    closeBtn: 1, //不显示关闭按钮
                    anim: 2,
                    shadeClose: true, //开启遮罩关闭
                    content: contentStr,
                    success: function(layero, index){
                        form.render();
                    }

                });
            });

        })



        //页面初始化的时候加载分页数据
        $(function(){
            //alert("页面初始化了.......");
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/course/getCourseModuleList",
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
                var moduleName = data[i].moduleName;
                var version = data[i].version;
                var subjectName = data[i].subjectName;
                var classTypeName = data[i].classTypeName;
                var status = data[i].status;


                var td1 = $("<td align='center'>"+i+"</td>")
                var td2 = $("<td align='center'>"+moduleName+"</td>");
                var td3 =  $("<td align='center'>"+version+"</td>");
                var td4 = $("<td align='center' >"+subjectName+"</td>");
                var td5 = $("<td align='center' >"+classTypeName+"</td>");
                var td6 ;
                if(status == '0'){
                    td6 =$("<td align='center' ><button class='layui-btn-warm' >禁用</button></td>");
                }else {
                    td6 =$("<td align='center' ><button class='layui-btn' >启用</button></td>");

                }
                var td7 = $("<td align='center' ><button class='layui-btn layui-btn-sm' ><i class='layui-icon' >&#xe642;</i> </button> <button class='layui-btn layui-btn-sm' id='showClassBtn' classId="+data[i].id+"><i class='layui-icon'>&#xe615;</i> </button><button class='layui-btn layui-btn-sm' id='deleteClassBtn' classId="+data[i].id+"> <i class='layui-icon'>&#xe640;</i> </button></td>");
                td1.appendTo(tr);
                td2.appendTo(tr);
                td3.appendTo(tr);
                td4.appendTo(tr);
                td5.appendTo(tr);
                td6.appendTo(tr);
                td7.appendTo(tr);
                tr.appendTo(table);
            }
            return table;
        };
    });



</script>
</body>
</html>
