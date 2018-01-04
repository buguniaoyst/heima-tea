<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>新增助教日志</title>
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
<div class="layui-form-pane"  style="margin-top: 15px;margin-left: 5px;">
    <form class="layui-form layui-form-pane" method="post" action="${pageContext.request.contextPath}/rest/diary/addTeaDiary">

       <div class="layui-form-item">
           <span style="font-size: large">日期：</span>
           <span style="font-size: large" id="dateSpan"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <span style="font-size: large" id="weekSpan"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <span style="font-size: small" >请记录下您今日的辅导日志...</span>
       </div>


        <div class="layui-form-item">
            <label class="layui-form-label">课程模块</label>
            <div class="layui-input-inline">
                <select name="classType" lay-filter = "getClassType" >
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
            <div class="layui-input-inline">
               <input class="layui-input"  placeholder="该模块的第几天课程" type="number" name="courseNo">
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label" style="font-size: large">难点知识</label>
            <div class="layui-input-block">
                <textarea name="courseDifficultPoint" placeholder="今日课程中的难点"  class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label" style="font-size: large">难理解的知识</label>
            <div class="layui-input-block">
                <textarea name="indigestibilityPoint" placeholder="难理解的知识点" class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label" style="font-size: large">学生问的最多的问题</label>
            <div class="layui-input-block">
                <textarea name="problemPoints" placeholder="学生问的比较多的问题" class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label" style="font-size: large">没解决的问题</label>
            <div class="layui-input-block">
                <textarea name="unresolvedPoints" placeholder="没能解决的问题" class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label" style="font-size: large">做得好的地方</label>
            <div class="layui-input-block">
                <textarea name="goodPoints" placeholder="做得比较好的点" class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label" style="font-size: large">其他</label>
            <div class="layui-input-block">
                <textarea name="remark" placeholder="请输入其他想说的话" class="layui-textarea"></textarea>
            </div>
        </div>

        <div class="layui-form-item">
            <input type="submit" class="layui-btn" value="提交">
            <input type="reset" class="layui-btn" value="重置">
        </div>
    </form>

</div>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script src="${pageContext.request.contextPath}/lib/jquery-1.8.3.js"></script>
<script>
    layui.use(['laypage', 'layer','laydate','jquery','form'],function() {
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        var form = layui.form;
        var $ = layui.jquery;

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







    });

    $(function () {
        var date = new Date();
        $("#dateSpan").html(date.toLocaleDateString());
        var l = ["日","一","二","三","四","五","六"];
        var d = date.getDay();
        var weekDay = "星期" + l[d];
        $("#weekSpan").html(weekDay);



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


    })

</script>
</body>
</html>
