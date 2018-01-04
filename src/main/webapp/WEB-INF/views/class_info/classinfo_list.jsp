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
   <div class="layui-form-item">
       <button class="layui-btn" id="addClassBtn">
           <i class="layui-icon">&#xe608;</i> 新增班级
       </button>
    </div>
    <div class="layui-form" >
        <table class="layui-table" style="height: 58px;" lay-even="" lay-skin="row" id="personTable">
            <colgroup>
                <col width="40">
                <col width="600">
                <col width="200">
                <col width="400">
                <col width="400">
                <col width="600">
            </colgroup>
            <thead>
            <tr>
                <th align="center"style="padding: 0;text-align: center">序号</th>
                <th align="center">班级名称</th>
                <th align="center">班级类型</th>
                <th align="center">班主任</th>
                <th align="center">助教</th>
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

        $(function () {
            $("#addClassBtn").click(function () {
                console.log(this);
                //自定页
                var contentStr = '<form method="post" class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/rest/class/addClass">\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">班级名称</label>\n' +
                    '      <div class="layui-input-block">\n' +
                    '        <input type="text" name="className"  autocomplete="off" class="layui-input">\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">班级类型</label>\n' +
                    '      <div class="layui-input-inline">\n' +
                    '        <select name="classType">\n' +
                    '        <option value="">请选择省</option>\n' +
                    '        <option value="0" selected="">基础班</option>\n' +
                    '        <option value="1">就业班</option>\n' +
                    '      </select>\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">班主任</label>\n' +
                    '      <div class="layui-input-block">\n' +
                    '        <input type="text" name="masterName" id="date1" autocomplete="off" class="layui-input">\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">助教</label>\n' +
                    '      <div class="layui-input-inline">\n' +
                    '        <input type="text" name="assistant" autocomplete="off" class="layui-input">\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">学生数量</label>\n' +
                    '      <div class="layui-input-block">\n' +
                    '        <input type="text" name="studentCount"  autocomplete="off" class="layui-input">\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">开班日期</label>\n' +
                    '      <div class="layui-input-inline">\n' +
                    '         <input type="text" name="startDate" class="layui-input" id="startDate">\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '\n' +
                    '  <div class="layui-form-item" >\n' +
                    '    <button class="layui-btn"  >添加</button>\n' +
                    '    <input type="reset"  class="layui-btn" value="重置">\n' +
                    '  </div>\n' +
                    '</form>';
                layer.open({
                    title:'添加班级',
                    type: 1,
                    skin: 'layui-layer-demo', //样式类名
                    area: ['650px', '300px'],
                    closeBtn: 1, //不显示关闭按钮
                    anim: 2,
                    shadeClose: true, //开启遮罩关闭
                    content: contentStr,
                    success: function(layero, index){
                        layui.use(['laypage', 'layer','laydate','jquery','form'],function() {
                            var laydate = layui.laydate;
                            var laypage = layui.laypage;
                            var  form = layui.form;
                            form.render();
                            laydate.render({
                                    elem: '#startDate', //指定元素
                                    format: 'yyyy/MM/dd'
                               });
                        });

                    }

                });
            });

        })



        //页面初始化的时候加载分页数据
        $(function(){
            //alert("页面初始化了.......");

            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/class/classList",
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

                var className = data[i].className;
                var classType = data[i].classType;
                var masterName = data[i].masterName;
                var assistant = data[i].assistant;
                var classId = data[i].id;

                var td1 = $("<td align='center'>"+i+"</td>")
                var td2 = $("<td align='center'>"+className+"</td>");
                var td3 ;
                if(classType == '0'){
                    td3 =  $("<td align='center'><button  class='layui-btn  layui-btn-radius' >基础班</button></td>");
                }else{
                    td3 =  $("<td align='center'><button  class='layui-btn layui-btn-radius layui-btn-warm' >就业班</button></td>");
                }
                var td4 = $("<td align='center' >"+masterName+"</td>");
                var td5 = $("<td align='center' >"+assistant+"</td>");
                var td6 = $("<td align='center' ><a href="+'/rest/stu_info/stuinfo_list?classId='+classId+'&className='+className+" ><button class='layui-btn layui-btn-sm' >学员信息</button></a>&nbsp;&nbsp;<button class='layui-btn layui-btn-sm' onclick='editClassInfo(this);' classId="+data[i].id+"><i class='layui-icon' >&#xe642;</i> </button> <button class='layui-btn layui-btn-sm' id='showClassBtn' classId="+data[i].id+"><i class='layui-icon'>&#xe615;</i> </button><button class='layui-btn layui-btn-sm' id='deleteClassBtn' classId="+data[i].id+"> <i class='layui-icon'>&#xe640;</i> </button></td>");
                td1.appendTo(tr);
                td2.appendTo(tr);
                td3.appendTo(tr);
                td4.appendTo(tr);
                td5.appendTo(tr);
                td6.appendTo(tr);
                tr.appendTo(table);
            }
            return table;
        };
    });

function editClassInfo(target) {
    console.log(target);
    console.log($(target).attr('classId'));
    var id = $(target).attr('classId');
    //根据id查询班级信息
    $.post("${pageContext.request.contextPath}/rest/class/queryClassById",{id:id},function (data) {
        if(data) {
            console.log(data);
            var className = data.className;
            var classType=data.classType;
            var masterName = data.masterName;
            var assistant = data.assistant;
            var studentCount = data.studentCount;
            var startDate = data.startDate;
            if(classType == '0'){
                var classTypeStr = '<div class="layui-inline">\n' +
                    '\t      <label class="layui-form-label">班级类型</label>\n' +
                    '\t      <div class="layui-input-inline">\n' +
                    '\t        <select name="classType">\n' +
                    '\t        <option value="">请选择省</option>\n' +
                    '\t        <option value="0" selected="">基础班</option>\n' +
                    '\t        <option value="1">就业班</option>\n' +
                    '\t      </select>\n' +
                    '\t      </div>\n' +
                    '\t    </div>';
            }else{
                var classTypeStr = '<div class="layui-inline">\n' +
                    '\t      <label class="layui-form-label">班级类型</label>\n' +
                    '\t      <div class="layui-input-inline">\n' +
                    '\t        <select name="classType">\n' +
                    '\t        <option value="">请选择省</option>\n' +
                    '\t        <option value="0" >基础班</option>\n' +
                    '\t        <option value="1" selected="">就业班</option>\n' +
                    '\t      </select>\n' +
                    '\t      </div>\n' +
                    '\t    </div>';
            }

            var contentStr = '<form method="post" class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/rest/class/editClass">\n' +
                '  <div class="layui-form-item">\n' +
                '    <div class="layui-inline">\n' +
                '      <label class="layui-form-label">班级名称</label>\n' +
                '      <div class="layui-input-block">\n' +
                    '<input name="id"  type="hidden" value='+data.id+' >'+
                '        <input type="text" name="className"  value='+className+' autocomplete="off" class="layui-input">\n' +
                '      </div>\n' +
                '    </div>\n' +
                        classTypeStr+
                '  </div>\n' +
                '  <div class="layui-form-item">\n' +
                '    <div class="layui-inline">\n' +
                '      <label class="layui-form-label">班主任</label>\n' +
                '      <div class="layui-input-block">\n' +
                '        <input type="text" name="masterName"  value='+masterName+' id="date1" autocomplete="off" class="layui-input">\n' +
                '      </div>\n' +
                '    </div>\n' +
                '    <div class="layui-inline">\n' +
                '      <label class="layui-form-label">助教</label>\n' +
                '      <div class="layui-input-inline">\n' +
                '        <input type="text" name="assistant" value='+assistant+' autocomplete="off" class="layui-input">\n' +
                '      </div>\n' +
                '    </div>\n' +
                '  </div>\n' +
                '  <div class="layui-form-item">\n' +
                '    <div class="layui-inline">\n' +
                '      <label class="layui-form-label">学生数量</label>\n' +
                '      <div class="layui-input-block">\n' +
                '        <input type="text" name="studentCount" value='+studentCount+' autocomplete="off" class="layui-input">\n' +
                '      </div>\n' +
                '    </div>\n' +
                '    <div class="layui-inline">\n' +
                '      <label class="layui-form-label">开班日期</label>\n' +
                '      <div class="layui-input-inline">\n' +
                '         <input type="text" name="startDate" value='+startDate+' class="layui-input" id="test1">\n' +
                '      </div>\n' +
                '    </div>\n' +
                '  </div>\n' +
                '\n' +
                '  <div class="layui-form-item" >\n' +
                '    <button class="layui-btn"  >修改</button>\n' +
                '    <input type="reset"  class="layui-btn" value="重置">\n' +
                '  </div>\n' +
                '</form>';

            layer.open({
                title:'修改班级信息',
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


        }

    })



}


</script>
</body>
</html>
