{include 'header.tpl'}
<div role="alert" class="alert alert-{if $messageType eq 'error'}warning{else}{$messageType}{/if}">
    {$message_content}
    {if $messageType eq 'error'}
        <a href="javascript:;" onclick="history.go(-1);">返回</a>
    {/if}

</div>


{if $jump_url}
    <script type="text/javascript">
        setTimeout(function () {
            location = "{$jump_url}";
        }, 4000);
    </script>
{/if}

{include 'footer.tpl'}
