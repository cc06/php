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

<div style="position: relative;">

<table class="table table-hover table-report" style="margin-bottom: 5px" id="report_table2">
    <thead>
    <tr>
        <th style="width: 110px;" nowrap="value">日期</th>
        <th style="width: 120px;" nowrap="value">注册人数<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;" nowrap="value">上线领奖人数留存</th>
        <th style="width: 120px;" nowrap="value">手机认证<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;" nowrap="value">视频认证<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;" nowrap="value">身份认证<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;" nowrap="value">认证等级1<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;" nowrap="value">认证等级2<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 120px;" nowrap="value">认证等级3<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 150px;" nowrap="value">诚信星级1<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 150px;" nowrap="value">诚信星级2<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 150px;" nowrap="value">诚信星级3<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 150px;" nowrap="value">诚信星级4<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 150px;" nowrap="value">诚信星级5<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 150px;" nowrap="value">诚信星级6<span style="font-size: 12px;">(<span style="color: #0069b2;">男</span>,<span style=" color: #FF0000;">女</span>)</span></th>
        <th style="width: 150px;" nowrap="value">上传3张照片</th>
        <th style="width: 150px;" nowrap="value">资料填写完成</th>
        <th style="width: 150px;" nowrap="value">上传3张照片和资料填写完成(星级用户,头像被审核)</th>
    </tr>
    </thead>
    {assign var="j" value=1} {while $j <= 7}
        <tr title="{$total_rs[$j]['time']}">
            <th nowrap="value">{$total_rs[$j]['time']}</th>
            <th nowrap="value">{$total_rs[$j]['zhuce']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$total_rs[$j]['zhuce1']}</span>,<span style=" color: #FF0000;">{$total_rs[$j]['zhuce2']}</span>)</span></th>
            <th nowrap="value">{if $total_rs[$j]['zhuce']>0}{round($total_rs[$j]['liucun']*10000/$total_rs[$j]['zhuce'])/100}%{/if}</th>
            <th nowrap="value">{$total_rs[$j]['phonestat']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$total_rs[$j]['phonestat1']}</span>,<span style=" color: #FF0000;">{$total_rs[$j]['phonestat2']}</span>)</span></th>
            <th nowrap="value">{$total_rs[$j]['certify_video']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$total_rs[$j]['certify_video1']}</span>,<span style=" color: #FF0000;">{$total_rs[$j]['certify_video2']}</span>)</span></th>
            <th nowrap="value">{$total_rs[$j]['certify_idcard']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$total_rs[$j]['certify_idcard1']}</span>,<span style=" color: #FF0000;">{$total_rs[$j]['certify_idcard2']}</span>)</span></th>
            <th nowrap="value">{$total_rs[$j]['certify_level1']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$total_rs[$j]['certify_level1_1']}</span>,<span style=" color: #FF0000;">{$total_rs[$j]['certify_level1_2']}</span>)</span></th>
            <th nowrap="value">{$total_rs[$j]['certify_level2']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$total_rs[$j]['certify_level2_1']}</span>,<span style=" color: #FF0000;">{$total_rs[$j]['certify_level2_2']}</span>)</span></th>
            <th nowrap="value">{$total_rs[$j]['certify_level3']}<span style="font-size: 12px;">(<span style="color: #0069b2;">{$total_rs[$j]['certify_level3_1']}</span>,<span style=" color: #FF0000;">{$total_rs[$j]['certify_level3_2']}</span>)</span></th>
            <th nowrap="value">{$total_rs[$j]['honesty_level1']}({if $total_rs[$j]['honesty_level']>0}{round($total_rs[$j]['honesty_level1']*10000/$total_rs[$j]['honesty_level'])/100}%{/if})<span style="font-size: 12px;">(<span style="color: #0069b2;">{$total_rs[$j]['honesty_level1_1']}</span>,<span style=" color: #FF0000;">{$total_rs[$j]['honesty_level1_2']}</span>)</span></th>
            <th nowrap="value">{$total_rs[$j]['honesty_level2']}({if $total_rs[$j]['honesty_level']>0}{round($total_rs[$j]['honesty_level2']*10000/$total_rs[$j]['honesty_level'])/100}%{/if})<span style="font-size: 12px;">(<span style="color: #0069b2;">{$total_rs[$j]['honesty_level2_1']}</span>,<span style=" color: #FF0000;">{$total_rs[$j]['honesty_level2_2']}</span>)</span></th>
            <th nowrap="value">{$total_rs[$j]['honesty_level3']}({if $total_rs[$j]['honesty_level']>0}{round($total_rs[$j]['honesty_level3']*10000/$total_rs[$j]['honesty_level'])/100}%{/if})<span style="font-size: 12px;">(<span style="color: #0069b2;">{$total_rs[$j]['honesty_level3_1']}</span>,<span style=" color: #FF0000;">{$total_rs[$j]['honesty_level3_2']}</span>)</span></th>
            <th nowrap="value">{$total_rs[$j]['honesty_level4']}({if $total_rs[$j]['honesty_level']>0}{round($total_rs[$j]['honesty_level4']*10000/$total_rs[$j]['honesty_level'])/100}%{/if})<span style="font-size: 12px;">(<span style="color: #0069b2;">{$total_rs[$j]['honesty_level4_1']}</span>,<span style=" color: #FF0000;">{$total_rs[$j]['honesty_level4_2']}</span>)</span></th>
            <th nowrap="value">{$total_rs[$j]['honesty_level5']}({if $total_rs[$j]['honesty_level']>0}{round($total_rs[$j]['honesty_level5']*10000/$total_rs[$j]['honesty_level'])/100}%{/if})<span style="font-size: 12px;">(<span style="color: #0069b2;">{$total_rs[$j]['honesty_level5_1']}</span>,<span style=" color: #FF0000;">{$total_rs[$j]['honesty_level5_2']}</span>)</span></th>
            <th nowrap="value">{$total_rs[$j]['honesty_level6']}({if $total_rs[$j]['honesty_level']>0}{round($total_rs[$j]['honesty_level6']*10000/$total_rs[$j]['honesty_level'])/100}%{/if})<span style="font-size: 12px;">(<span style="color: #0069b2;">{$total_rs[$j]['honesty_level6_1']}</span>,<span style=" color: #FF0000;">{$total_rs[$j]['honesty_level6_2']}</span>)</span></th>
            <th nowrap="value"><a href="/admin/UserCertify/detail?date={$total_rs[$j]['time']}&item=2" target="_blank">{$total_rs[$j]['zhaopian3']}</a></th>
            <th nowrap="value"><a href="/admin/UserCertify/detail?date={$total_rs[$j]['time']}&item=3" target="_blank">{$total_rs[$j]['ziliao']}</a></th>
            <th nowrap="value">{$total_rs[$j]['zhaopian3_ziliao']}({$total_rs[$j]['xingji']},{$total_rs[$j]['touxiang']})</th>
            <th nowrap="value" style="display: none;">{$j++}</th>
        </tr>
    {/while}


</table>
</div>

{include "pager.tpl"}
{include "footer.tpl"}