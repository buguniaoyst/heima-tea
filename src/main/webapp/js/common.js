/** common.js By Beginner Emain:zheng_jinfan@126.com HomePage:http://www.zhengjinfan.cn */
layui.define(['layer'], function(exports) {
	"use strict";

	var $ = layui.jquery,
		layer = layui.layer;

	var common = {
		/**
		 * 抛出一个异常错误信息
		 * @param {String} msg
		 */
		throwError: function(msg) {
			throw new Error(msg);
			return;
		},
		/**
		 * 弹出一个错误提示
		 * @param {String} msg
		 */
		msgError: function(msg) {
			layer.msg(msg, {
				icon: 5
			});
			return;
		}
	};

	exports('common', common);
});

/**
 * 格式化日期
 * @param timeStamp
 * @returns {string}
 */
function  formatDate(timeStamp) {
    if(timeStamp){
        //return new Date(timeStamp).toLocaleDateString();
        var date = new Date(timeStamp);
        Y = date.getFullYear() + '-';
        M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        D = date.getDate() + ' ';
        h = date.getHours() + ':';
        m = date.getMinutes() + ':';
        s = date.getSeconds();
       // console.log(Y+M+D+h+m+s);
        return Y+M+D;
    }
}


function getWeekDay(timeStamp) {
    var date = new Date(timeStamp);
    var l = ["日","一","二","三","四","五","六"];
    var d = date.getDay();
    var weekDay = "星期" + l[d];
    return weekDay;
}