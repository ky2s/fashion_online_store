<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right"><a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
        <button type="submit" form="form-product" formaction="<?php echo $copy; ?>" data-toggle="tooltip" title="<?php echo $button_copy; ?>" class="btn btn-default"><i class="fa fa-copy"></i></button>
        <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-product').submit() : false;"><i class="fa fa-trash-o"></i></button>
      </div>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
        <div class="pull-right" style="margin-top: -4px;">
        	<?php /* <a <?php if ($excelport) { ?> href="<?php echo $excelport_link; ?>" <?php } else { ?> onclick="alert('<?php echo $excelport_error; ?>');" <?php } ?> target="_blank" data-toggle="tooltip" title="Export using ExcelPort" class="btn btn-primary btn-sm"><i style="font-size:inherit !important;font-weight: inherit !important;" class="fa fa-file-excel-o"></i>&nbsp;&nbsp;<?php echo $text_export; ?></a>*/ ?>
            <a id="tableColumns" data-toggle="tooltip" title="<?php echo $button_togglecolumns; ?>" class="btn btn-warning btn-sm"><i style="font-size:inherit !important;font-weight: inherit !important;" class="fa fa-table"></i>&nbsp;<?php echo $button_togglecolumns; ?></a>            
            <button data-toggle="tooltip" title="<?php echo $showhide_filter; ?>" class="btn btn-sm btn-default" onclick="$('.filter-well').toggle(50);"><i class="fa fa-filter"></i> <?php echo $button_filter; ?></button>		
     	</div>
      </div>
      <div class="panel-body">
        <div class="well well-sm filter-well">
          <div class="row">
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              </div>
              <div class="form-group">
                <label class="control-label" for="input-model"><?php echo $entry_model; ?></label>
                <input type="text" name="filter_model" value="<?php echo $filter_model; ?>" placeholder="<?php echo $entry_model; ?>" id="input-model" class="form-control" />
              </div>
            </div>
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-price"><?php echo $entry_price; ?></label>
                <input type="text" name="filter_price" value="<?php echo $filter_price; ?>" placeholder="<?php echo $entry_price; ?>" id="input-price" class="form-control" />
              </div>
              <div class="form-group">
                <label class="control-label" for="input-quantity"><?php echo $entry_quantity; ?></label>
                <input type="text" name="filter_quantity" value="<?php echo $filter_quantity; ?>" placeholder="<?php echo $entry_quantity; ?>" id="input-quantity" class="form-control" />
              </div>
            </div>
            <div class="col-sm-4">
              <div class="form-group">
                <label class="control-label" for="input-status"><?php echo $entry_status; ?></label>
                <select name="filter_status" id="input-status" class="form-control">
                  <option value="*"></option>
                  <?php if ($filter_status) { ?>
                  	<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                 	<option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!$filter_status && !is_null($filter_status)) { ?>
                  	<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  	<option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
			  <div class="form-group">
                <label class="control-label" for="input-limit"><?php echo $entry_limit; ?></label>
                <input type="text" name="filter_limit" value="<?php echo $filter_limit; ?>" placeholder="<?php echo $entry_limit_placeholder; ?>" id="input-limit" class="form-control" />
              </div>
              <div id="popoverHiddenContent" style="display: none;">
                 <div> 
                 	<div class="col-xs-6" style="margin:0px;padding:0 15px 0 0;">  
                        <?php $i=0; foreach ($tableData as $key => $value) { ?>                      
                            <div class="checkbox">
                                <label>
                                  <input type="checkbox" class="tableColumnToggle" onclick="updateColumns(this);" data-key="<?php echo $key; ?>" /> <?php echo $value['name']; ?><?php if ($key=='image_filename') echo " <strong>*</strong>"; ?>
                                </label>
                            </div>
                            <?php if ($i==13) { echo "</div><div class='col-xs-6' style='margin:0px;padding:0px;'>"; } ?>
                        <?php $i++; } ?>
                    </div>
                    <div class="clearfix"></div>
                    <em><?php echo $asterisk_warning; ?></em>
                 </div>
              </div>  
              <div id="popoverHiddenTitle" style="display: none">
                 <strong><?php echo $button_togglecolumns; ?>:</strong>
              </div>
              <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
            </div>
          </div>
        </div>
		<div id="productsWrapper">
        	&nbsp;
        </div>
      </div>
    </div>
  </div>

<div class="modal fade" id="bulk-image-upload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel"><?php echo $bulk_modal_heading; ?></h4>
      </div>
      <div class="modal-body">
        <form enctype="multipart/form-data" id="bulk-image-upload-form" method="POST">
        	<div class="container-fluid">
                <div class="row">
                    <h4><?php echo $bulk_modal_text; ?></h4>
                    <div class="col-xs-9" style="padding-top: 7px;">
                        <input type="hidden" name="MAX_FILE_SIZE" value="80000" />
                        <input name="userfile" type="file" />
                    </div>
                    <div class="col-xs-3">
                        <input type="submit" class="btn btn-primary" value="<?php echo $upload_file; ?>" />
                    </div>
                </div>
            </div>
        </form>
        <div id="modalResult" style="display:none;"></div>
        <div id="modalErrors" style="display:none;"></div>
        <div class="additional-info">
			<br /><?php echo $bulk_image_structured; ?><br />
        	<ul>
            	<li><strong>images.zip</strong></li>
                <ul>
                    <li>456.png</li>
                    <li>52.jpg</li>
                    <li>123.jpg</li>
                    <li>7653.png</li>
                    <li>...</li>
                </ul>
            </ul>
            <?php echo $bulk_image_structured2; ?><br /><br />
        </div>
        <div class="well well-sm" style="margin-bottom: 0px;">
        	<strong>*</strong> <?php echo $bulk_image_help_all; ?>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $modal_close; ?></button>
      </div>
    </div>
  </div>
</div>
<style type="text/css">
.popover-medium {
  max-width: 600px;
  min-width: 320px;
  width: auto;
}
</style>
<script type="text/javascript"><!--
var files;
$('input[type=file]').on('change', prepareUpload);
$('#bulk-image-upload-form').on('submit', uploadFiles);

function prepareUpload(event) {
	files = event.target.files;
}

function uploadFiles(e) {
 	e.stopPropagation();
    e.preventDefault();
	$('#modalErrors').html('');
	$('#modalResult').html('');
    var data = new FormData();
    var status = true;
	$.each(files, function(key, value){
        data.append(key, value);
		if (value.type!="application/x-zip-compressed") {
			alert('<?php echo $bulk_zip_error; ?>');
			status = false;
		}
    });
	if (status) {
		$.ajax({
			url: 'index.php?route=catalog/productmanager/bulkupload&token=<?php echo $token; ?>',
			type: 'POST',
			data: data,
			cache: false,
			dataType: 'json',
			processData: false,
			contentType: false,
			success: function(data, textStatus, jqXHR)
			{
				if (data['error']) {
					$('#modalErrors').show();
					for (i = 0; i<data['error'].length; i++) {
						$('#modalErrors').append((i+1) + '. ' + data['error'][i] + '<br />');
					}
				} else {
					$('#modalResult').show(400);
					$('#modalResult').html('<br /><div class="alert alert-warning"><strong>' + data['total'] + '</strong> <?php echo $bulk_image_result; ?></div>');
					for (i = 0; i<data['products'].length; i++) {
						var element = 'thumb-image' + data['products'][i]['id'];
						$('#'+element).find('img').attr('width', '40px');
						$('#'+element).find('img').attr('height', '40px');
						$('#'+element).find('img').attr('src', data['products'][i]['product_image']);
						$('.editable.' + data['products'][i]['id'] + '.image_filename').html(data['products'][i]['image']);
					}
				}
			},
			error: function(jqXHR, textStatus, errorThrown)
			{
				alert('ERRORS: ' + textStatus);
				console.log('ERRORS: ' + textStatus);
			}
		});
	}
}

var columns = ['product_id','image','name','price','quantity','status'];
function updateTable() {
	$('.table-productManager td[data-key]').hide();
	$(columns).each(function(index, element) {
	   $('.table-productManager td[data-key="' + element + '"]').show(); 
	});	
}

$(document).ready(function(){
	<?php 
	$filter_option = '';
	if(! empty($filter_name)) $filter_option .= "&filter_name=".$filter_name;
	if(! empty($filter_model)) $filter_option .= "&filter_model=".$filter_model;
	if(! empty($filter_price)) $filter_option .= "&filter_price=".$filter_price;
	if(! empty($filter_quantity)) $filter_option .= "&filter_quantity=".$filter_quantity;
	if(! empty($filter_location)) $filter_option .= "&filter_location=".$filter_location;
	if(! empty($filter_sku)) $filter_option .= "&filter_sku=".$filter_sku;
	 ?>
	 
	 $.ajax({
		url: "index.php?route=catalog/productmanager/getList&token=<?php echo $token . $filter_option; ?>",
		type: 'get',
		dataType: 'html',
		success: function(data) {		
			$("#productsWrapper").html(data);
			updateTable();
		}

	 });
	 
	 if (window.localStorage && window.localStorage['columns']) {
		 var savedColumns = JSON.parse(localStorage.getItem('columns'));
		 if (savedColumns.length) {
		 	columns = savedColumns;
		 }
		 $(columns).each(function( index , value) {
			$('.tableColumnToggle[data-key="' + value + '"]').attr('checked',true);
		 });	 
	 }
	 
	 $("#tableColumns").popover({
        html : true, 
        content: function() {
          return $('#popoverHiddenContent').html();
        },
        title: function() {
          return $('#popoverHiddenTitle').html();
        },
		placement: 'bottom',
		template: '<div class="popover popover-medium"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title" style="font-size: 12px; font-weight: inherit;display:block;"></h3><div class="popover-content"><p></p></div></div></div>',
    });
	
	$('#bulk-image-upload').on('show.bs.modal', function () {
		$('#modalErrors').html('');
		$('#modalResult').html('');
		$('#modalErrors').hide();
		$('#modalResult').hide();
	});
});

function updateColumns(el) {
	var key = $(el).attr('data-key');
	var index = columns.indexOf(key);
	if (index != -1) {
		columns.splice(index, 1);
	}
	
	if ($(el).is(':checked')) {
		columns.push(key);
	}
	localStorage.setItem('columns', JSON.stringify(columns));
	$('#popoverHiddenContent input[data-key="'+key+'"]').attr('checked', $(el).is(':checked'));
	updateTable();
}

$('#button-filter').on('click', function() {
	var url = 'index.php?route=catalog/productmanager/getList&token=<?php echo $token; ?>';

	var filter_name = $('input[name=\'filter_name\']').val();
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
		setGetParameter('filter_name', filter_name);
	}

	var filter_model = $('input[name=\'filter_model\']').val();
	if (filter_model) {
		url += '&filter_model=' + encodeURIComponent(filter_model);
		setGetParameter('filter_model', filter_model);
	}

	var filter_price = $('input[name=\'filter_price\']').val();
	if (filter_price) {
		url += '&filter_price=' + encodeURIComponent(filter_price);
		setGetParameter('filter_price', filter_price);
	}

	var filter_quantity = $('input[name=\'filter_quantity\']').val();
	if (filter_quantity) {
		url += '&filter_quantity=' + encodeURIComponent(filter_quantity);
		setGetParameter('filter_quantity', filter_quantity);
	}

	var filter_status = $('select[name=\'filter_status\']').val();
	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
		setGetParameter('filter_status', filter_status);
	}
	
	var filter_limit = $('input[name=\'filter_limit\']').val();
	if (filter_limit) {
		url += '&filter_limit=' + encodeURIComponent(filter_limit);
	} else {
		url += '&filter_limit=10';
	}

	$.ajax({
		url: url,
		type: 'get',
		dataType: 'html',
		data: {
			columns: columns
		},
		success: function(data) {		
			$("#productsWrapper").html(data);
			updateTable();
		}
	});
});

$('input[name=\'filter_name\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['product_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'filter_name\']').val(item['label']);
	}
});

$('input[name=\'filter_model\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_model=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['model'],
						value: item['product_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'filter_model\']').val(item['label']);
	}
});

// Edit fields
function editable() {	
	$('#form-product').on('click', '.bulk-edit', function(e) {
		if ($(this).find('.after-edit-bulk').size()) return;
		var pdata = $(this).attr('data-key');
		var pid = [];
		$('input[name^="selected"]:checked').each(function(index, element) {
            pid[index] = $(element).val();
        });
		if (pid.length < 1) {
			alert('<?php echo $bulk_atleast2; ?>');		
		} else {
			$(this).hide();
			if (pdata == 'status' || pdata == 'shipping' || pdata == 'subtract') {
				var text_yes = '<?php echo $text_enabled; ?>';
				var text_no = '<?php echo $text_disabled; ?>';
				if (pdata=='shipping' || pdata=='subtract') {
					text_yes = '<?php echo $text_yes; ?>';	
					text_no = '<?php echo $text_no; ?>';
				}
				var select_status = '<select name="status" data-key="' + pdata + '" data-id="' + pid + '" class="form-control after-edit-bulk">';
				if ($(this).find('span.editable').attr('data-' + pdata) == 1) {
					select_status += '<option value="1" selected="selected">' + text_yes + '</option>';
					select_status += '<option value="0">' + text_no + '</option>';	
				} else {
					select_status += '<option value="1">' + text_yes + '</option>';
					select_status += '<option value="0" selected="selected">' + text_no + '</option>';	
				}
				select_status += '</select>';
				$(this).parents('td').append(select_status);
			} else if (pdata == 'tax_class' || pdata == 'weight_class' || pdata == 'stock_status' || pdata == 'manufacturer') {
				var select_select = '<select name="status" data-key="' + pdata + '" data-id="' + pid + '" class="form-control after-edit-bulk">';
				var selectable = <?php echo json_encode($tax_classes); ?>;
				var selectable_id = 'tax_class_id';
				var selectable_name = 'title';
				if (pdata == 'weight_class') {
					selectable = <?php echo json_encode($weight_classes); ?>;
					selectable_id = 'weight_class_id';
					selectable_name = 'title';
				} else if (pdata == 'stock_status') {
					selectable = <?php echo json_encode($stock_statuses); ?>;
					selectable_id = 'stock_status_id';
					selectable_name = 'name';	
				} else if (pdata == 'manufacturer') {
					selectable = <?php echo json_encode($manufacturers); ?>;
					selectable_id = 'manufacturer_id';
					selectable_name = 'name';
				}
				for (var i = 0; i < selectable.length; i++) {
					select_select += '<option value="' + selectable[i][selectable_id] + '">' + selectable[i][selectable_name] + '</option>';
				}
				select_select +='</select>';
				$(this).parents('td').append(select_select);
			} else {
				$(this).parents('td').append('<input type="text" data-key="' + pdata + '" data-id="' + pid + '" class="form-control after-edit-bulk" value="%value%" />');
			}
			$(this).parents('td').find('.after-edit-bulk').focus();
		}
	});
	
	$('#form-product').on('blur', '.after-edit-bulk', function(e){
		var pid = $(this).attr('data-id');
		var pdata = $(this).attr('data-key');
		var pvalue = $(this).val();
		if (confirm("<?php echo $confirm_bulk; ?>")) {
			doSaveBulk(pid, pdata, pvalue);
		}
		$('.after-edit-bulk').remove();
		$('.sorting').children('td[data-key="' + pdata + '"]').find('i').show();	
		e.stopPropagation();
		e.preventDefault();
		e.stopImmediatePropagation();
	});
	
	$('.sorting').on('keydown', '.after-edit-bulk', function(e) {
		if (e.keyCode == 13) {
			e.stopPropagation();
			e.preventDefault();
			e.stopImmediatePropagation();
			this.blur();
		}
	});

  function formatThousands(n, dp) {
    var s = ''+(Math.floor(n)), d = n % 1, i = s.length, r = '';
    while ( (i -= 3) > 0 ) { r = ',' + s.substr(i, 3) + r; }
    return s.substr(0, i + 3) + r + (d ? '.' + Math.round(d * Math.pow(10,dp||2)) : '');
  }
	
	function doSaveBulk(pid, pdata, pvalue) {
		$.ajax({
			url: "index.php?route=catalog/productmanager/updateproductbulk&token=<?php echo $token; ?>",
			type: "POST",
			dataType: "json",
			data: {
				pid: pid,
				pdata: pdata,
				pvalue: pvalue
			},
			success: function (resp) {
				if (resp['success']) {
					$('.after-edit-bulk').remove();
          
					$('.sorting').children('td[data-key="' + pdata + '"]').find('i').show();
					
					for (i = 0; i<resp['products'].length; i++) {
						// status & shipping & subtract

            resp['products'][i]['price'] = formatThousands(resp['products'][i]['price']);            

						if (resp['field']=='status' || resp['field']=='shipping' || resp['field']=='subtract') {
							var text_yes = '<?php echo $text_enabled; ?>';
							var text_no = '<?php echo $text_disabled; ?>';
							if (resp['field']=='shipping' || resp['field']=='subtract') {
								text_yes = '<?php echo $text_yes; ?>';	
								text_no = '<?php echo $text_no; ?>';
							}
							if (resp['products'][i][resp['field']] == 0) {
								$('.editable.' + resp['products'][i]['product_id'] + '.' + resp['field']).html(text_no);
							} else {
								$('.editable.' + resp['products'][i]['product_id'] + '.' + resp['field']).html(text_yes);
							}
							$('.editable.' + resp['products'][i]['product_id'] + '.' + resp['field']).attr('data-' + resp['field'], resp['products'][i][resp['field']]);
						// quantity
						} else if (resp['field']=='quantity') {
							$('.editable.' + resp['products'][i]['product_id'] + '.' + resp['field']).removeClass("label-warning label-danger label-success");
							$('.editable.' + resp['products'][i]['product_id'] + '.' + resp['field']).html(resp['products'][i][resp['field']]);
							if (resp['products'][i]['quantity'] <= 0) { 
								$('.editable.' + resp['products'][i]['product_id'] + '.' + resp['field']).addClass("label-warning");
							} else if (resp['products'][i]['quantity'] <= 5) {
								$('.editable.' + resp['products'][i]['product_id'] + '.' + resp['field']).addClass("label-danger");
							} else { 
								$('.editable.' + resp['products'][i]['product_id'] + '.' + resp['field']).addClass("label-success");
							}								
						// stock_status & manufacturer & weight_class & tax_class
						} else if (pdata == 'tax_class' || pdata == 'weight_class' || pdata == 'stock_status' || pdata == 'manufacturer') {
							var selectable = <?php echo json_encode($tax_classes); ?>;
							var selectable_id = 'tax_class_id';
							var selectable_name = 'title';
							if (pdata == 'weight_class') {
								selectable = <?php echo json_encode($weight_classes); ?>;
								selectable_id = 'weight_class_id';
								selectable_name = 'title';
							} else if (pdata == 'stock_status') {
								selectable = <?php echo json_encode($stock_statuses); ?>;
								selectable_id = 'stock_status_id';
								selectable_name = 'name';	
							} else if (pdata == 'manufacturer') {
								selectable = <?php echo json_encode($manufacturers); ?>;
								selectable_id = 'manufacturer_id';
								selectable_name = 'name';
							}
							for (var j = 0; j < selectable.length; j++) {
								if (resp['products'][i][selectable_id] == selectable[j][selectable_id]) {
									$('.editable.' + resp['products'][i]['product_id'] + '.' + resp['field']).html(selectable[j][selectable_name]);
									$('.editable.' + resp['products'][i]['product_id'] + '.' + resp['field']).html(selectable[j][selectable_name]).attr('data-' + resp['field'], resp['products'][i][selectable_id])
									break;
								}
							}								
						// everything else
						} else {
							$('.editable.' + resp['products'][i]['product_id'] + '.' + resp['field']).html(resp['products'][i][resp['field']]);
						}					
					}
				}
			}
		});
	}
	
	$('#form-product').on('dblclick', '.edit-td', function(e){
		if ($(this).find('.after-edit').size()) return;
		$('#form-product').on('selectstart', function (event) {
			event.preventDefault();
		});
		
		var pid = $(this).parents('tr').attr('data-id');
		var pdata = $(this).attr('data-key');
		
		if ((pdata.indexOf('image') == 0) || (pdata.indexOf('product_id', 0) == 0)) {
			// empty
		// status & shipping and subtract
		} else if (pdata == 'status' || pdata == 'shipping' || pdata == 'subtract') {
			var text_yes = '<?php echo $text_enabled; ?>';
			var text_no = '<?php echo $text_disabled; ?>';
			if (pdata=='shipping' || pdata=='subtract') {
				text_yes = '<?php echo $text_yes; ?>';	
				text_no = '<?php echo $text_no; ?>';
			}
 			$(this).find('span.editable').hide();
			var select_status = '<select name="status" data-key="' + pdata + '" data-id="' + pid + '" class="form-control after-edit">';
			if ($(this).find('span.editable').attr('data-' + pdata) == 1) {
				select_status += '<option value="1" selected="selected">' + text_yes + '</option>';
				select_status += '<option value="0">' + text_no + '</option>';	
			} else {
				select_status += '<option value="1">' + text_yes + '</option>';
				select_status += '<option value="0" selected="selected">' + text_no + '</option>';	
			}
			select_status += '</select>';
			$(this).append(select_status);
			$(this).parent().find('.after-edit').focus();
		} else if (pdata == 'tax_class' || pdata == 'weight_class' || pdata == 'stock_status' || pdata == 'manufacturer') {
			var select_select = '<select name="status" data-key="' + pdata + '" data-id="' + pid + '" class="form-control after-edit">';
			var selectable = <?php echo json_encode($tax_classes); ?>;
			var selectable_id = 'tax_class_id';
			var selectable_name = 'title';
			if (pdata == 'weight_class') {
				selectable = <?php echo json_encode($weight_classes); ?>;
				selectable_id = 'weight_class_id';
				selectable_name = 'title';
			} else if (pdata == 'stock_status') {
				selectable = <?php echo json_encode($stock_statuses); ?>;
				selectable_id = 'stock_status_id';
				selectable_name = 'name';	
			} else if (pdata == 'manufacturer') {
				selectable = <?php echo json_encode($manufacturers); ?>;
				selectable_id = 'manufacturer_id';
				selectable_name = 'name';
			}
			for (var i = 0; i < selectable.length; i++) {
				if ($(this).find('span.editable').attr('data-' + pdata) == selectable[i][selectable_id]) {
				  select_select += '<option value="' + selectable[i][selectable_id] + '" selected="selected">' + selectable[i][selectable_name] + '</option>';
			  } else {
				  select_select += '<option value="' + selectable[i][selectable_id] + '">' + selectable[i][selectable_name] + '</option>';
			  }
				
			}
			select_select +='</select>';
			$(this).find('span.editable').hide();
			$(this).append(select_select);
			$(this).parent().find('.after-edit').focus();
		// everything else
		} else {
			$(this).find('span.editable').hide();
			$(this).append('<input type="text" data-key="' + pdata + '" data-id="' + pid + '" class="form-control after-edit" value="' + $(this).find('span.editable').text() + '" />');
			$(this).parent().find('.after-edit').focus();
		}
		
	});

	function doSave(pid, pdata, pvalue) {
		$.ajax({
			url: "index.php?route=catalog/productmanager/updateproduct&token=<?php echo $token; ?>",
			type: "POST",
			dataType: "json",
			data: {
				pid: pid,
				pdata: pdata,
				pvalue: pvalue
			},
			success: function (resp) {
				if (resp['success']) {
					$('.after-edit').remove();
					// status & shipping & subtract        
          resp['product']['price'] = formatThousands(resp['product']['price']);
					if (resp['field']=='image') {
						var element = 'thumb-image' + resp['product_id'];
						$('#'+element).find('img').attr('width', '40px');
						$('#'+element).find('img').attr('height', '40px');
						$('#'+element).find('img').attr('src', resp['product_image']);
						$('.editable.' + resp['product_id'] + '.image_filename').html(resp['product']['image']);
					} else if (resp['field']=='status' || resp['field']=='shipping' || resp['field']=='subtract') {
						var text_yes = '<?php echo $text_enabled; ?>';
						var text_no = '<?php echo $text_disabled; ?>';
						
						if (resp['field']=='shipping' || resp['field']=='subtract') {
							text_yes = '<?php echo $text_yes; ?>';	
							text_no = '<?php echo $text_no; ?>';
						}
						
						if (resp['product'][resp['field']] == 0) {
							$('.editable.' + resp['product_id'] + '.' + resp['field']).html(text_no);
						} else {
							$('.editable.' + resp['product_id'] + '.' + resp['field']).html(text_yes);
						}
						$('.editable.' + resp['product_id'] + '.' + resp['field']).attr('data-' + resp['field'], resp['product'][resp['field']]);
					// quantity
					} else if (resp['field']=='quantity') {
						$('.editable.' + resp['product_id'] + '.' + resp['field']).removeClass("label-warning label-danger label-success");
						$('.editable.' + resp['product_id'] + '.' + resp['field']).html(resp['product'][resp['field']]);
						if (resp['product']['quantity'] <= 0) { 
							$('.editable.' + resp['product_id'] + '.' + resp['field']).addClass("label-warning");
						} else if (resp['product']['quantity'] <= 5) {
							$('.editable.' + resp['product_id'] + '.' + resp['field']).addClass("label-danger");
						} else { 
							$('.editable.' + resp['product_id'] + '.' + resp['field']).addClass("label-success");
						}
					// stock_status & manufacturer & weight_class & tax_class
					} else if (pdata == 'tax_class' || pdata == 'weight_class' || pdata == 'stock_status' || pdata == 'manufacturer') {
						var selectable = <?php echo json_encode($tax_classes); ?>;
						var selectable_id = 'tax_class_id';
						var selectable_name = 'title';
						if (pdata == 'weight_class') {
							selectable = <?php echo json_encode($weight_classes); ?>;
							selectable_id = 'weight_class_id';
							selectable_name = 'title';
						} else if (pdata == 'stock_status') {
							selectable = <?php echo json_encode($stock_statuses); ?>;
							selectable_id = 'stock_status_id';
							selectable_name = 'name';	
						} else if (pdata == 'manufacturer') {
							selectable = <?php echo json_encode($manufacturers); ?>;
							selectable_id = 'manufacturer_id';
							selectable_name = 'name';
						}
						
						for (var j = 0; j < selectable.length; j++) {
							if (resp['product'][selectable_id] == selectable[j][selectable_id]) {
								$('.editable.' + resp['product_id'] + '.' + resp['field']).html(selectable[j][selectable_name]);
								$('.editable.' + resp['product_id'] + '.' + resp['field']).html(selectable[j][selectable_name]).attr('data-' + resp['field'], resp['product'][selectable_id])
								break;
							}
						}													
					// everything else
					} else {
						$('.editable.' + resp['product_id'] + '.' + resp['field']).html(resp['product'][resp['field']]);            
					}
					$('.editable.' + resp['product_id'] + '.' + resp['field']).show();
				}
			}
		});
	}
	
	$('#form-product').on('blur', '.after-edit', function(e){
		var pid = $(this).attr('data-id');
		var pdata = $(this).attr('data-key');
		var pvalue = $(this).val();
		doSave(pid, pdata, pvalue);
	});
	
	$('#form-product').on('keydown', '.after-edit', function(e) {
		if (e.keyCode == 13) {
			e.stopPropagation();
			e.preventDefault();
			e.stopImmediatePropagation();
			this.blur();
		}
	});
	
	$('#form-product').on('click', 'a[data-toggle=\'image-manager\']', function(e) {
		e.preventDefault();
		var element = this;
		var parent = $(element).parent();
		
		$(element).popover({
			html: true,
			placement: 'right',
			trigger: 'manual',
			content: function() {
				return '<button type="button" class="btn btn-primary button-image-click"><i class="fa fa-pencil"></i></button> <button type="button" class="btn btn-danger button-clear-click"><i class="fa fa-trash-o"></i></button>';
			}
		});
		
		$(element).popover('toggle');		
	
		$('.button-image-click', parent).on('click', function() {
			$('#modal-image').remove();
	
			$.ajax({
				url: 'index.php?route=common/filemanager&token=' + getURLVar('token') + '&target=' + $(element).parent().find('input').attr('id') + '&thumb=' + $(element).attr('id'),
				dataType: 'html',
				beforeSend: function() {
					$('.button-image-click i', parent).replaceWith('<i class="fa fa-circle-o-notch fa-spin"></i>');
					$('.button-image-click', parent).prop('disabled', true);
				},
				complete: function() {
					$('.button-image-click i', parent).replaceWith('<i class="fa fa-upload"></i>');
					$('.button-image-click', parent).prop('disabled', false);
				},
				success: function(html) {
					$('body').append('<div id="modal-image" class="modal">' + html + '</div>');
					var pr_id = $(element).parents('tr').attr('data-id');
					$('body').attr('data-current-product-id', pr_id);
					
					$('#modal-image').modal('show');
				}
			});
	
			$(element).popover('hide');
		});
	
		$('.button-clear-click', parent).on('click', function() {
			var r = confirm("Are you sure that you want to remove the main product image?");
			if (r == true) {
				doSave($(element).parents('tr').attr('data-id'), 'image', '');
			}
			$(element).popover('hide');
		});
	});
	
	$(document).ajaxComplete(function(e, xhr, settings) {
	  	if (settings.url.toLowerCase().indexOf("common/filemanager") >= 0) {
			var pr_id = $('body').attr('data-current-product-id');
			$('a.thumbnail').on('click', function(e) {
				e.preventDefault();
				doSave(pr_id, 'image', $(this).parent().find('input').attr('value'));
				$('#modal-image').modal('hide');
			});
		}
	});
}
//--></script>
</div>
<?php echo $footer; ?>