<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>助教考试汇报</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css" media="all">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/lay/modules/laypage.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
<%--列表面板--%>
<div class="layui-form layui-form-pane" style="margin-left: 5px">
    <!-- 列表操作按钮组 -->
    <div class="layui-form-item" style="margin-top: 5px;margin-bottom: -5px;">
        <div class="layui-inline">
            <button class="layui-btn layui-btn-radius" onclick="addWeeklyReport();">
                <i class="layui-icon">&#xe608;</i>新增考试汇报
            </button>
        </div>
        <div class="layui-inline" style="margin-left: 500px">
            <label class="layui-form-label">日期（From）</label>
            <div class="layui-input-inline">
                <input type="text" id="fromDate" name="startDate" class="layui-input" id="test1">
            </div>
            <label class="layui-form-label">至（To）</label>
            <div class="layui-input-inline">
                <input type="text" id="endDate" name="endDate" class="layui-input" id="test2">
            </div>
        </div>
        <div class="layui-inline">
            <button class="layui-btn layui-btn-radius" id="diaryQueryBtn">查询</button>
            <button class="layui-btn layui-btn-radius" id="diaryQueryExport">导出数据</button>
        </div>
    </div>
    <div>
        <table class="layui-table" lay-even="" lay-skin="row">
            <colgroup>
                <col width="50">
                <col width="150">
                <col width="150">
                <col width="400">
                <col width="300">
                <col width="200">
                <col width="200">
                <col width="200">
                <col width="200">
                <col>
            </colgroup>
            <thead>
            <tr>
                <th style="text-align: center">序号</th>
                <th style="text-align: center">创建人</th>
                <th style="text-align: center">创建日期</th>
                <th style="text-align: center">班级</th>
                <th style="text-align: center">阶段考试</th>
                <th style="text-align: center">试卷类型</th>
                <th style="text-align: center">平均分</th>
                <th style="text-align: center">末位平均分</th>
                <th style="text-align: center">备注</th>
                <th style="text-align: center">操作</th>
            </tr>
            </thead>
            <tbody id="tbody">

            </tbody>
        </table>
    </div>
    <div id="demo5" align="center"></div>
</div>
</body>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script src="/lib/jquery-1.8.3.js"></script>
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script>
    layui.use(['laypage', 'layer', 'laydate', 'jquery', 'form'], function () {
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        var form = layui.form;
        var $ = layui.jquery;
        //初始化日期控件
        laydate.render({
            elem: '#fromDate'
        });
        laydate.render({
            elem: '#endDate'
        });


        $(function () {
            //初始化助教周报列表
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/test_result_report/list",
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
                            console.log(thisDate(obj.curr));
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
        var pageData;
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
                var tr = $("<tr></tr>");
                var testType = data[i].testType;
                if(testType == '0'){
                    testType = '阶段考试';
                }else {
                    testType = '课后测试';
                }

                var td1 = $("<td align='center'>" + i + "</td>")
                var td2 = $("<td align='center'>" + data[i].creater + "</td>");
                var td3 = $("<td align='center'>" + formatDate(data[i].createDate) + "</td>");
                var td4 = $("<td align='center'>" + data[i].className + "</td>");
                var td5 = $("<td align='center'>" + data[i].testName + "</td>");
                var td6 = $("<td align='center'>" + testType + "</td>");
                var td7 = $("<td align='center'>" + data[i].avgScore + "</td>");
                var td8 = $("<td align='center'>" + data[i].moweiAvgScore + "</td>");
                var td9 = $("<td align='center'>" + data[i].remark + "</td>");
                var td10 = $("<td align='center' ><button  class='layui-btn  layui-btn-radius' onclick='getWeeklyReportDetail(" + data[i].id + ")' >查看详情</button></td>");
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
                tr.appendTo(table);
            }
            return table;
        };

    });

    function getWeeklyReportDetail(detailId) {
        $.post("${pageContext.request.contextPath}/rest/tea_report/getTeaReportDetailById",{id:detailId},function (data) {
            if(data) {
                console.log(data);
                layui.use(['layer','form'],function () {
                    var form = layui.form;
                    var contentStr = ' <div>\n' +
                        '        <blockquote class="layui-elem-quote layui-quote-nm">'+data.theme+"-"+formatDate(data.createDate)+'</blockquote>\n' +
                        '        <fieldset class="layui-elem-field layui-field-title">\n' +
                        '            <legend>概述</legend>\n' +
                        '            <div class="layui-field-box">\n' +data.contentSummary+
                        '                内容区域\n' +
                        '            </div>\n' +
                        '        </fieldset>\n' +
                        '        <hr class="layui-bg-orange"> \n' +
                        '        <fieldset class="layui-elem-field layui-field-title">\n' +
                        '            <legend>详细内容</legend>\n' +
                        '            <div class="layui-field-box">\n' +
                        '                \n' +data.contentDetail+
                        '            </div>\n' +
                        '        </fieldset>\n' +
                        '        <hr class="layui-bg-orange"> \n' +
                        '        <fieldset class="layui-elem-field layui-field-title">\n' +
                        '            <legend>结论</legend>\n' +
                        '            <div class="layui-field-box">\n' +
                        '                \n' +data.result+
                        '            </div>\n' +
                        '        </fieldset>\n' +
                        '        <hr class="layui-bg-orange">\n' +
                        '    </div>';

                    layer.open({
                        title:'助教周报',
                        type: 1,
                        skin: 'layui-layer-demo', //样式类名
                        area: ['750px', 'auto'],
                        closeBtn: 1, //不显示关闭按钮
                        anim: 2,
                        shadeClose: true, //开启遮罩关闭
                        content: contentStr,
                        success: function(layero, index){

                        }

                    });
                });
            }
        })
    }


    /**
     * 创建周报
     */
    function addWeeklyReport() {
        var contentStr = '创建周报';
        layer.open({
            title:'助教周报',
            type: 1,
            skin: 'layui-layer-demo', //样式类名
            area: ['750px', 'auto'],
            closeBtn: 1, //不显示关闭按钮
            anim: 2,
            shadeClose: true, //开启遮罩关闭
            content: contentStr,
            success: function(layero, index){

            }

        });
    }






</script>
</body>
</html>
