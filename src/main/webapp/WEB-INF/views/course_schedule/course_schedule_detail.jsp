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
    <div class="layui-form-item">

        <div class="layui-input-inline">
            <button class="layui-btn" id="goBack" onclick="history.go(-1);">
                <i class="layui-icon">&#xe603;</i> 返回上一级
            </button>
        </div>
        <!--文件上传-->
        <form  id="jvForm" enctype="multipart/form-data" >
            <div class="layui-input-inline">
                <button class="layui-upload-button">
                    <input type="file" name="excelFile" onchange="importExcel()" />
                </button>
                <input type="hidden" id="baseId" name="baseId" value="${param.courseScheduleId}">
                <input type="hidden" id="className" name="className"  value="${param.className}">

            </div>
        </form>



    </div>
    <div class="layui-form" >
        <table class="layui-table" style="height: 58px;" lay-even="" lay-skin="row" id="personTable">
            <colgroup>
                <col width="60">
                <col width="200">
                <col width="200">
                <col width="200">
                <col width="350">
                <col width="400">
                <col width="200">
                <col width="200">
                <col width="200">
                <col width="200">
                <col width="200">
                <col width="200">
                <col width="200">
            </colgroup>
            <thead>
            <tr>
                <th align="center"style="padding: 0;text-align: center">序号</th>
                <th align="center">课程进度</th>
                <th align="center">日期</th>
                <th align="center">星期</th>
                <th align="center">班级</th>
                <th align="center">课程（内容空代表放假）</th>
                <th align="center">上课模式</th>
                <th align="center">是否大纲课程</th>
                <th align="center">上课教室</th>
                <th align="center">讲师姓名</th>
                <th align="center">助教姓名</th>
                <th align="center">备注</th>
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
<script src="${pageContext.request.contextPath }/lib/jquery.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/lib/jquery.ext.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/lib/jquery.form.js" type="text/javascript"></script>
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
                url: "${pageContext.request.contextPath}/rest/course_schedule_detail/getCourseScheduleDetailByBaseId?baseId=${param.courseScheduleId}",
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

                //课程天数  1-第一天
                var daySort = data[i].daySort;
                if(daySort){
                    daySort = '第' + daySort + '天';
                }else {
                    daySort = "";
                }

                //日期
                var classDate = formatDate(data[i].classDate);

                //星期
                var weekSort = data[i].weekSort;
                if(weekSort ==1){
                    weekSort = '星期一';
                }else if(weekSort == 2){
                    weekSort = '星期二';
                }else if(weekSort == 3){
                    weekSort = '星期三';
                }else if(weekSort == 4){
                    weekSort = '星期四';
                }else if(weekSort == 5){
                    weekSort = '星期五';
                }else if(weekSort == 6){
                    weekSort = '星期六';
                }else if(weekSort == 0){
                    weekSort = '星期日';
                }
                //课程
                var content = data[i].content?data[i].content:"";

                //上课模式 0-传统全天  1-AB上午  2-AB下午
                var classMode = data[i].classMode;
                if(classMode == 0) {
                    classMode = '传统全天';
                }else if(classMode == 1) {
                    classMode = "AB上午";
                }else if(classMode == 2) {
                    classMode = "AB下午";
                }else {
                    classMode = "";
                }
                //是否大纲课程 0-否  1-是
                var isOutline = data[i].isOutline;
                if(isOutline == 0) {
                    isOutline = '否';
                }else{
                    isOutline = '是';
                }
                //上课教室
                var classRoomName = data[i].classRoomName;
                if(!classRoomName) {
                    classRoomName = "";
                }
                //讲师姓名
                var teacherName = data[i].teacherName;
                if(!teacherName) {
                    teacherName = "";
                }
                //助教姓名
                var assistant = data[i].assistant;
                //备注
                var remark = data[i].remark;
                if(!remark) {
                    remark = "";
                }
                var className = data[i].className;

                var tr = $("<tr></tr>");
                var td1 = $("<td align='center'>"+i+"</td>")
                var td2 = $("<td align='center'>"+daySort+"</td>");
                var td3 = $("<td align='center'>"+classDate+"</td>");
                var td4 = $("<td align='center'>"+weekSort+"</td>");
                var td5 = $("<td align='center'>"+className+"</td>");
                var td6 = $("<td align='center'>"+content+"</td>");
                var td7 = $("<td align='center'>"+classMode+"</td>");
                var td8 = $("<td align='center'>"+isOutline+"</td>");
                var td9 = $("<td align='center'>"+classRoomName+"</td>");
                var td10 = $("<td align='center'>"+teacherName+"</td>");
                var td11 = $("<td align='center'>"+assistant+"</td>");
                var td12 = $("<td align='center' >"+remark+"</td>");
                var td13 = $("<td align='center' ><button   onclick="+'editCourseScheduleDetail('+data[i].id+')'+" class='layui-btn  layui-btn-radius' >修改</button></td>");
                td1.appendTo(tr);
                td2.appendTo(tr);
                td3.appendTo(tr);
                td4.appendTo(tr);
                td5.appendTo(tr);
                td6.appendTo(tr);
                td7.appendTo(tr);
                td8.appendTo(tr);
                td9.appendTo(tr);
                td10.appendTo(tr);
                td11.appendTo(tr);
                td12.appendTo(tr);
                td13.appendTo(tr);
                tr.appendTo(table);
            }
            return table;
        };


        $("#diaryQueryBtn").click(function () {
            //获取参数
            //课程模块
            var courseModuleId = $("#courseModuleId").val();
            //作者
            var createrId = $("#assistantId").val();
            //fromDate
            var fromDate = $("#fromDate").val();
            //endDate
            var endDate = $("#endDate").val();
            console.log("课程模块id：" + courseModuleId + ";作者id：" + createrId + ";fromDate:" + fromDate + ";endDate:" + endDate);
            //拼接条件查询
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/rest/diary/getDiaryListByExample",
                data: {courseModuleId:courseModuleId,createrId:createrId,fromDate:fromDate,endDate:endDate},
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



    });

    //编辑课程表
    function editCourseScheduleDetail(diaryId) {
        alert(diaryId);
        if(diaryId) {
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/diary/getDiaryById",
                data: {id:diaryId},
                dataType: "json",
                success: function(data){
                    console.log(data);
                    var strDate = formatDate(data.date);
                    var contentStr = '\n' +
                        '<ul class="layui-timeline">\n' +
                        '    <li class="layui-timeline-item">\n' +
                        '        <i class="layui-icon layui-timeline-axis"></i>\n' +
                        '        <div class="layui-timeline-content layui-text">\n' +
                        '            <h3 class="layui-timeline-title">'+strDate+'</h3>\n' +
                        '            <p>\n' +
                        '                作者：\n' +data.creater+
                        '                <br>所属课程模块：\n' +data.courseModule+
                        '                <br>课程难点：\n' +data.courseDifficultPoint+
                        '                <br>难理解的知识点：\n' +data.indigestibilityPoint+
                        '                <br>学生问的最多的问题：\n' +data.problemPoints+
                        '                <br>没能解决的问题：\n' +data.unresolvedPoints+
                        '                <br>做得好的地方：\n' +data.goodPoints+
                        '                <br>其他：\n' +data.remark+
                        '            </p>\n' +
                        '        </div>\n' +
                        '    </li>\n' +
                        '    <li class="layui-timeline-item">\n' +
                        '        <i class="layui-icon layui-timeline-axis"></i>\n' +
                        '        <div class="layui-timeline-content layui-text">\n' +
                        '            <div class="layui-timeline-title">结束</div>\n' +
                        '        </div>\n' +
                        '    </li>\n' +
                        '</ul>';
                    layer.open({
                        title:'日记信息',
                        type: 1,
                        skin: 'layui-layer-demo', //样式类名
                        area: ['650px', '350px'],
                        closeBtn: 1, //不显示关闭按钮
                        anim: 2,
                        shadeClose: true, //开启遮罩关闭
                        content: contentStr,
                        success: function(layero, index){
                            //form.render();
                        }

                    });

                }
            });
        }
    }

    function importExcel(){
        var options = {
            url : "${pageContext.request.contextPath}/rest/course_schedule_detail/importCourseSchedule",
            type : "post",
            dataType : "json",
            success : function(data) {
                console.log(data);
                location.href = "${pageContext.request.contextPath}/rest/course_schedule/course_schedule_detail?courseScheduleId=${param.courseScheduleId}";
            }
        }
        $("#jvForm").ajaxSubmit(options);
    }

</script>
</body>
</html>
