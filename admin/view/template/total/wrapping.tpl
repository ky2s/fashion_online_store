<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-wrapping" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-wrapping" class="form-horizontal">                            
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="wrapping_status" id="input-status" class="form-control">
                <?php if ($wrapping_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-image-wrap"><?php echo $entry_image_gift_wrap; ?></label>
            <div class="col-sm-10">
              <div class="row">
                <div class="col-sm-6">
                  <input type="text" name="wrapping_width" value="<?php echo $wrapping_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-wrap" class="form-control" />
                </div>
                <div class="col-sm-6">
                  <input type="text" name="wrapping_height" value="<?php echo $wrapping_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                </div>
              </div>
              <?php if ($error_size) { ?>
              <div class="text-danger"><?php echo $error_size; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-image-preview-wrap"><?php echo $entry_image_gift_wrap_preview; ?></label>
            <div class="col-sm-10">
              <div class="row">
                <div class="col-sm-6">
                  <input type="text" name="wrapping_width_preview" value="<?php echo $wrapping_width_preview; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-preview-wrap" class="form-control" />
                </div>
                <div class="col-sm-6">
                  <input type="text" name="wrapping_height_preview" value="<?php echo $wrapping_height_preview; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                </div>
              </div>
              <?php if ($error_preview) { ?>
              <div class="text-danger"><?php echo $error_preview; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
            <div class="col-sm-10">
              <input type="text" name="wrapping_sort_order" value="<?php echo $wrapping_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
            </div>
          </div>

          <p><strong><?php echo $text_default; ?></strong></p>

          <table id="option-wrapper" class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td class="text-left"><?php echo $text_image; ?></td>
                <td class="text-left"><?php echo $text_name; ?></td>
                <td class="text-left"><?php echo $text_price; ?></td>
                <td class="text-right"><?php echo $text_order; ?></td>
                <td></td>                
              </tr>
            </thead>
            <tbody>
              <?php foreach ($wrapping_option as $key => $value) { ?>                              
              <tr class="data-option" id="option-row<?php echo $key; ?>">
                <input type="hidden" name="wrapping_option[<?php echo $key; ?>][id]" value="<?php echo $value['id']; ?>" />
                <td>                  
                  <a href="" id="thumb-image<?php echo $key; ?>" data-toggle="image" class="img-thumbnail">
                  <img src="<?php echo $value['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
                  </a>
                  <input type="hidden" name="wrapping_option[<?php echo $key; ?>][image]" value="<?php echo $value['image']; ?>" id="input-image<?php echo $key; ?>" />
                </td>
                <td>
                  <input type="text" name="wrapping_option[<?php echo $key; ?>][name]" value="<?php echo $value['name']; ?>" class="form-control" />
                </td>
                <td>
                  <input type="text" name="wrapping_option[<?php echo $key; ?>][price]" class="form-control" value="<?php echo $value['price']; ?>" />
                </td>
                <td>
                  <input type="number" min="0" name="wrapping_option[<?php echo $key; ?>][order]" class="form-control" value="<?php echo $value['order']; ?>" />
                </td>
                <td>
                  <button type="button" onclick="$('#option-row<?php echo $key; ?>, .tooltip').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>
                </td>
              </tr>
              <?php } ?>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="4"></td>
                <td class="text-left"><button type="button" onclick="addOption();" data-toggle="tooltip" title="<?php echo $button_add_wrapping; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
              </tr>
            </tfoot>
          </table>
        </form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript"><!--

var index = $('.data-option').length;

function addOption() {
  html  = '<tr class="data-option" id="option-row' + index + '">';
  html += '<input type="hidden" name="wrapping_option['+index+'][id]" value="'+index+'" />';
  html += '<td>';  
  html += '<a href="" id="thumb-image'+index+'" data-toggle="image" class="img-thumbnail">';
  html += '<img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />';
  html += '</a>';
  html += '<input type="hidden" name="wrapping_option['+index+'][image]" id="input-image'+index+'" />'     
  html += '</td>';

  html += '<td>';
  html += '<input type="text" name="wrapping_option['+index+'][name]" class="form-control" />';
  html += '</td>';

  html += '<td>';
  html += '<input type="text" name="wrapping_option['+index+'][price]" class="form-control" />';
  html += '</td>';

  html += '<td>';
  html += '<input type="number" min="0" name="wrapping_option['+index+'][order]" class="form-control" />';
  html += '</td>';

  html += '<td>';
  html += '<button type="button" onclick="$(\'#option-row'+index+', .tooltip\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>';
  html += '</td>';

  html += '</tr>';
   
  $('#option-wrapper tbody').append(html);
  
  index++;
}
//--></script>

<?php echo $footer; ?> 