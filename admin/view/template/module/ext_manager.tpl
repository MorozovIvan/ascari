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
                <div class="pull-right btn-group">
                    <a href="<?php echo $action_upload; ?>" data-toggle="tooltip" title="<?php echo $button_upload; ?>" class="btn btn-primary"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></a>
                    <a href="<?php echo $action; ?>" data-toggle="tooltip" title="<?php echo $button_refresh; ?>" class="btn btn-info"><i class="fa fa-refresh"></i> <?php echo $button_refresh; ?></a>
                    <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i> <?php echo $button_cancel; ?></a>
                </div>
                <div style="clear: both;"></div>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-general" data-toggle="tab"><i class="fa fa-power-off"></i> <?php echo $tab_general; ?></a></li>
                        <li><a href="#tab-addist" data-toggle="tab"><i class="fa fa-wrench"></i> <?php echo $tab_addist; ?></a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">
                            <div class="well">
                                <div class="row" id="filter">
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label class="control-label" for="filter_name"><?php echo $entry_name; ?></label>
                                            <input type="text" name="filter_name" id="filter_name" value="<?php echo $filter_name; ?>" size="70" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label class="control-label" for="filter_date"><?php echo $entry_date; ?></label>
                                            <input type="text" name="filter_date" id="filter_date" value="<?php echo $filter_date; ?>" size="70" class="form-control date" />
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label class="control-label" for="filter_version"><?php echo $entry_version; ?></label>
                                            <input type="text" name="filter_version" id="filter_version" value="<?php echo $filter_version; ?>" size="70" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <label class="control-label" for="filter_status"><?php echo $entry_status; ?></label>
                                            <select name="filter_status" id="filter_status" class="form-control">
                                                <option value=""><?php echo $text_all; ?></option>
                                                <?php foreach($statuses as $i=>$status){ ?>
                                                <option value="<?php echo $i; ?>"<?php if (isset($filter_status)&&$filter_status==$i){ ?> selected="selected"<?php } ?>><?php echo $status; ?></option>
                                                <?php } ?>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group text-right" style="padding-top: 20px;">
                                            <a onclick="filter();" class="btn btn-primary"><i class="fa fa-search"></i> <?php echo $button_filter; ?></a>
                                            <a onclick="clearfilter();" class="btn btn-primary"><i class="fa fa-eraser"></i> <?php echo $button_clear; ?></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <td class="text-left"><?php echo $column_title; ?></td>
                                        <td class="text-left"><?php echo $column_time; ?></td>
                                        <td class="text-left"><?php echo $column_time_update; ?></td>
                                        <td class="text-left"><?php echo $column_version; ?></td>
                                        <td class="text-left"><?php echo $column_status; ?></td>
                                        <td class="text-right" style="width: 250px;"><?php echo $column_action; ?></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if ($extensions) { ?>
                                    <?php foreach ($extensions as $extension) { ?>
                                    <tr>
                                        <td class="text-left"><?php echo $extension['title']; ?></td>
                                        <td class="text-left"><?php echo $extension['time']; ?></td>
                                        <td class="text-left"><?php echo $extension['time_update']; ?></td>
                                        <td class="text-left"><?php echo $extension['version']; ?></td>
                                        <td class="text-left"><?php echo $statuses[$extension['installed']]; ?></td>
                                        <td class="text-right">
                                            <?php if ($extension['installed']){ ?>
                                            <a href="<?php echo $extension['view_url']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info"><i class="fa fa-eye"></i></a>
                                            <a href="<?php echo $extension['update_url']; ?>" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="btn btn-info"><i class="fa fa-upload"></i></a>
                                            <a href="<?php echo $extension['restore_url']; ?>" data-toggle="tooltip" title="<?php echo $button_restore; ?>" class="btn btn-info"><i class="fa fa-rotate-left"></i></a>
                                            <a href="<?php echo $extension['backup_url']; ?>" data-toggle="tooltip" title="<?php echo $button_backup; ?>" class="btn btn-info"><i class="fa fa-archive"></i></a>
                                            <a href="<?php echo $extension['remove_url']; ?>" onclick="return confirm('<?php echo $text_confirm_delete; ?>')" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-trash"></i></a>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <?php } ?>
                                    <?php } else { ?>
                                    <tr>
                                        <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
                                    </tr>
                                    <?php } ?>
                                </tbody>
                            </table>
                            <div class="row"><?php echo $pagination; ?></div>
                        </div>
                        <div class="tab-pane" id="tab-addist"><?php echo $addist_tab; ?></div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript"><!--
function clearfilter() {
	url = 'index.php?route=module/ext_manager&token=<?php echo $token; ?>';

	window.location = url;
}
function filter() {
	url = 'index.php?route=module/ext_manager&token=<?php echo $token; ?>';
	
	var filter_name = $('input[name=\'filter_name\']').val();
	
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}
	
	var filter_date = $('input[name=\'filter_date\']').val();
	
	if (filter_date) {
		url += '&filter_date=' + encodeURIComponent(filter_date);
	}
    
	var filter_version = $('input[name=\'filter_version\']').val();
	
	if (filter_version) {
		url += '&filter_version=' + encodeURIComponent(filter_version);
	}
    
	var filter_status = $('select[name=\'filter_status\']').val();
	
	if (filter_status) {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}
    
	window.location = url;
}

$(document).ready(function(){
    <?php if (OC_VERSION == '2.0.x'){ ?>
	$('.date').datetimepicker({locale: 'ru', format: 'YYYY-mm-DD', pickTime: false});
    <?php } else { ?>
    $('.date').datepicker({dateFormat: 'yy-mm-dd'});
    <?php } ?>
    
    $('#filter input').keydown(function(e) {
    	if (e.keyCode == 13) {
    		filter();
    	}
    });
});
//--></script>
<?php echo $footer; ?>