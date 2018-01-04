<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>试卷管理列表</title>
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
<div class="layui-form layui-form-pane"  style="margin-top: 15px;margin-left: 5px;">
    <!-- 列表操作按钮组 -->
    <div class="layui-form-item">

        <div class="layui-input-inline">
            <div class="layui-inline">
                <button class="layui-btn layui-btn-radius" id="addCourseScheduleBtn">新增课表</button>
            </div>
        </div>

        <label class="layui-form-label">班级名称</label>
        <div class="layui-input-inline">
            <input class="layui-input" name="className" id="classNameId">
        </div>

        <div class="layui-inline">
            <button class="layui-btn layui-btn-radius" id="courseScheduleQueryBtn">查询</button>
            <button class="layui-btn layui-btn-radius" id="diaryQueryExport">导出数据</button>
        </div>
    </div>
    <div class="layui-form" >
        <table class="layui-table" style="height: 58px;" lay-even="" lay-skin="row" id="personTable">
            <colgroup>
                <col width="60">
                <col width="400">
                <col width="200">
                <col width="200">
                <col width="200">
                <col width="200">
            </colgroup>
            <thead>
            <tr>
                <th align="center"style="padding: 0;text-align: center">序号</th>
                <th align="center">班级名称</th>
                <th align="center">最后更新时间</th>
                <th align="center">最后修改人</th>
                <th align="center">结课时间</th>
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
                url: "${pageContext.request.contextPath}/rest/course_schedule/queryCourseScheduleList",
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

        });

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

                var className = data[i].className;
                var lastUpdateTime = formatDate(data[i].lastUpdateTime);
                var lastUpdater= data[i].lastUpdater;
                var endDate = formatDate(data[i].endDate);

                var tr = $("<tr></tr>");
                var td1 = $("<td align='center'>"+i+"</td>")
                var td2 = $("<td align='center'>"+className+"</td>");
                var td3 = $("<td align='center'>"+lastUpdateTime+"</td>");
                var td4 = $("<td align='center'>"+lastUpdater+"</td>");
                var td5 = $("<td align='center'>"+endDate+"</td>");
                var td6 = $("<td align='center' ><button   onclick="+'openCourseSchedule('+data[i].id+','+'"'+className+'")'+" class='layui-btn  layui-btn-radius' >查看详情</button></td>");
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





        //根据条件查询课表
        $("#courseScheduleQueryBtn").click(function () {
            //班级名称
            var className = $("#classNameId").val();
            //拼接条件查询
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/course_schedule/getCourseScheduleByExample",
                data: {className:className},
                dataType: "json",
                success: function(data){
                    layui.use(['laypage', 'layer','laydate','jquery','form'],function() {
                        var laydate = layui.laydate;
                        var laypage = layui.laypage;
                        var form = layui.form;
                        var $ = layui.jquery;

                  //  console.log(result);
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
                    })  });
                    return;
                }

            });

        })


        /**
         * 导出统计数据
         */
        $('#diaryQueryExport').click(function () {
            //获取参数
            //课程模块
            var courseModuleId = $("#courseModuleId").val();
            //作者
            var createrId = $("#assistantId").val();
            //fromDate
            var fromDate = $("#fromDate").val();
            //endDate
            var endDate = $("#endDate").val();
            var form =  $("<form>").attr({
                "action":"/rest/diary/exportDiaryList?courseModuleId="+courseModuleId+"&createrId="+createrId+"&fromDate="+fromDate+"&endDate="+endDate,
                "method":"post"
            });
            $(document.body).append(form);
            form.submit();
        });
    });


    $(function () {
        /**
         * 新增课表
         */
        $("#addCourseScheduleBtn").click(function () {
            console.log(this);
            var classOption = '<option value="">请选择班级</option>';
            //加载班级信息
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/class/classList",
                data: {classType:0},
                dataType: "json",
                success: function(data){
                   var result = data.results;
                    $.each(result, function(i,item){
                        classOption += "<option  value="+item.id+','+item.className+" >" + item.className + "</option>";
                    });
                    //自定页
                    var contentStr = '<form method="post" class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/rest/course_schedule/addCourseSchedule">\n' +
                        '  <div class="layui-form-item">\n' +
                        '    <div class="layui-inline">\n' +
                        '      <label class="layui-form-label">班级</label>\n' +
                        '      <div class="layui-input-inline">\n' +
                        '       <select name="className" id="classListId">\n'+classOption+
                        '      </select>\n' +
                        '      </div>\n' +
                        '    </div>\n' +
                        '    <div class="layui-inline">\n' +
                        '      <label class="layui-form-label">班主任</label>\n' +
                        '      <div class="layui-input-inline">\n' +
                        '        <input type="text" name="masterName"   autocomplete="off" class="layui-input">\n' +
                        '      </div>\n' +
                        '    </div>\n' +
                        '  </div>\n' +
                        '  <div class="layui-form-item">\n' +
                        '    <div class="layui-inline">\n' +
                        '      <label class="layui-form-label">结课日期</label>\n' +
                        '      <div class="layui-input-block">\n' +
                        '        <input type="text" name="endDate" id="endDate"  class="layui-input">\n' +
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
                        title:'新增课表',
                        type: 1,
                        skin: 'layui-layer-demo', //样式类名
                        area: ['650px', '300px'],
                        closeBtn: 1, //不显示关闭按钮
                        anim: 2,
                        shadeClose: true, //开启遮罩关闭
                        content: contentStr,
                        success: function(layero, index){
                            //  form.render();
                            layui.use(['laypage', 'layer','laydate','jquery','form'],function() {
                                var laydate = layui.laydate;
                                var laypage = layui.laypage;
                                var form = layui.form;
                                var $ = layui.jquery;
                                //常规用法
                                laydate.render({
                                    elem: '#endDate',
                                    format: 'dd/MM/yyyy'
                                });
                                form.render();
                            });
                        }

                    });


                }
            });

        });

    })



    //打开课表
    function openCourseSchedule(scheduleId,className) {
      location.href = "${pageContext.request.contextPath}/rest/course_schedule/course_schedule_detail?courseScheduleId="+scheduleId+"&className="+className;
    }

</script>
</body>
</html>
