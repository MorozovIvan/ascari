<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="container-fluid">
        <ul class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
            <?php } ?>
        </ul>
    </div>
    <div class="container-fluid">
        <div id="message"<?php if (!$success && !$error){ ?> style="display: none;"<?php } ?>>
            <?php if ($success) { ?>
            <div class="alert alert-success">
                <i class="fa fa-check-circle"></i>
                <div><?php echo $success; ?></div>
            </div>
            <?php } ?>
            <?php if ($error) { ?>
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-circle"></i>
                <div><?php echo $error; ?></div>
            </div>
            <?php } ?>
        </div>
        
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
                <div class="pull-right">
                    <a href="<?php echo $action; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i> <?php echo $button_cancel; ?></a>
                </div>
                <div style="clear: both;"></div>
            </div>
            <div class="panel-body">
                <?php if (isset($header_text)){ ?>
                <h3 class="panel-title text-center" style="padding: 10px 0px;"><i class="fa fa-refresh"></i> <?php echo $header_text; ?></h3>
                <?php } ?>
                <form action="<?php echo $action_upload; ?>" method="post" id="form" enctype="multipart/form-data">
                    <input type="hidden" name="filename" value="<?php echo $upload_filename; ?>" />
                    <table class="form">
                        <tbody>
                            <tr>
                                <td><label for="file"><?php echo $entry_file; ?></label></td>
                                <td><input type="file" name="file" id="file" /></td>
                            </tr>
                            <tr>
                                <td><label for="name"><?php echo $entry_name; ?></label></td>
                                <td><input type="text" name="name" id="name" size="100" value="<?php echo $upload_name; ?>" class="form-control" /></td>
                            </tr>
                            <tr>
                                <td><label for="version"><?php echo $entry_version; ?></label></td>
                                <td><input type="text" name="version" id="version" size="100" value="<?php echo $upload_version; ?>" class="form-control" /></td>
                            </tr>
                            <?php if ($files){ ?>
                            <tr>
                                <td><label><?php echo $entry_exclude; ?></label></td>
                                <td>
                                    <div class="well well-sm" style="height: 150px; overflow: auto;">
                                        <?php foreach ($files as $i=>$file) { ?>
                                        <div class="checkbox">
                                            <label for="file_<?php echo $i; ?>"><input type="checkbox" id="file_<?php echo $i; ?>" name="exclude[]" value="<?php echo $file; ?>" /><?php echo $file; ?></label>
                                        </div>
                                        <?php } ?>
                                    </div>
                                    <a onclick="$(this).parent().find(':checkbox').attr('checked', true);" class="btn btn-default"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);" class="btn btn-default"><?php echo $text_unselect_all; ?></a>
                                </td>
                            </tr>
                            <?php } ?>
                            <tr>
                                <td><label><?php echo $entry_action; ?></label></td>
                                <td>
                                    <input type="hidden" name="type" id="type" value="install" />
                                    <?php if ($files){ ?>
                                    <a id="upbtn" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="btn btn-info"><i class="fa fa-upload"></i> <?php echo $button_update; ?></a>
                                    <?php }else{ ?>
                                    <a id="upbtn" data-toggle="tooltip" title="<?php echo $button_upload; ?>" class="btn btn-info"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></a>
                                    <a id="inbtn" data-toggle="tooltip" title="<?php echo $button_index; ?>" class="btn btn-info"><i class="fa fa-list"></i> <?php echo $button_index; ?></a>
                                    <?php } ?>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>


<script type="text/javascript">
token = '<?php echo $token; ?>';

$(document).ready(function()
{
    $('#upbtn').click(function()
    {
        $('#type').val('install');
        $('#form').submit();
    });
    
    $('#inbtn').click(function()
    {
        $('#type').val('index');
        $('#form').submit();
    });
    
    $('#form').submit(function(){
        if ($('#file').val()=='')
        {
            alert('<?php echo $error_no_file; ?>');
            return false;
        }
        var ext = getExt($('#file').val());
        if (ext != 'zip')
        {
            alert('<?php echo $error_not_zip; ?>')
            $('#file').val('');
            return false;
        }
        if ($('#name').val()=='')
        {
            alert('<?php echo $error_invalid_name; ?>');
            return false;
        }
    });
});

function getExt(filename)
{
    return (/[.]/.exec(filename)) ? /[^.]+$/.exec(filename) : undefined;
}
</script>
<?php echo $footer; ?>