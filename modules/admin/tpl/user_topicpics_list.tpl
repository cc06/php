{include 'header.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<ol class="breadcrumb">
    <li class="active" style="width:100%; ">审核圈子  <button  onclick="window.location.reload();" class="btn btn-primary" style="float:right;">刷新</button></li>
</ol>

<form method="get" action="/admin/TopicPics/list" class="form-inline" >
    <table>
        <tr>
            <td>
                <label for="form-w" class="control-label">UID：</label>
                <input class="form-control" type="text" name="uid" value="{if $uid >0}{$uid}{/if}">
            </td>
            <td><button type="submit" style="margin-left: 20px;" class="btn btn-primary">查找</button></td>
            <td><a href="/admin/TopicPics/list?tiaojian=dangri"><div  style="margin-left: 20px;" class="btn btn-primary">当日创建</div></a></td>
            <td><a href="/admin/TopicPics/list?tiaojian=zuori"><div  style="margin-left: 20px;" class="btn btn-primary">昨日</div></a></td>
            <td><a href="/admin/TopicPics/list?tiaojian=qianri"><div  style="margin-left: 20px;" class="btn btn-primary">前日</div></a></td>
            <td><a href="/admin/TopicPics/list?tiaojian=fengsuo"><div  style="margin-left: 20px;" class="btn btn-primary">封锁的</div></a></td>
            <td><a href="/admin/TopicPics/list?tiaojian=zhengchang"><div  style="margin-left: 20px;" class="btn btn-primary">正常的</div></a></td>
        </tr>
    </table>
</form>

<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">
    <tr>
        <th style="width: 10px;">编号</th>
        <th style="width: 90px;">名称</th>
        <th style="width: 80px;">创建人</th>
        <th style="width: 180px;">图片</th>
        <th style="width: 80px;">创建时间</th>
        <th style="width: 150px;">操作</th>

    </tr>

    {foreach from=$topics item=item name=foo}
    <form rel="ajax" id="add_form" method="post" action="/admin/TopicPics/shenhe?id={$item.id}" class="form-horizontal" role="form">
        <tr class="t_c"  style="vertical-align: middle">
            <td>{$smarty.foreach.foo.index+1}</td>
            <td>{$item.title}</td>
            <td style="line-height: 30px;">{$item.nickname}<br>UID:{$item.uid}<br>性别:{if $item.gender==1}男{else}女{/if}<br>{$item.province}{$item.city}</td>
            <td><div style="float: left;">{$photos=explode(',',$item.pics)}{foreach $photos as $photo}
                    {if $photo neq ""}<img width="100" style="margin: 5px" height="100" src="{$photo}"  class="img-rounded"/>{/if}
                {/foreach}</div></td>
            <td>{$item.tm}</td>
            <td>  <select name="picslevel" id="picslevel" class="form-control" style="width: 100px;">
                    <option value="-1" {if $item.picslevel=='-1'}selected {/if}>未通过</option>
                    <option value="0" {if $item.picslevel=='0'}selected {/if}>差</option>
                    <option value="3" {if $item.picslevel=='3'}selected {/if}>默认</option>
                    <option value="6" {if $item.picslevel=='6'}selected {/if}>好</option>
                    <option value="9" {if $item.picslevel=='9'}selected {/if}>优秀</option>

                </select>
                {if $item.status==1}<button  class="btn btn-primary" style="float:right;">提交</button>{/if}
                {if $item.status==2}已关闭{/if}
                <a href="/admin/Topic/message?tid={$item.id}" target="_blank" >聊天记录</a>
            </td>
        </tr>
    </form>
    {/foreach}
</table>

{include "pager.tpl"}
{include 'footer.tpl'}
