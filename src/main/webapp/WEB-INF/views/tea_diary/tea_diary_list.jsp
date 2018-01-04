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
<ul class="layui-timeline" id="diaruTimeLine">

</ul>
</body>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script src="/lib/jquery-1.8.3.js"></script>
<script>
    layui.use(['laypage', 'layer','laydate','jquery','form'],function() {
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        var form = layui.form;
        var $ = layui.jquery;
        var start = {
            max : '2099-06-16 23:59:59',
            istoday : false,
            choose : function(datas) {
                end.min = datas; //开始日选好后，重置结束日的最小日期
                end.start = datas //将结束日的初始值设定为开始日
            }
        };

        var end = {
            max : '2099-06-16 23:59:59',
            istoday : false,
            choose : function(datas) {
                start.max = datas; //结束日选好后，重置开始日的最大日期
            }
        };


        //页面初始化的时候加载分页数据
        $(function(){
            //alert("页面初始化了.......");
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/diary/queryDiaryList",
                //记得加双引号  T_T
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if(data){
                        var diaryList = $("#diaruTimeLine");
                        for(var i = 0;i<data.length;i++){
                            var localDate = formatDate(data[i].date);
                            var weekDay = getWeekDay(data[i].date);
                            diaryList.append($('<li class="layui-timeline-item">\n' +
                                '        <i class="layui-icon layui-timeline-axis">&#xe63f;</i>\n' +
                                '        <div class="layui-timeline-content layui-text">\n' +
                                '            <h3 class="layui-timeline-title">'+localDate+weekDay+'</h3>\n' +
                                '            <p>\n' + data[i].courseModule+"第"+data[i].courseNo+"天"+
                                '                \n' +
                                '                <br>课程难点：\n' +data[i].courseDifficultPoint+
                                '                <br>难理解的知识点：\n' +data[i].indigestibilityPoint+
                                '                <br>学生问的最多的问题：\n' +data[i].problemPoints+
                                '                <br>没能解决的问题：\n' +data[i].unresolvedPoints+
                                '                <br>做得好的地方：\n' +data[i].goodPoints+
                                '                <br><button class="layui-btn layui-btn-sm " onclick="editDiary('+data[i].id+')">修改日记</button>\n' +
                                '            </p>\n' +
                                '        </div>\n' +
                                '    </li>'))
                        }
                        diaryList.append($(' <li class="layui-timeline-item">\n' +
                            '    <i class="layui-icon layui-timeline-axis"></i>\n' +
                            '    <div class="layui-timeline-content layui-text">\n' +
                            '      <div class="layui-timeline-title">终点</div>\n' +
                            '    </div>\n' +
                            '  </li>'));
                    }
                },
                error: function (err) {
                    alert(err + "err");
                }
            });
        })

    });
    function editDiary(diaryId) {
        $.ajax({
            type: "GET",
            url: "${pageContext.request.contextPath}/rest/diary/getDiaryById",
            data: {id:diaryId},
            dataType: "json",
            success: function(data) {
                console.log(data);
                var strDate = formatDate(data.date);
                var contentStr = '<form method="post" action="${pageContext.request.contextPath}/rest/diary/editDiaryById">\n' +
                    '<ul class="layui-timeline">\n <input type="hidden" name="id" value='+data.id+'>' +
                    '    <li class="layui-timeline-item">\n' +
                    '        <i class="layui-icon layui-timeline-axis"></i>\n' +
                    '        <div class="layui-timeline-content layui-text">\n' +
                    '            <h3 class="layui-timeline-title">' + strDate + '</h3>\n' +
                    '            <p>\n' +
                    '                作者：\n' + data.creater +
                    '                <br>所属课程模块：\n' + data.courseModule +
                    '                <br>课程难点：\n' + data.courseDifficultPoint +
                    '                <br>难理解的知识点：\n' + data.indigestibilityPoint +
                    '                <br>难理解的知识点：<textarea name="indigestibilityPoint" style="width: 400px" class="layui-textarea" >' + data.indigestibilityPoint + '</textarea>\n' +
                    '                <br>学生问的最多的问题：<textarea name="problemPoints" style="width: 400px" class="layui-textarea" >' + data.problemPoints + '</textarea>\n' +
                    '                <br>没能解决的问题：<textarea name="unresolvedPoints" style="width: 400px" class="layui-textarea" >' + data.unresolvedPoints + '</textarea>\n' +
                    '                <br>做得好的地方：<textarea name="goodPoints" style="width: 400px" class="layui-textarea" >' + data.goodPoints + '</textarea>\n' +
                    '                <br>其他：<textarea name="remark" style="width: 400px" class="layui-textarea" >' + data.remark + '</textarea>\n' +
                    '            </p>\n' +
                    '        </div>\n' +
                    '    </li>\n' +
                    '    <li class="layui-timeline-item">\n' +
                    '        <i class="layui-icon layui-timeline-axis"></i>\n' +
                    '        <div class="layui-timeline-content layui-text">\n' +
                    '            <div class="layui-timeline-title"><button class="layui-btn">修改</button></div>\n' +
                    '        </div>\n' +
                    '    </li>\n' +
                    '</ul></form>';
                layer.open({
                    title:'日记信息',
                    type: 1,
                    skin: 'layui-layer-demo', //样式类名
                    area: ['750px', '750px'],
                    closeBtn: 1, //不显示关闭按钮
                    anim: 2,
                    shadeClose: true, //开启遮罩关闭
                    content: contentStr,
                    success: function(layero, index){
                        //form.render();
                    }

                });
            }
        })
    }

</script>
</body>
</html>
