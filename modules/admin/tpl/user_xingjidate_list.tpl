{include 'header.tpl'}

<style>
    .table th { text-align:center; }
    .t_c td { text-align:center; }
    #show_table td{ line-height: 10px;}
    #show_table ul {
        margin:0;
        padding:0;
        list-style-type:none;
        font-size:0;
    }
    #show_table LI {
        FLOAT:left;
        PADDING-BOTTOM:0px;
        MARGIN:0px;
        PADDING-LEFT:0px;
        PADDING-RIGHT:0px;
        FONT-SIZE:12px;
        PADDING-TOP:0px;
        margin-bottom: 10px;
    }
.shenhe {
    float: right;
    border: 0;
   margin-top: 5px;
    margin-right: 10px;
    color: #428bca;
    background-color: #fff;
    border: 1px solid #ddd;
    padding: 6px 7px;
    margin-left: -1px;
    line-height: 1.42857143;
}
    .shenhe:hover {
        color: #2a6496;
        background-color: #eee;
        border-color: #ddd;
    }
    .shenhe_dian {
        float: right;
        border: 0;
        margin-top: 5px;
        padding: 6px 7px;
        margin-left: -1px;
        line-height: 1.42857143;
        color: #fff;
        background-color: #428bca;
        border: 1px solid #ddd;
    }
    input:focus {
        outline:none;
    }
    .rot90{ -moz-transform:rotate(90deg); -webkit-transform:rotate(90deg); transform:rotate(90deg); filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=1);}
    .rot180{ -moz-transform:rotate(180deg); -webkit-transform:rotate(180deg); transform:rotate(180deg); filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=1);}
    .rot270{ -moz-transform:rotate(270deg); -webkit-transform:rotate(270deg); transform:rotate(270deg); filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=1);}
    html { overflow-x: auto; overflow-y: auto; border:0;}
</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>


<table class="table table-hover table-report" style="margin-bottom: 5px; width: 1200px; " id="report_table2">
    <tr> <th style="font-size: 14px;height: 50px; " colspan="3" >秋千优秀用户星级统计</th></tr>
    <tr>
        <th style="width: 110px;" nowrap="value">日期</th>
        <th style="width: 120px;" nowrap="value">前台登陆数<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;">一星用户数<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;">二星用户数<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;">三星用户数<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;">三星降二星数<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;">二星降一星数<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;">星级用户发消息总人数<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;">星级用户发消息总量<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;">星级用户关注总人数<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;">星级用户玩游戏总人数<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>

    </tr>
    <tr>
        <th>{$user_star_date['date']}</th>
        <th>{$user_star_date['login_man']+$user_star_date['login_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$user_star_date['login_man']}</span>,<span style=" color: #FF0000;">{$user_star_date['login_woman']}</span>)</span></th>
        <th>{$user_star_date['level1_man']+$user_star_date['level1_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$user_star_date['level1_man']}</span>,<span style=" color: #FF0000;">{$user_star_date['level1_woman']}</span>)</span></th>
        <th>{$user_star_date['level2_man']+$user_star_date['level2_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$user_star_date['level2_man']}</span>,<span style=" color: #FF0000;">{$user_star_date['level2_woman']}</span>)</span></th>
        <th>{$user_star_date['level3_man']+$user_star_date['level3_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$user_star_date['level3_man']}</span>,<span style=" color: #FF0000;">{$user_star_date['level3_woman']}</span>)</span></th>
        <th>{$user_star_date['level3_2_man']+$user_star_date['level3_2_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$user_star_date['level3_2_man']}</span>,<span style=" color: #FF0000;">{$user_star_date['level3_2_woman']}</span>)</span></th>
        <th>{$user_star_date['level2_1_man']+$user_star_date['level2_1_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$user_star_date['level2_1_man']}</span>,<span style=" color: #FF0000;">{$user_star_date['level2_1_woman']}</span>)</span></th>
        <th>{$user_star_date['star_message_man']+$user_star_date['star_message_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$user_star_date['star_message_man']}</span>,<span style=" color: #FF0000;">{$user_star_date['star_message_woman']}</span>)</span></th>
        <th>{$user_star_date['star_messages_man']+$user_star_date['star_messages_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$user_star_date['star_messages_man']}</span>,<span style=" color: #FF0000;">{$user_star_date['star_messages_woman']}</span>)</span></th>
        <th>{$user_star_date['star_follow_man']+$user_star_date['star_follow_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$user_star_date['star_follow_man']}</span>,<span style=" color: #FF0000;">{$user_star_date['star_follow_woman']}</span>)</span></th>
        <th>{$user_star_date['star_game_man']+$user_star_date['star_game_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$user_star_date['star_game_man']}</span>,<span style=" color: #FF0000;">{$user_star_date['star_game_woman']}</span>)</span></th>

    </tr>
    {foreach from=$user_star_date1 item=item name=foo}
                          <tr>
                              <th>{$item['date']}</th>
                              <th>{$item['login_man']+$item['login_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$item['login_man']}</span>,<span style=" color: #FF0000;">{$item['login_woman']}</span>)</span></th>
                              <th>{$item['level1_man']+$item['level1_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$item['level1_man']}</span>,<span style=" color: #FF0000;">{$item['level1_woman']}</span>)</span></th>
                              <th>{$item['level2_man']+$item['level2_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$item['level2_man']}</span>,<span style=" color: #FF0000;">{$item['level2_woman']}</span>)</span></th>
                              <th>{$item['level3_man']+$item['level3_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$item['level3_man']}</span>,<span style=" color: #FF0000;">{$item['level3_woman']}</span>)</span></th>
                              <th>{$item['level3_2_man']+$item['level3_2_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$item['level3_2_man']}</span>,<span style=" color: #FF0000;">{$item['level3_2_woman']}</span>)</span></th>
                              <th>{$item['level2_1_man']+$item['level2_1_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$item['level2_1_man']}</span>,<span style=" color: #FF0000;">{$item['level2_1_woman']}</span>)</span></th>
                              <th>{$item['star_message_man']+$item['star_message_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$item['star_message_man']}</span>,<span style=" color: #FF0000;">{$item['star_message_woman']}</span>)</span></th>
                              <th>{$item['star_messages_man']+$item['star_messages_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$item['star_messages_man']}</span>,<span style=" color: #FF0000;">{$item['star_messages_woman']}</span>)</span></th>
                              <th>{$item['star_follow_man']+$item['star_follow_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$item['star_follow_man']}</span>,<span style=" color: #FF0000;">{$item['star_follow_woman']}</span>)</span></th>
                              <th>{$item['star_game_man']+$item['star_game_woman']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$item['star_game_man']}</span>,<span style=" color: #FF0000;">{$item['star_game_woman']}</span>)</span></th>

                          </tr>

                     {/foreach}

</table>


{include 'footer.tpl'}
