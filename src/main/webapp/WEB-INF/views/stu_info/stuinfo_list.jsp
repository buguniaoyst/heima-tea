<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css" media="all">
    <script src="/lib/jquery-1.8.3.js"></script>
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
       <div class="layui-input-inline">
           <button class="layui-btn" id="goBack" onclick="history.go(-1);">
               <i class="layui-icon">&#xe603;</i> 返回班级管理
           </button>
       </div>
       <div class="layui-input-inline">
           <button class="layui-btn " id="addStudentBtn">
               <i class="layui-icon">&#xe608;</i> 新增学员
           </button>
       </div>
       <!--文件上传-->
       <form  id="jvForm" enctype="multipart/form-data" >
           <div class="layui-input-inline">
               <button class="layui-upload-button">
                   <input type="file" name="excelFile" onchange="importExcel()" />
               </button>
               <input type="hidden" id="classId" name="classId" value="${param.classId}">

           </div>
       </form>
    </div>
    <div class="layui-form" >
        <table class="layui-table" style="height: 58px;" lay-even="" lay-skin="row" id="personTable">
            <colgroup>
                <col width="40">
                <col width="400">
                <col width="400">
                <col width="200">
                <col width="600">
            </colgroup>
            <thead>
            <tr>
                <th align="center"style="padding: 0;text-align: center">序号</th>
                <th align="center">学生姓名</th>
                <th align="center">学号</th>
                <th align="center">性别</th>
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


<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script src="${pageContext.request.contextPath }/lib/jquery.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/lib/jquery.ext.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/lib/jquery.form.js" type="text/javascript"></script>

<script>
    var form;
    layui.use(['laypage', 'layer','laydate','form'],function() {
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        form = layui.form;

        //执行一个laydate实例
//        laydate.render({
//            elem: '#test1' //指定元素
//        });

        $(function () {
            $("#addStudentBtn").click(function () {
                console.log(this);
                //自定页
                var contentStr = '<form method="post" class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/rest/student/addStudentInfo">\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">学生姓名</label>\n' +
                    '      <div class="layui-input-block">\n' +
                    '        <input type="text" name="studentName"  autocomplete="off" class="layui-input">\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">班级</label>\n' +
                    '      <div class="layui-input-inline">\n' +
                    '        <input type="text" name="className" readonly="true" value="${param.className}"  autocomplete="off" class="layui-input">\n' +
                    '        <input type="hidden" name="classId" readonly="true" value="${param.classId}"  autocomplete="off" class="layui-input">\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">学号</label>\n' +
                    '      <div class="layui-input-block">\n' +
                    '        <input type="text" name="studentNo" id="date1" autocomplete="off" class="layui-input">\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">学科</label>\n' +
                    '      <div class="layui-input-inline">\n' +
                     '       <select name="subjectNo">\n' +
                        '        <option value="">请选择学科</option>\n' +
                        '        <option value="1" selected="">JavaEE</option>\n' +
                        '      </select>\n' +
                    '      </div>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '  <div class="layui-form-item">\n' +
                    '    <div class="layui-inline">\n' +
                    '      <label class="layui-form-label">性别</label>\n' +
                    '      <div class="layui-input-block">\n' +
                    '       <select name="sex">\n' +
                    '        <option value="">请选择性别</option>\n' +
                    '        <option value="1" selected="">男</option>\n' +
                    '        <option value="2" >女</option>\n' +
                    '      </select>\n' +                    '     ' +
                    ' </div>\n' +
                    '    </div>\n' +
                    '  </div>\n' +
                    '\n' +
                    '  <div class="layui-form-item" >\n' +
                    '    <button class="layui-btn"  >添加</button>\n' +
                    '    <input type="reset"  class="layui-btn" value="重置">\n' +
                    '  </div>\n' +
                    '</form>';
                layer.open({
                    title:'添加学员',
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

        });



        //页面初始化的时候加载分页数据
        $(function(){
            //alert("页面初始化了.......");

            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/student/queryStudentByClassId?classId=${param.classId}",
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
                var studentName = data[i].studentName;
                var studentNo = data[i].studentNo;
                var sex = data[i].sex;
                if(sex == '1') {
                    sex = '男';
                }else{
                    sex = '女';
                }

                var td1 = $("<td align='center'>"+i+"</td>")
                var td2 = $("<td align='center'>"+studentName+"</td>");
                var td3 =  $("<td align='center'>"+studentNo+"</td>");
                var td4 = $("<td align='center' >"+sex+"</td>");
                var td5 = $("<td align='center' ><button class='layui-btn layui-btn-sm' onclick='editStudentfo(this);' studentId="+data[i].id+"><i class='layui-icon' >&#xe642;</i> </button> <button class='layui-btn layui-btn-sm' id='showClassBtn' classId="+data[i].id+"><i class='layui-icon'>&#xe615;</i> </button><button class='layui-btn layui-btn-sm' id='deleteClassBtn' classId="+data[i].id+"> <i class='layui-icon'>&#xe640;</i> </button></td>");
                td1.appendTo(tr);
                td2.appendTo(tr);
                td3.appendTo(tr);
                td4.appendTo(tr);
                td5.appendTo(tr);
                tr.appendTo(table);
            }
            return table;
        };
    });

function editStudentfo(target) {
    console.log(target);
    console.log($(target).attr('studentId'));
    var id = $(target).attr('studentId');
    //根据id查询班级信息
    $.post("${pageContext.request.contextPath}/rest/student/queryStudentInfoById",
        {id:id},
        function (data) {
        if(data) {
            console.log(data);
            data = JSON.parse(data);
            var studentName = data.studentName;
            var className=data.className;
            var classId = data.classId;
            var studentNo = data.studentNo;
            var subjectNo = data.subjectNo;
            var sex = data.sex;


            if(sex == '1'){
                sex = '<div class="layui-inline">\n' +
                    '\t      <label class="layui-form-label">性别</label>\n' +
                    '\t      <div class="layui-input-inline">\n' +
                    '\t        <select name="sex">\n' +
                    '\t        <option value="">请选择性别</option>\n' +
                    '\t        <option value="1" selected="">男</option>\n' +
                    '\t        <option value="2">女</option>\n' +
                    '\t      </select>\n' +
                    '\t      </div>\n' +
                    '\t    </div>';
            }else{
                sex = '<div class="layui-inline">\n' +
                    '\t      <label class="layui-form-label">性别</label>\n' +
                    '\t      <div class="layui-input-inline">\n' +
                    '\t        <select name="sex">\n' +
                    '\t        <option value="">请选择性别</option>\n' +
                    '\t        <option value="1" >男</option>\n' +
                    '\t        <option value="2" selected="">女</option>\n' +
                    '\t      </select>\n' +
                    '\t      </div>\n' +
                    '\t    </div>';
            }

            var contentStr = '<form method="post" class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/rest/student/editStudent">\n' +
                '  <div class="layui-form-item">\n' +
                '    <div class="layui-inline">\n' +
                '      <label class="layui-form-label">学生姓名</label>\n' +
                '      <div class="layui-input-block">\n' +
                        '<input name="id"  type="hidden" value='+data.id+' >'+
                '        <input type="text" name="studentName"  value='+studentName+' autocomplete="off" class="layui-input">\n' +
                '      </div>\n' +
                '    </div>\n' +
                '    <div class="layui-inline">\n' +
                '      <label class="layui-form-label">班级</label>\n' +
                '      <div class="layui-input-inline">\n' +
                '        <select name="classId">\n' +
                '        <option value="">请选择班级</option>\n' +
                '        <option value='+classId+' selected="">${param.className}</option>\n' +
                '      </select>\n' +
                '      </div>\n' +
                '    </div>\n' +
                '  </div>\n' +
                '  <div class="layui-form-item">\n' +
                '    <div class="layui-inline">\n' +
                '      <label class="layui-form-label">学号</label>\n' +
                '      <div class="layui-input-inline">\n' +
                '        <input type="text" name="studentNo" value='+studentNo+' autocomplete="off" class="layui-input">\n' +
                '      </div>\n' +
                '    </div>\n' +
                '    <div class="layui-inline">\n' +
                '      <label class="layui-form-label">学科</label>\n' +
                '      <div class="layui-input-inline">\n' +
                '        <select name="subjectNo">\n' +
                '        <option value="1" selected="">JavaEE</option>\n' +
                '      </select>\n' +
                '      </div>\n' +
                '    </div>\n' +
                '  </div>\n' +
                '  <div class="layui-form-item">\n' +
                sex+
                '  </div>\n' +
                '\n' +
                '  <div class="layui-form-item" >\n' +
                '    <button class="layui-btn"  >修改</button>\n' +
                '    <input type="reset"  class="layui-btn" value="重置">\n' +
                '  </div>\n' +
                '</form>';

            layer.open({
                title:'修改学生信息',
                type: 1,
                skin: 'layui-layer-demo', //样式类名
                area: ['650px', '350px'],
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

    function importExcel(){
        var options = {
            url : "${pageContext.request.contextPath}/rest/student/importStudentInfo",
            type : "post",
            dataType : "json",
            success : function(data) {
                console.log(data);
                location.href = "${pageContext.request.contextPath}/rest/stu_info/stuinfo_list?classId=${param.classId}";
            }
        }
        $("#jvForm").ajaxSubmit(options);
    }


</script>
</body>
</html>
