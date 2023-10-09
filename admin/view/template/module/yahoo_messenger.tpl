<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-Ym" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-Ym" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>          
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>

          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title"><?php echo $heading_yahoo_style; ?></h3>
            </div>
            <div class="panel-body">
              <div class="row">
                <?php for($i=1;$i<=24;$i++){ ?>
                  <div class="col-sm-3 min-height-ym-avatar">
                      <div class="radio">
                        <label for="yahoo_label<?php echo $i; ?>">
                          <input type="radio" name="yahoomessenger_style" value="<?php echo $i; ?>" id="yahoo_label<?php echo $i; ?>" <?php echo $yahoomessenger_style==$i?'checked="checked"':''; ?> />
                          <img src="<?php echo HTTP_CATALOG; ?>image/yahoo/<?php echo $i; ?>.gif" />
                        </label>
                      </div>                      
                  </div>
              <?php } ?>
              </div>
            </div>
          </div>

          <div class="panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title"><?php echo $heading_yahoo_user; ?></h3>
            </div>
            <div class="panel-body">
              <table id="module" class="table table-striped table-bordered table-hover">
                <thead>
                  <tr>
                    <td class="text-left"><?php echo $entry_yahoo_id; ?></td>
                    <td class="text-left"><?php echo $entry_yahoo_display_name; ?></td>
                    <td></td>
                  </tr>
                </thead>
                <tbody>
                  <?php $row = ''; if ($yahoomessenger_code) { foreach ($yahoomessenger_code as $module_row => $module) { ?>
                  <tr id="module-row<?php echo $module_row; ?>">
                    <td class="text-left">
                      <input type="text" name="yahoomessenger_code[<?php echo $module_row; ?>][yahooid]" value="<?php echo $module['yahooid']; ?>" class="form-control" />
                    </td>
                    <td class="text-left"><input type="text" name="yahoomessenger_code[<?php echo $module_row; ?>][yahooname]" value="<?php echo $module['yahooname']; ?>" class="form-control" /></td>
                    <td class="text-left"><button type="button" onclick="$('#module-row<?php echo $module_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                  </tr>
                  <?php $row = $module_row; }} ?>
                </tbody>
                <tfoot>
                  <tr>
                    <td colspan="2"></td>
                    <td class="text-left"><button type="button" onclick="addModule();" data-toggle="tooltip" title="<?php echo $button_add_module; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>

        </form>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo ($row === '')?$row=0:$row+1; ?>;

function addModule() {  
  html  = '<tbody id="module-row' + module_row + '">';
  html += '  <tr>';
  html += '    <td class="left"><input type="text" name="yahoomessenger_code[' + module_row + '][yahooid]" value="" class="form-control" /></td>';
  html += '    <td class="left"><input type="text" name="yahoomessenger_code[' + module_row + '][yahooname]" value="" class="form-control" /></td>';
  html += '    <td class="left"><button type="button" onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i></a></td>';
  html += '  </tr>';
  html += '</tbody>';
  
  $('#module tfoot').before(html);
  
  module_row++;
}
//--></script> 
<?php echo $footer; ?>