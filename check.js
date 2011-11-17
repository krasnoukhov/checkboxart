var Check = {
  elems: {},
  current: 0,
  
  init: function() {
    $('#content').removeClass('start').addClass('movie').html('');    
    var BOX = BOXES[this.current];
    
    for(var i in BOX) {
      this.elems[i] = {};
      
      for(var j in BOX[i].items) {
        var el = $('<input type="checkbox" />');
        el.appendTo('#content');
        this.elems[i][j] = el[0];
      }

      $('<ins></ins>').appendTo('#content');
    }

    this.draw();
  },

  draw: function() {    
    var BOX = BOXES[this.current];
    
    for(var i in BOX) {
      for(var j in BOX[i].items) {        
        switch(BOX[i].items[j]) {
          case -1:
            this.elems[i][j].disabled = true;
            this.elems[i][j].checked = false;
            this.elems[i][j].className = '';
          break;
          case 1:
            this.elems[i][j].disabled = false;
            this.elems[i][j].checked = true;
            this.elems[i][j].className = '';
          break;
          case 0:
            this.elems[i][j].disabled = false;
            this.elems[i][j].checked = false;
            this.elems[i][j].className = '';
          break;
          default:
            this.elems[i][j].className = 'hidden';
          break;
        }
      }
    }

    setTimeout(function() {
      Check.step();
    }, 100);
  },
  
  step: function() {
   this.current++;
    if(!BOXES[this.current]) {
      this.current = 0;
    }
    
    this.draw();
  },
  
  el: function(id) {
    return document.getElementById(id)
  }
}