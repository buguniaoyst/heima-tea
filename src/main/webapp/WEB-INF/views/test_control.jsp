<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>考试设置</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/lib/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" ></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wenjuan.css" >
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/lay/modules/form.js"></script>
</head>
<body >
    <div class="container" >
        <form class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/rest/test/addTest">

            <div class="layui-form-item">
                    <label class="layui-form-label">班级</label>
                    <div class="layui-input-block">
                        <select  name="classId" id="selectedClass" required lay-verify="required">

                        </select>
                    </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">选择试卷</label>
                <div class="layui-input-block" >
                    <select name="testType" id="testType" lay-verify="required" >
                        <option value=""></option>
                        <option value="0">基础班-JavaEE基础阶段开班考试</option>
                        <option value="1">就业班-JavaEE就业阶段开班考试</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">备注</label>
                <div class="layui-input-block">
                    <textarea name="desc" id="testDesc" placeholder="请输入内容" class="layui-textarea"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <input type="button" class="layui-btn" id="createTest" value="立即组卷">
                    <button type="reset" class="layui-btn layui-btn-primary">重新组卷</button>
                </div>
            </div>
        </form>
    </div>
</body>
<script src="${pageContext.request.contextPath}/lib/jquery-1.8.3.js"></script>
<script>
    //Demo
    layui.use(['form','jquery','layer'], function() {
        var form = layui.form,
            $ = layui.jquery,
            layer = layui.layer;
    });

    $(function () {
       //加载班级列表
        $.post("${pageContext.request.contextPath}/rest/class/classList",function (data) {
            layui.use(['form'],function () {
                var _selectClass = $("#selectedClass");
                if(data && data.results) {
                    var classes = data.results;
                    for(var i = 0;i<classes.length;i++) {
                        var _classOpt =  $("<option classType="+classes[i].classType+" value="+classes[i].id+">"+classes[i].className+"</option>");
                        _classOpt.appendTo(_selectClass);
                    }

                }
                var form = layui.form;
                form.render();

            })



        })



    });



    $("#createTest").click(function(){
        //获取班级信息
        var selectedClass = $("#selectedClass");
        var classType = selectedClass[0].selectedOptions[0].getAttribute('classType');
        var classId = selectedClass[0].selectedOptions[0].value;
        var className = selectedClass[0].selectedOptions[0].innerText;
        //获取
        var testType = $("#testType").val();
        if(classType != testType) {
            layer.alert("班级类型和试卷不匹配");
            return;
        }

        //为开班考试组织试卷
        //classType == 0   testId == 1     为基础班开班考试
        //classType == 1   testId == 2     为基础班开班考试
        $.post("${pageContext.request.contextPath}/rest/test/createFirstTest",{classId:classId,classType:classType,className:className},function (result) {

            if(result) {
                layer.alert("组卷成功，可以开始考试了");
            }else{
                layer.alert("组卷失败，请联系管理员");

            }



        })


    });
</script>
</html>
