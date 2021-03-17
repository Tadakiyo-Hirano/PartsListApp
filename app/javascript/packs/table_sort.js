$(function() {
  $('.table-sortable').sortable({
    axis: 'y',
    items: '.item',

    // Ajaxで並び順のデータをコントローラーに送信
    update(e, ui) {
      let item = ui.item;
      let item_data = item.data();
      let params = { _method: 'POST' };
      params[item_data.model_name] = { row_order_position: item.index() };
      $.ajax({
        type: 'post',
        url: item_data.update_url,
        dataType: 'json',
        data: params,
      });
    },

    // ドラッグ幅をテーブルに合わせる
    // start(_e, ui) {
    //   let cells, tableWidth, widthForEachCell;
    //   tableWidth = $(this).width();
    //   cells = ui.item.children('td');
    //   widthForEachCell = tableWidth / cells.length + 'px';
    //   return cells.css('width', widthForEachCell);
    // },

    start(e, ui) {
      return ui.item.children('td').css('background-color', '#dee2e6');
    },

    // エフェクトを付与
    stop(e, ui) {
      return ui.item.children('td').css('background-color', '#fff').effect('highlight');
    },  
  });
});
