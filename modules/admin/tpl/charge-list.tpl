{include "header.tpl"}
<style>
    .table-report th,
    .table-report td {
        text-align: center;
    }
</style>

{*<form role="form" class="form-inline" action="?" method="get">*}
    {*<div class="form-group form-group-sm">*}
        {*<label for="exampleInputEmail2" class="sr-only ">注册来源</label>*}
        {*<select class="form-control" name="reg_type" id="form-search-reg_type">*}
            {*<option value="">全部</option>*}
            {*<option value="1">网站</option>*}
            {*<option value="5">微博</option>*}
            {*<option value="4">QQ</option>*}
        {*</select>*}
        {*<select class="form-control" name="spm" id="form-search-spm">*}
            {*<option value="">全部</option>*}
            {*{foreach from=$spmList item=item}*}
                {*<option value="{$item.spm}">{$item.spm_name}</option>*}
            {*{/foreach}*}
        {*</select>*}
    {*</div>*}

    {*<script>*}
        {*$('#form-search-reg_type').find("option[value='{$reg_type}']").attr("selected",true);*}
        {*$('#form-search-spm').find("option[value='{$spm}']").attr("selected",true);*}
    {*</script>*}
    {*<button class="btn btn-primary" type="submit">查找</button>*}
{*</form>*}


<table class="table table-hover table-report">
    <thead>
    <tr>
        <th>ID</th>
        <th style="width: 150px;">订单号</th>
        <th style="width: 50px;">充值金额</th>
        <th style="width: 50px;">拍币</th>

        <th>用户</th>
        <th>手机号</th>
        <th>时间</th>
    </tr>
    </thead>
    <tbody>
    {foreach from=$chargeLogList item=item}
        <tr>
            <td>{$item.auto_id}</td>
            <td>{$item.order_no}</td>
            <td>{$item.money}</td>
            <td>{$item.credit}</td>

            <td>{Service_User::getUserNicknameByUid($item.uid)}</td>
            <td><a target="_blank" href="http://www.baidu.com/#ie=utf-8&f=8&rsv_bp=1&tn=baidu&wd={Service_User::getUserCellPhoneByUid($item.uid)}&rsv_enter=1&rsv_sug3=12&rsv_sug4=752&rsv_sug1=8&rsv_sug2=0&inputT=4409"> {Service_User::getUserCellPhoneByUid($item.uid)}</a></td>
            <td></td>
            <td>{$item.create_time}</td>
        </tr>
    {/foreach}
    </tbody>
</table>
{include "footer.tpl"}