function WebStat(c_uid,c_sid,action){
    if (c_uid) {
        if (c_sid=="") {
            c_sid=0;
        }
    } else {
        c_uid=8000;
        c_sid=1001;

    }
   // var URL = "/Index/WebStat?c_uid="+c_uid+"&c_sid="+c_sid+"&action="+action;
  /*  var URL = "http://log.imswing.cn/admin/WebStat?c_uid="+c_uid+"&c_sid="+c_sid+"&action="+action;

    $.getJ(URL,function(data){
      //console.info(data)


    });*/
    var URL = "http://log.imswing.cn/admin/WebStat?cuid="+c_uid+"&csid="+c_sid+"&action="+action;
   /* $.getJSON(URL,
        function (data) {
           // alert(data);
            console.info(data);
        }
    );*/


    $.ajax({
        async:true,
        url: URL,
        type: "GET",
        dataType: 'jsonp',
        jsonp: 'jsoncallback',
        data: "",
        timeout: 5000
        /*success: function (r) {//客户端jquery预先定义好的callback函数,成功获取跨域服务器上的json数据后,会动态执行这个callback函数
           // console.info()
        }*/
});

}