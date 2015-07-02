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
                <table class="form">
                    <tbody>
                        <?php if ($files){ ?>
                        <tr>
                            <td><label><?php echo $entry_files; ?></label></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="well well-sm" style="height: 150px; overflow: auto;">
                                    <?php foreach ($files as $i=>$file){ ?>
                                    <div class="<?php echo $i%2 ? 'odd' : 'even'; ?>"><?php echo $file; ?></div>
                                    <?php } ?>
                                </div>
                            </td>
                        </tr>
                        <?php } ?>
                        <tr>
                            <td><label><?php echo $entry_files_replaced; ?></label></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="well well-sm" style="height: 150px; overflow: auto;">
                                    <?php foreach ($replaced as $i=>$file){ ?>
                                    <div class="<?php echo $i%2 ? 'odd' : 'even'; ?>"><?php echo $file; ?></div>
                                    <?php } ?>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>