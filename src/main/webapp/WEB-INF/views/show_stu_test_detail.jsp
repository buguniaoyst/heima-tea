<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>试卷管理列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css" media="all">
    <script src="${pageContext.request.contextPath}/lib/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/lay/modules/laypage.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/common.js"></script>
    <style type="text/css">

        .layui-layer-code .layui-layer-content{
            background-color: #282b2e;
        }
    </style>
</head>
<body>
<div style=" margin: 40px auto 6px 0px;" >
    <form class="layui-form layui-form-pane" action="" method="post">
        <div class="site-tips">
            试卷名：<span style="font-size: 20px" id="stuTestName" ></span>&nbsp;&nbsp;&nbsp;&nbsp;
            姓名：<span style="font-size: 20px" id="stuName" ></span>
        </div>

        <div id="itemArea" style="margin-left: 10px">

        </div>
        <div class="layui-form-item">
            <div class="layui-input-inline">
                <input type="button" id="submitTest" class="layui-btn " value="提交，批改下一份">

            </div>
            <div class="layui-input-inline">
            <button class="layui-btn "   type="reset" >重置</button>
            </div>



        </div>

        <%--<div class="layui-form-item">--%>
           <%----%>
        <%--</div>--%>
    </form>
</div>
<script src="${pageContext.request.contextPath}/json/tree.js"></script>
<link href="${pageContext.request.contextPath}/lib/highlight/styles/obsidian.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/lib/highlight/highlight.pack.js"></script>
<script >hljs.initHighlightingOnLoad();</script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['laypage', 'layer','laydate','jquery','form','tree'],function() {
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        var form = layui.form;
        var $ = layui.jquery;


        //页面初始化的时候加载分页数据
        $(function(){
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/test/piyueTest?classId=${param.classId}&testId=${param.testId}&stuId=${param.stuId}",
                //记得加双引号  T_T
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    $("#stuTestName").html(data.testSourceInfo.testName);
                    $("#stuTestName").attr("testId",data.testSourceInfo.id);
                    $("#stuName").html(data.student.studentName);
                    $("#stuName").attr("stuId",data.student.id);
                    $("#stuName").attr("classId",data.student.classId);
                    var answerInfos = data.answerInfoList;
                    if(answerInfos && answerInfos.length>0) {
                        var count = 1;
                        for(var i = 0;i<answerInfos.length;i++){
                            //根据itemId查询 item信息
                           var itemId =  answerInfos[i].itemId;
                            $.ajax({
                                type: "GET",
                                url: "${pageContext.request.contextPath}/rest/item/getItemInfoByItemId?itemId="+itemId,
                                //记得加双引号  T_T
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                async:false,
                                success: function (data) {
                                    //创建编程题
                                    if(data.itemType == '1') {
                                        createCodeItem(data,count,answerInfos[i]);
                                        count++;
                                    }
                                }
                            });
                        }
                    }

                },
                error: function (err) {
                    alert(err + "err");
                }
            });

        })

        //创建编程题
        function createCodeItem(items,count,answer) {
            console.log(items);
            var _div = $("<div class='itemAnswerArea'   id="+items.id+" >\n" +
                "            <div class=\"site-title\">\n" +
                "                <fieldset><legend><a >第"+count+"题("+items.itemScore+"分)</a></legend></fieldset>\n" +
                "            </div>\n" +
                "            <div class=\"site-item\">\n" +
                "               "+ items.itemContent+"\n" +
                "            </div>\n" +
                "            <div>\n" +
                "\n" +
                "                <div class=\"layui-form-item layui-form-text\">\n" +
                "                    <label class=\"layui-form-label\">请在写下你的做题思路（步骤）：</label>\n" +
                "                    <div class=\"layui-input-block\">\n" +
                "                        <textarea placeholder=\"请输入思路\" style='height: 300px' class=\"layui-textarea silu\">"+answer.silu+"</textarea>\n" +
                "                    </div>\n" +
                "                </div>\n" +
                "            </div>\n" +
                "            <div>\n" +
                "\n" +
                "                <div class=\"layui-form-item layui-form-text\">\n" +
                "                    <label class=\"layui-form-label\">请将你的答案粘贴到下边的文本域中：</label>\n" +
                "                    <div class=\"layui-input-block\">\n" +
                "                        <textarea placeholder=\"请输入答案\" style='height: 500px' class=\"layui-textarea answer\">"+answer.answer+"</textarea>\n" +
                "                    </div>\n" +
                "                </div>\n" +
                "            </div>\n" +
                "        </div>")
            var scoreSpan = $(" <div class=\"layui-form-item\">\n" +
                  "    <label class=\"layui-form-label\">综合评分：</label>\n" +
                "    <div class=\"layui-input-inline\">\n" +
                "      <input type=\"number\" name=\"itemScore\" lay-verify=\"required\" placeholder=\"请输入分值\" autocomplete=\"off\" class=\"layui-input\">\n" +
                "    </div>\n" +
                "<ul id="+'demo'+items.id+"></ul>\n" +
                "  </div>");
            var openZipDiv = $('<div><input type="button" value="打开附件" onclick="showZipTree(\''+answer.zipPath+'\','+items.id+')"  class="layui-btn layui-btn-warm"></div>' );
            if(answer.zipPath) {
                openZipDiv.appendTo(scoreSpan);
            }
            _div.appendTo($("#itemArea"));
            scoreSpan.appendTo(_div);
        }


        $(function () {
            $("#submitTest").click(function () {
                var submitTestFlag = true;
                //获取提交的答案信息
               // alert(123);
                var _divs=$(".itemAnswerArea");
                var scoreInfos = new Array();
                //封装答案信息
                var stuId =  $("#stuName").attr("stuId");
                if(_divs){
                    var totalScore=0;
                    for(var i = 0;i<_divs.length;i++) {
                        var itemId = $(_divs[i]).attr('id');
                        var itemScore = $(_divs.get(i)).find('input')[0].value;
                        if(!itemScore){
                            submitTestFlag = false;
                            layer.alert('有未批阅的题目，请检查！', {
                                skin: 'layui-layer-molv' //样式类名
                                ,closeBtn: 0
                            });
                            return;
                        }
                        var scoreInfo = {};
                        var testId = $("#stuTestName").attr("testId");
                        scoreInfo.stuId=stuId;
                        scoreInfo.itemId=itemId;
                        scoreInfo.itemScore=itemScore;
                        scoreInfo.testId = testId;
                        scoreInfos.push(scoreInfo);
                        totalScore+=new Number(itemScore);
                        console.log(scoreInfos);
                    }
                }

                //封装testRecord信息
                var testRescord = {};
                testRescord.userId = stuId;
                testRescord.testId = $("#stuTestName").attr("testId");
                testRescord.classId = $("#stuName").attr("classId");
                var classId = testRescord.classId;
                if(classId && classId.substring(classId.length-1,classId.length) == '0'){
                    testRescord.classType = 0;
                }else{
                    testRescord.classType = 1;
                }
                testRescord.testName =  $("#stuTestName").html();
                testRescord.score = totalScore;

                testRescord = JSON.stringify(testRescord);
                console.log(scoreInfos);
              //  itemAnswersInfo = JSON.serialize(itemAnswersInfo);
                scoreInfos = JSON.stringify(scoreInfos);
                if(submitTestFlag){
                    $.post("${pageContext.request.contextPath}/rest/score/submitScoreInfo",{scoreInfos:scoreInfos,testRecord:testRescord},function (result) {
                        if(result.result){
                            //alert("批改成功");
                            var testName = $("#stuTestName").html();
                            var testId = $("#stuTestName").attr("testId");
                            var classId =  $("#stuName").attr("classId");
                            location.href = "/rest/class_answer_detail?classId="+classId+"&testId="+testId+"&testName="+testName;
                        }

                    });
                }

            })
        })


    });

    var itemFlag = "";
    function showZipTree(zipPath,itemId) {
        if(itemId == itemFlag) {
            return;
        }
        $.post("${pageContext.request.contextPath}/rest/answer/getZipDirs",{zipPath:zipPath},function (data) {
            console.log(data);
            itemFlag = itemId;
            children = JSON.parse(data.nodes);
            layui.use(['tree','layer','form'],function () {
                var form = layui.form;
                layui.tree({
                    elem: '#demo'+itemId //传入元素选择器
                    ,skin: 'notepad'
                    ,encode:true
                    , nodes: children
                    ,click:function (node) {
                        console.log(node);
                        //判断 点击节点如果是文件就显示文件内容
                        if(node.children.length == 0 ){
                            $.post("${pageContext.request.contextPath}/rest/answer/getFileContent",{filePath:node.alias},function (data) {
                                if(data) {
                                    var _pre = '<pre  id="codeContent">\n' +
                                                '<code >' +data+
                                                '</code>'
                                                '</pre>';
                                    layer.open({
                                        title:'查看代码',
                                        type: 1,
                                        skin: 'layui-layer-code', //样式类名
                                        area: ['80%', '80%'],
                                        closeBtn: 1, //不显示关闭按钮
                                        anim: 2,
                                        shadeClose: true, //开启遮罩关闭
                                        content: _pre,
                                        success: function(layero, index){

                                            $('pre code').each(function(i, block) {
                                                hljs.highlightBlock(block);
                                            });
                                            form.render();
                                        }

                                    });

                                }
                            })
                        }


                    }
                });
            });
        });
    }

    /**
     * 下载附件
     */
    function downloadZipFile(filePath) {
        $.post("${pageContext.request.contextPath}/rest/answer/downloadZip",{filePath:filePath},function (data) {
            console.log(data);
        })
    }


</script>
</body>
</html>
