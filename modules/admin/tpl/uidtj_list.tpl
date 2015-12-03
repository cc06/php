{include "header.tpl"}
<link rel="stylesheet" type="text/css" href="/css/jquery.datetimepicker.css"/ >
<script src="/js/jquery.datetimepicker.js"></script>
<style>
    .table-report th,
    .table-report td {
        text-align: center;
    }
    #report_table1 th, #report_table1 td {
        padding-right: 0px;
    }
    #report_table2 th, #report_table2 td {
        padding-right: 0px;
        padding-bottom: 5px;
        padding-top: 5px;
    }

    html { overflow-x: auto; overflow-y: auto; border:0;}
</style>

<form role="form" class="form-inline" action="/admin/UidTj/list" method="get">
    <label>运营账号统计数据：</label>
    <label for="date">时间</label>
    <input style="border: 1px solid"  id="datetimepicker" name="stats_date" value="{$stats_date}"/>
    <script>
        $(function () {

            {literal}
            $('#datetimepicker').datetimepicker({lang:'ch',timepicker:false,
                format:'Y-m-d'
            });
            {/literal}
        });
    </script>
    <button class="btn btn-primary" type="submit">查找</button>
</form>
<form role="form" class="form-inline" action="/admin/UidTj/list?stats_date={$stats_date}" method="post">
<table class="table table-hover table-report" style="width:100%;margin-bottom: 5px" id="report_table2">
    <thead>
    <tr>
        <th style="width: 295px;text-align: right; ">运营ID</th>
        <th style="width: 95px;" >25</th>
        <th style="width:95px;" >26</th>
        <th style="width:95px;"  >27</th>
        <th style="width:95px;"  >28</th>
        <th style="width:95px;"  >30</th>
        <th style="width:95px;"  >31</th>
        <th style="width:95px;"  >32</th>
        <th style="width:95px;"  >总和</th>
    </tr>
    <tr>
        <th style="text-align: right; ">男用户数</th>
        <th >{$tj25->mencount}</th>
        <th >{$tj26->mencount}</th>
        <th >{$tj27->mencount}</th>
        <th >{$tj28->mencount}</th>
        <th >{$tj30->mencount}</th>
        <th >{$tj31->mencount}</th>
        <th >{$tj32->mencount}</th>
        <th >{$tj25->mencount+$tj26->mencount+$tj27->mencount+$tj28->mencount+$tj30->mencount+$tj31->mencount+$tj32->mencount}</th>
     </tr>
    <tr>
        <th style="text-align: right; ">女用户数</th>
        <th >{$tj25->womencount}</th>
        <th >{$tj26->womencount}</th>
        <th >{$tj27->womencount}</th>
        <th >{$tj28->womencount}</th>
        <th >{$tj30->womencount}</th>
        <th >{$tj31->womencount}</th>
        <th >{$tj32->womencount}</th>
        <th >{$tj25->womencount+$tj26->womencount+$tj27->womencount+$tj28->womencount+$tj30->womencount+$tj31->womencount+$tj32->womencount}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">与多少人聊天</th>
        <th >{$tj25->msguser}</th>
        <th >{$tj26->msguser}</th>
        <th >{$tj27->msguser}</th>
        <th >{$tj28->msguser}</th>
        <th >{$tj30->msguser}</th>
        <th >{$tj31->msguser}</th>
        <th >{$tj32->msguser}</th>
        <th >{$tj25->msguser+$tj26->msguser+$tj27->msguser+$tj28->msguser+$tj30->msguser+$tj31->msguser+$tj32->msguser}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">发了多少消息</th>
        <th >{$tj25->msgcount}</th>
        <th >{$tj26->msgcount}</th>
        <th >{$tj27->msgcount}</th>
        <th >{$tj28->msgcount}</th>
        <th >{$tj30->msgcount}</th>
        <th >{$tj31->msgcount}</th>
        <th >{$tj32->msgcount}</th>
        <th >{$tj25->msgcount+$tj26->msgcount+$tj27->msgcount+$tj28->msgcount+$tj30->msgcount+$tj31->msgcount+$tj32->msgcount}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">与多少人手动聊天</th>
        <th >{$tj25->msguser2}</th>
        <th >{$tj26->msguser2}</th>
        <th >{$tj27->msguser2}</th>
        <th >{$tj28->msguser2}</th>
        <th >{$tj30->msguser2}</th>
        <th >{$tj31->msguser2}</th>
        <th >{$tj32->msguser2}</th>
        <th >{$tj25->msguser2+$tj26->msguser2+$tj27->msguser2+$tj28->msguser2+$tj30->msguser2+$tj31->msguser2+$tj32->msguser2}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">发了多少手动消息</th>
        <th >{$tj25->msgcount2}</th>
        <th >{$tj26->msgcount2}</th>
        <th >{$tj27->msgcount2}</th>
        <th >{$tj28->msgcount2}</th>
        <th >{$tj30->msgcount2}</th>
        <th >{$tj31->msgcount2}</th>
        <th >{$tj32->msgcount2}</th>
        <th >{$tj25->msgcount2+$tj26->msgcount2+$tj27->msgcount2+$tj28->msgcount2+$tj30->msgcount2+$tj31->msgcount2+$tj32->msgcount2}</th>
     </tr>
    <tr>
        <th style="text-align: right; ">多少女性用户登陆消息</th>
        <th >{$tj25->nvlogin}</th>
        <th >{$tj26->nvlogin}</th>
        <th >{$tj27->nvlogin}</th>
        <th >{$tj28->nvlogin}</th>
        <th >{$tj30->nvlogin}</th>
        <th >{$tj31->nvlogin}</th>
        <th >{$tj32->nvlogin}</th>
        <th >{$tj25->nvlogin+$tj26->nvlogin+$tj27->nvlogin+$tj28->nvlogin+$tj30->nvlogin+$tj31->nvlogin+$tj32->nvlogin}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">女性用户登陆,回复了多少用户</th>
        <th >{$tj25->nvuser}</th>
        <th >{$tj26->nvuser}</th>
        <th >{$tj27->nvuser}</th>
        <th >{$tj28->nvuser}</th>
        <th >{$tj30->nvuser}</th>
        <th >{$tj31->nvuser}</th>
        <th >{$tj32->nvuser}</th>
        <th >{$tj25->nvuser+$tj26->nvuser+$tj27->nvuser+$tj28->nvuser+$tj30->nvuser+$tj31->nvuser+$tj32->nvuser}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">女性用户登陆,回复了多少消息</th>
        <th >{$tj25->nvmsg}</th>
        <th >{$tj26->nvmsg}</th>
        <th >{$tj27->nvmsg}</th>
        <th >{$tj28->nvmsg}</th>
        <th >{$tj30->nvmsg}</th>
        <th >{$tj31->nvmsg}</th>
        <th >{$tj32->nvmsg}</th>
        <th >{$tj25->nvmsg+$tj26->nvmsg+$tj27->nvmsg+$tj28->nvmsg+$tj30->nvmsg+$tj31->nvmsg+$tj32->nvmsg}</th>
     </tr>
    <tr>
        <th style="text-align: right; ">女性用户登陆,多少女性用户对客服回复</th>
        <th >{$tj25->nvuser2}</th>
        <th >{$tj26->nvuser2}</th>
        <th >{$tj27->nvuser2}</th>
        <th >{$tj28->nvuser2}</th>
        <th >{$tj30->nvuser2}</th>
        <th >{$tj31->nvuser2}</th>
        <th >{$tj32->nvuser2}</th>
        <th >{$tj25->nvuser2+$tj26->nvuser2+$tj27->nvuser2+$tj28->nvuser2+$tj30->nvuser2+$tj31->nvuser2+$tj32->nvuser2}</th>
     </tr>
    <tr>
        <th style="text-align: right; ">女性用户登陆, 女性用户对客服回复多少消息</th>
        <th >{$tj25->nvmsg2}</th>
        <th >{$tj26->nvmsg2}</th>
        <th >{$tj27->nvmsg2}</th>
        <th >{$tj28->nvmsg2}</th>
        <th >{$tj30->nvmsg2}</th>
        <th >{$tj31->nvmsg2}</th>
        <th >{$tj32->nvmsg2}</th>
        <th >{$tj25->nvmsg2+$tj26->nvmsg2+$tj27->nvmsg2+$tj28->nvmsg2+$tj30->nvmsg2+$tj31->nvmsg2+$tj32->nvmsg2}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">女性用户登陆,客服手动回复了多少女性用户</th>
        <th >{$tj25->nvuser3}</th>
        <th >{$tj26->nvuser3}</th>
        <th >{$tj27->nvuser3}</th>
        <th >{$tj28->nvuser3}</th>
        <th >{$tj30->nvuser3}</th>
        <th >{$tj31->nvuser3}</th>
        <th >{$tj32->nvuser3}</th>
        <th >{$tj25->nvuser3+$tj26->nvuser3+$tj27->nvuser3+$tj28->nvuser3+$tj30->nvuser3+$tj31->nvuser3+$tj32->nvuser3}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">女性用户登陆, 客服手动回复了女性用户多少消息</th>
        <th >{$tj25->nvmsg3}</th>
        <th >{$tj26->nvmsg3}</th>
        <th >{$tj27->nvmsg3}</th>
        <th >{$tj28->nvmsg3}</th>
        <th >{$tj30->nvmsg3}</th>
        <th >{$tj31->nvmsg3}</th>
        <th >{$tj32->nvmsg3}</th>
        <th >{$tj25->nvmsg3+$tj26->nvmsg3+$tj27->nvmsg3+$tj28->nvmsg3+$tj30->nvmsg3+$tj31->nvmsg3+$tj32->nvmsg3}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">男性用户注册,系统给客服推送用户数</th>
        <th >{$tj25->nanreg}</th>
        <th >{$tj26->nanreg}</th>
        <th >{$tj27->nanreg}</th>
        <th >{$tj28->nanreg}</th>
        <th >{$tj30->nanreg}</th>
        <th >{$tj31->nanreg}</th>
        <th >{$tj32->nanreg}</th>
        <th >{$tj25->nanreg+$tj26->nanreg+$tj27->nanreg+$tj28->nanreg+$tj30->nanreg+$tj31->nanreg+$tj32->nanreg}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">男用户注册,自动查看了多少用户</th>
        <th >{$tj25->nanuser}</th>
        <th >{$tj26->nanuser}</th>
        <th >{$tj27->nanuser}</th>
        <th >{$tj28->nanuser}</th>
        <th >{$tj30->nanuser}</th>
        <th >{$tj31->nanuser}</th>
        <th >{$tj32->nanuser}</th>
        <th >{$tj25->nanuser+$tj26->nanuser+$tj27->nanuser+$tj28->nanuser+$tj30->nanuser+$tj31->nanuser+$tj32->nanuser}</th>
     </tr>
    <tr>
        <th style="text-align: right; ">男用户注册,自动查看了多少次</th>
        <th >{$tj25->nanmsg}</th>
        <th >{$tj26->nanmsg}</th>
        <th >{$tj27->nanmsg}</th>
        <th >{$tj28->nanmsg}</th>
        <th >{$tj30->nanmsg}</th>
        <th >{$tj31->nanmsg}</th>
        <th >{$tj32->nanmsg}</th>
        <th >{$tj25->nanmsg+$tj26->nanmsg+$tj27->nanmsg+$tj28->nanmsg+$tj30->nanmsg+$tj31->nanmsg+$tj32->nanmsg}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">男用户注册,多少男用户对客服回复</th>
        <th >{$tj25->nanuser2}</th>
        <th >{$tj26->nanuser2}</th>
        <th >{$tj27->nanuser2}</th>
        <th >{$tj28->nanuser2}</th>
        <th >{$tj30->nanuser2}</th>
        <th >{$tj31->nanuser2}</th>
        <th >{$tj32->nanuser2}</th>
        <th >{$tj25->nanuser2+$tj26->nanuser2+$tj27->nanuser2+$tj28->nanuser2+$tj30->nanuser2+$tj31->nanuser2+$tj32->nanuser2}</th>
     </tr>
    <tr>
        <th style="text-align: right; ">男用户注册, 男用户对客服回复多少消息</th>
        <th >{$tj25->nanmsg2}</th>
        <th >{$tj26->nanmsg2}</th>
        <th >{$tj27->nanmsg2}</th>
        <th >{$tj28->nanmsg2}</th>
        <th >{$tj30->nanmsg2}</th>
        <th >{$tj31->nanmsg2}</th>
        <th >{$tj32->nanmsg2}</th>
        <th >{$tj25->nanmsg2+$tj26->nanmsg2+$tj27->nanmsg2+$tj28->nanmsg2+$tj30->nanmsg2+$tj31->nanmsg2+$tj32->nanmsg2}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">男用户注册,客服手动回复了多少男用户</th>
        <th >{$tj25->nanuser3}</th>
        <th >{$tj26->nanuser3}</th>
        <th >{$tj27->nanuser3}</th>
        <th >{$tj28->nanuser3}</th>
        <th >{$tj30->nanuser3}</th>
        <th >{$tj31->nanuser3}</th>
        <th >{$tj32->nanuser3}</th>
        <th >{$tj25->nanuser3+$tj26->nanuser3+$tj27->nanuser3+$tj28->nanuser3+$tj30->nanuser3+$tj31->nanuser3+$tj32->nanuser3}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">男用户注册, 客服手动回复了男用户多少消息</th>
        <th >{$tj25->nanmsg3}</th>
        <th >{$tj26->nanmsg3}</th>
        <th >{$tj27->nanmsg3}</th>
        <th >{$tj28->nanmsg3}</th>
        <th >{$tj30->nanmsg3}</th>
        <th >{$tj31->nanmsg3}</th>
        <th >{$tj32->nanmsg3}</th>
        <th >{$tj25->nanmsg3+$tj26->nanmsg3+$tj27->nanmsg3+$tj28->nanmsg3+$tj30->nanmsg3+$tj31->nanmsg3+$tj32->nanmsg3}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">参与多少个圈子</th>
        <th >{$tj25->topiccount}</th>
        <th >{$tj26->topiccount}</th>
        <th >{$tj27->topiccount}</th>
        <th >{$tj28->topiccount}</th>
        <th >{$tj30->topiccount}</th>
        <th >{$tj31->topiccount}</th>
        <th >{$tj32->topiccount}</th>
        <th >{$tj25->topiccount+$tj26->topiccount+$tj27->topiccount+$tj28->topiccount+$tj30->topiccount+$tj31->topiccount+$tj32->topiccount}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">圈子里发了多少句消息</th>
        <th >{$tj25->topicmsg}</th>
        <th >{$tj26->topicmsg}</th>
        <th >{$tj27->topicmsg}</th>
        <th >{$tj28->topicmsg}</th>
        <th >{$tj30->topicmsg}</th>
        <th >{$tj31->topicmsg}</th>
        <th >{$tj32->topicmsg}</th>
        <th >{$tj25->topicmsg+$tj26->topicmsg+$tj27->topicmsg+$tj28->topicmsg+$tj30->topicmsg+$tj31->topicmsg+$tj32->topicmsg}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">多少用户送礼物</th>
        <th >{$tj25->giftuser}</th>
        <th >{$tj26->giftuser}</th>
        <th >{$tj27->giftuser}</th>
        <th >{$tj28->giftuser}</th>
        <th >{$tj30->giftuser}</th>
        <th >{$tj31->giftuser}</th>
        <th >{$tj32->giftuser}</th>
        <th >{$tj25->giftuser+$tj26->giftuser+$tj27->giftuser+$tj28->giftuser+$tj30->giftuser+$tj31->giftuser+$tj32->giftuser}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">收到多少礼物</th>
        <th >{$tj25->giftrecv}</th>
        <th >{$tj26->giftrecv}</th>
        <th >{$tj27->giftrecv}</th>
        <th >{$tj28->giftrecv}</th>
        <th >{$tj30->giftrecv}</th>
        <th >{$tj31->giftrecv}</th>
        <th >{$tj32->giftrecv}</th>
        <th >{$tj25->giftrecv+$tj26->giftrecv+$tj27->giftrecv+$tj28->giftrecv+$tj30->giftrecv+$tj31->giftrecv+$tj32->giftrecv}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">送了多少礼物</th>
        <th >{$tj25->giftsend}</th>
        <th >{$tj26->giftsend}</th>
        <th >{$tj27->giftsend}</th>
        <th >{$tj28->giftsend}</th>
        <th >{$tj30->giftsend}</th>
        <th >{$tj31->giftsend}</th>
        <th >{$tj32->giftsend}</th>
        <th >{$tj25->giftsend+$tj26->giftsend+$tj27->giftsend+$tj28->giftsend+$tj30->giftsend+$tj31->giftsend+$tj32->giftsend}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">女性用户注册消息</th>
        <th >{$tj25->nvreg}</th>
        <th >{$tj26->nvreg}</th>
        <th >{$tj27->nvreg}</th>
        <th >{$tj28->nvreg}</th>
        <th >{$tj30->nvreg}</th>
        <th >{$tj31->nvreg}</th>
        <th >{$tj32->nvreg}</th>
        <th >{$tj25->nvreg+$tj26->nvreg+$tj27->nvreg+$tj28->nvreg+$tj30->nvreg+$tj31->nvreg+$tj32->nvreg}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">女性用户注册,自动回复了多少用户</th>
        <th >{$tj25->nruser}</th>
        <th >{$tj26->nruser}</th>
        <th >{$tj27->nruser}</th>
        <th >{$tj28->nruser}</th>
        <th >{$tj30->nruser}</th>
        <th >{$tj31->nruser}</th>
        <th >{$tj32->nruser}</th>
        <th >{$tj25->nruser+$tj26->nruser+$tj27->nruser+$tj28->nruser+$tj30->nruser+$tj31->nruser+$tj32->nruser}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">女性用户注册,自动回复了多少消息</th>
        <th >{$tj25->nrmsg}</th>
        <th >{$tj26->nrmsg}</th>
        <th >{$tj27->nrmsg}</th>
        <th >{$tj28->nrmsg}</th>
        <th >{$tj30->nrmsg}</th>
        <th >{$tj31->nrmsg}</th>
        <th >{$tj32->nrmsg}</th>
        <th >{$tj25->nrmsg+$tj26->nrmsg+$tj27->nrmsg+$tj28->nrmsg+$tj30->nrmsg+$tj31->nrmsg+$tj32->nrmsg}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">女性用户注册,多少女性用户对客服回复</th>
        <th >{$tj25->nruser2}</th>
        <th >{$tj26->nruser2}</th>
        <th >{$tj27->nruser2}</th>
        <th >{$tj28->nruser2}</th>
        <th >{$tj30->nruser2}</th>
        <th >{$tj31->nruser2}</th>
        <th >{$tj32->nruser2}</th>
        <th >{$tj25->nruser2+$tj26->nruser2+$tj27->nruser2+$tj28->nruser2+$tj30->nruser2+$tj31->nruser2+$tj32->nruser2}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">女性用户注册, 女性用户对客服回复多少消息</th>
        <th >{$tj25->nrmsg2}</th>
        <th >{$tj26->nrmsg2}</th>
        <th >{$tj27->nrmsg2}</th>
        <th >{$tj28->nrmsg2}</th>
        <th >{$tj30->nrmsg2}</th>
        <th >{$tj31->nrmsg2}</th>
        <th >{$tj32->nrmsg2}</th>
        <th >{$tj25->nrmsg2+$tj26->nrmsg2+$tj27->nrmsg2+$tj28->nrmsg2+$tj30->nrmsg2+$tj31->nrmsg2+$tj32->nrmsg2}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">女性用户注册,客服手动回复了多少女性用户</th>
        <th >{$tj25->nruser3}</th>
        <th >{$tj26->nruser3}</th>
        <th >{$tj27->nruser3}</th>
        <th >{$tj28->nruser3}</th>
        <th >{$tj30->nruser3}</th>
        <th >{$tj31->nruser3}</th>
        <th >{$tj32->nruser3}</th>
        <th >{$tj25->nruser3+$tj26->nruser3+$tj27->nruser3+$tj28->nruser3+$tj30->nruser3+$tj31->nruser3+$tj32->nruser3}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">女性用户注册, 客服手动回复了女性用户多少消息</th>
        <th >{$tj25->nrmsg3}</th>
        <th >{$tj26->nrmsg3}</th>
        <th >{$tj27->nrmsg3}</th>
        <th >{$tj28->nrmsg3}</th>
        <th >{$tj30->nrmsg3}</th>
        <th >{$tj31->nrmsg3}</th>
        <th >{$tj32->nrmsg3}</th>
        <th >{$tj25->nrmsg3+$tj26->nrmsg3+$tj27->nrmsg3+$tj28->nrmsg3+$tj30->nrmsg3+$tj31->nrmsg3+$tj32->nrmsg3}</th>
    </tr>
    <tr>
        <th style="text-align: right; ">
            <input type="hidden" name="tj25" id="tj25" value='{$tj25_jd}'/>
            <input type="hidden" name="tj26" id="tj26" value='{$tj26_jd}'/>
            <input type="hidden" name="tj27" id="tj27" value='{$tj27_jd}'/>
            <input type="hidden" name="tj28" id="tj28" value='{$tj28_jd}'/>
            <input type="hidden" name="tj30" id="tj30" value='{$tj30_jd}'/>
            <input type="hidden" name="tj31" id="tj31" value='{$tj31_jd}'/>
            <input type="hidden" name="tj32" id="tj32" value='{$tj32_jd}'/>
            <input type="hidden" name="uid" id="uid" value=""/>
        </th>
        <th >{if $tj25==""}<button class="btn btn-primary" onclick="submitFun(25)" type="submit">再查</button>{/if}</th>
        <th >{if $tj26==""}<button class="btn btn-primary" onclick="submitFun(26)" type="submit">再查</button>{/if}</th>
        <th >{if $tj27==""}<button class="btn btn-primary" onclick="submitFun(27)" type="submit">再查</button>{/if}</th>
        <th >{if $tj28==""}<button class="btn btn-primary" onclick="submitFun(28)" type="submit">再查</button>{/if}</th>
        <th >{if $tj30==""}<button class="btn btn-primary" onclick="submitFun(30)" type="submit">再查</button>{/if}</th>
        <th >{if $tj31==""}<button class="btn btn-primary" onclick="submitFun(31)" type="submit">再查</button>{/if}</th>
        <th >{if $tj32==""}<button class="btn btn-primary" onclick="submitFun(32)" type="submit">再查</button>{/if}</th>
        <th ></th>
    </tr>

    </thead>
</table>

</form>
<script type="text/javascript">


    function submitFun(num) {
        document.getElementById('uid').value=num;
    }

</script>
{include "pager.tpl"}
{include "footer.tpl"}