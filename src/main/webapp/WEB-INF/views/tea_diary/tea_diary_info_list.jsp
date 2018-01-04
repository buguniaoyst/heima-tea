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
        <label class="layui-form-label">课程模块</label>
        <div class="layui-input-inline">
            <select name="classType" lay-filter = "getClassType"  >
                <option value="">班级类型</option>
                <option value="0" selected="">基础班</option>
                <option value="1">就业班</option>
            </select>
        </div>
        <div class="layui-input-inline">
            <select name="courseModuleId" lay-filter = "getModuleName" id="courseModuleId">
                <option class="courcesModule" value="">请选课程模块</option>
            </select>
            <input type="hidden" name="courseModule" id="courseModule">
        </div>
        <label class="layui-form-label">助教</label>
        <div class="layui-input-inline">
            <select name="createrId"  id="assistantId" >

            </select>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">日期（From）</label>
            <div class="layui-input-inline">
                <input type="text" id="fromDate" name="startDate" class="layui-input" id="test1" >
            </div>
            <label class="layui-form-label">至（To）</label>
            <div class="layui-input-inline">
                <input type="text" id="endDate" name="endDate" class="layui-input" id="test2" >
            </div>
        </div>
        <div class="layui-inline">
            <button class="layui-btn layui-btn-radius" id="diaryQueryBtn">查询</button>
            <button class="layui-btn layui-btn-radius" id="diaryQueryExport">导出数据</button>
        </div>
    </div>
    <div class="layui-form" >
        <table class="layui-table" style="height: 58px;" lay-even="" lay-skin="row" id="personTable">
            <colgroup>
                <col width="60">
                <col width="200">
                <col width="400">
                <col width="400">
                <col width="400">
            </colgroup>
            <thead>
            <tr>
                <th align="center"style="padding: 0;text-align: center">序号</th>
                <th align="center">作者</th>
                <th align="center">课程模块</th>
                <th align="center">创建时间</th>
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
        //常规用法
        laydate.render({
            elem: '#fromDate'
        });
        laydate.render({
            elem: '#endDate'
        });



        //监听班级类型  根据不同的班级类型 加载不同的课程模块
        form.on('select(getClassType)', function(data){
            console.log(data.elem); //得到select原始DOM对象
            console.log(data.value); //得到被选中的值
            console.log(data.othis); //得到美化后的DOM对象
            var classType = data.value;
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/course/getCourseModuleByClassType",
                data: {classType:classType},
                dataType: "json",
                success: function(result){
                    var courceModuleOpt = "";
                    $.each(result, function(i,item){
                        courceModuleOpt += "<option value=\"" + item.id + "\" >" + item.moduleName + "</option>";
                    });
                    $("#courseModuleId").html('<option value=""></option>' + courceModuleOpt);
                    form.render(); //这个很重要
                    //console.log(result);
                }
            });
        });//监听班级类型  根据不同的班级类型 加载不同的课程模块
        form.on('select(getModuleName)', function(data){
            console.log(data.elem); //得到select原始DOM对象
            console.log(data.value); //得到被选中的值
            console.log(data.othis); //得到美化后的DOM对象
            $("#courseModule").val(data.elem.selectedOptions[0].innerText);

        });



        //页面初始化的时候加载分页数据
        $(function(){
            //alert("页面初始化了.......");

            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/diary/queryTeaDiaryByNow",
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
                var userName = data[i].creater;//作者
                var courseModule = data[i].courseModule;//课程模块
                var createDate = formatDate(data[i].date);

                var tr = $("<tr></tr>");
                var td1 = $("<td align='center'>"+i+"</td>")
                var td2 = $("<td align='center'>"+userName+"</td>");
                var td3 = $("<td align='center'>"+courseModule+"</td>");
                var td4 = $("<td align='center'>"+createDate+"</td>");
                var td5 = $("<td align='center' ><button   onclick="+'openDiary('+data[i].id+')'+" class='layui-btn  layui-btn-radius' >打开日记</button></td>");
                td1.appendTo(tr);
                td2.appendTo(tr);
                td3.appendTo(tr);
                td4.appendTo(tr);
                td5.appendTo(tr);
                tr.appendTo(table);
            }
            return table;
        };

        //初始化课程模块信息
        $.ajax({
            type: "GET",
            url: "${pageContext.request.contextPath}/rest/course/getCourseModuleByClassType",
            data: {classType:0},
            dataType: "json",
            success: function(result){
                var courceModuleOpt = "";
                $.each(result, function(i,item){
                    courceModuleOpt += "<option value=\"" + item.id + "\" >" + item.moduleName + "</option>";
                });
                $("#courseModuleId").html('<option value=""></option>' + courceModuleOpt);
               layui.use(['form'],function() {
                    var form = layui.form;
                    form.render();
                });
            }
        });

        //初始化助教信息
        $.ajax({
            type: "GET",
            url: "${pageContext.request.contextPath}/rest/user/getUserListByUserType?userType=1",
            data: {classType:0},
            dataType: "json",
            success: function(result){
                var courceModuleOpt = "";
                $.each(result, function(i,item){
                    courceModuleOpt += "<option value=\"" + item.id + "\" >" + item.userName + "</option>";
                });
                $("#assistantId").html('<option value=""></option>' + courceModuleOpt);
                layui.use(['form'],function() {
                    var form = layui.form;
                    form.render();
                });
            }
        });



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

    //打开日记
    function openDiary(diaryId) {
       // alert(diaryId);
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

</script>
</body>
</html>
